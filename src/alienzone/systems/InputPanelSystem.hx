package alienzone.systems;

import alienzone.states.GameOverState;
import alienzone.states.PlayState.GameType;
import flixel.util.FlxTimer;
import alienzone.match3.Piece;
import alienzone.match3.Grid;
import alienzone.components.Puzzle;
import alienzone.components.Group;
import alienzone.components.Match;
import alienzone.nodes.CommandNode;
import alienzone.nodes.GroupNode;
import ash.core.Entity;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;


/**
 * Input panel system:
 *
 * Handle user input to move a group of 1-4 gems on a 2 x 6
 * grid panel. A gem group occupies 2 - 4 adjacent cells.
 * Position and drop the group onto the puzzle grid panel.
 *
 *
 *    0   1   2   3   4   5
 *  +---+---+---+---+---+---+
 *  |   |   |   |   |   |   | 0
 *  +---+---+---+---+---+---+
 *  |   |   |   |   |   |   | 1
 *  +---+---+---+---+---+---+
 *
 *
 */
enum Direction {
    Left;
    Right;
}

class InputPanelSystem extends System {


    public var container:FlxGroup;              //  the container of this system
    public var factory:EntityFactory;           //  create entities
    public var puzzle:Grid;                     //  the 7 x 6 puzzle grid

    private var player:NodeList<CommandNode>;   //  command input
    private var groupNodes:NodeList<GroupNode>; //  gem nodes
    private var uniqueId:Int = 0;               //  unique id for each gem
    private var gems:Array<Entity>;             //  gem entities
    private var rot:Int;                        //  rotate frame (0-3)
    private var pos:Int;                        //  horizontal cursor (0-4)
    private var dropping:Bool;                  //  crystals being dropped?
    private var weight:Int = 0;
    private var flourish:Bool = false;
    private var flip:Bool = false;
    private var cursors:Array<Array<Array<Array<Int>>>> = [    //  crystal rotation maps:
        [[[1,0],[0,0]], [[0,1],[0,0]], [[0,0],[0,1]], [[0,0],[1,0]]],
        [[[1,0],[2,0]], [[2,1],[0,0]], [[0,2],[0,1]], [[0,0],[1,2]]],
        [[[1,0],[2,3]], [[2,1],[3,0]], [[3,2],[0,1]], [[0,3],[1,2]]],
        [[[1,4],[2,3]], [[2,1],[3,4]], [[3,2],[4,1]], [[4,3],[1,2]]]
    ];


    /**
     * Initialize the player input area
     *
     * @param [FlxGroup] container - top level gui container
     * @param [EntityFactory] factory - entity factory
     * @return new PuzzleSystem instance
     */
    public function new(container:FlxGroup, factory:EntityFactory) {
        super();
        this.factory = factory;
        this.container = container;
    }

    override public function addToEngine(engine:Engine):Void {

        /**
         * allocate resources
         */
        player = engine.getNodeList(CommandNode);
        groupNodes = engine.getNodeList(GroupNode);

        /**
         * initialize blackboard values
         */
        Reg.createGems.add(createGems);
        Reg.discoveredGems = [];
        for (i in 0...Res.GEMTYPES.length) {
            if (i < 3) {
                Reg.discoveredGems.push(Res.GEMTYPES[i]);
            }
        }
        Reg.level = Reg.discoveredGems.length-1;
        Reg.createGems.dispatch();
        Reg.scored.add(function(points:Int){
            flourish = true;
        });
        if (Reg.type == GameType.FTL) {
            Reg.timer.add(drop);
        }
    }

    override public function update(time:Float):Void {

        /**
         * Respond to the player's input
         */
        for (node in player) {
            var command = node.command.command;
            node.command.command = '';
            switch (command) {
                case 'left':    move(Direction.Left);
                case 'down':    drop();
                case 'right':   move(Direction.Right);
                case 'lrot':    rotate(Direction.Left);
                case 'rrot':    rotate(Direction.Right);
            }
        }
    }

    override public function removeFromEngine(engine:Engine):Void {

        /**
         * dispose the resources
         */
        Reg.createGems.removeAll();
        player = null;
        groupNodes = null;
    }

    /**
     * create a gem group
     * of 2, 3, or 4 gems
     *
     * @return none
     */
    public function createGems() {

        var i:Int = 1;
        
        switch (Reg.difficulty) {
        
            case 0:
                var pips:Array<Int> = [1,2,1,2,1,2,1,2];
                i = pips[Reg.level];
                if (weight>1) {
                    i -= 1;
                }
                weight -=1;

            case 1:
                var pips:Array<Int> = [1,1,1,1,1,2,2,3];
                i = pips[Reg.level];
                weight = (i>1) ? weight+1 : 0;
                if (weight>2) i -= (Reg.rnd.nextBool()) ? 0 : 1;

            case 2:
                var pips:Array<Int> = [1,1,1,2,2,2,2,3];
                i = pips[Reg.level];
                if (weight>1) {
                    i -= 1;
                    weight -=1;
                }

            default:
                var pips:Array<Int> = [1,1,1,1,2,2,3,0];
                i = pips[Reg.level];
                weight = (i>1) ? weight+1 : 0;
                if (weight>2) i -= (Reg.rnd.nextBool()) ? 0 : 1;

        }

        if (i<0) i=0;
        if (i>3) i=3;
        if (flip) {
            if (i == 1) {
                i = 2;
            } else if (i == 2) {
                i = 1;
            }
        }
        flip = !flip;
        
        var cursor:Array<Array<Int>> = cursors[i][0];
        rot = 0;
        pos = 0;
        gems = [];
        for (row in 0...2) {
            for (col in 0...2) {
                if (cursor[row][col] != 0) {
                    var frame:Int = Reg.rnd.nextInt(Reg.discoveredGems.length);
                    gems.push(factory.gem(++uniqueId, gems.length, col, row, 'gem', frame));
                }
            }
        }
        dropping = false;
        rot = 0;
        updateGems();
        var times = 0;
        if (flourish) {
            var dir:Direction = (Reg.rnd.nextBool()) ? Direction.Left : Direction.Right;
            new FlxTimer(0.1, function(Timer:FlxTimer):Void {
                    rotate(dir);
                    times++;
                    if (times == 4) Reg.reset.dispatch();
                }, 4);
        } else {
            Reg.reset.dispatch();
        }
        flourish = false;
    }

    /**
     *  Move left or right
     *
     * @param [Direction] dir Left or Right
     * @return none
     */
    private function move(dir:Direction):Void {
        var left:Int = 5;
        var right:Int = 0;

        for (gem in gems) {
            var match:Match = gem.get(Match);
            if (match.col < left) left = match.col;
            if (match.col > right) right = match.col;
        }

        if (dir == Direction.Left) {
            if (left <= 0) return;
        } else {
            if (right >= 5) return;
        }
        pos += (dir == Direction.Left) ? -1 : 1;
        updateGems();
    }

    /**
     *  Rotate left or right
     *
     * @param [Direction] dir Left or Right
     * @return none
     */
    private function rotate(dir:Direction):Void {
        if (pos>=5) return;
        rot += (dir == Direction.Left) ? -1 : 1;
        if (rot < 0) rot = 3;
        if (rot > 3) rot = 0;
        updateGems();
    }

    /**
     *  update the gem group display
     *
     * @return none
     */
    private function updateGems():Void {

        var cursor:Array<Array<Int>> = cursors[gems.length-1][rot];
        for (row in 0...2) {
            for (col in 0...2) {
                if (cursor[row][col] != 0) {
                    var x:Int = Std.int(Math.max(0, Math.min(5, pos+col)));
                    var gem:Entity = gems[cursor[row][col]-1];
                    var match:Match = gem.get(Match);
                    var moveto = {
                        x: x * Res.GEMSIZE,
                        y: row * Res.GEMSIZE
                    };
                    FlxTween.tween(match, moveto, 0.2);
                    match.col = x;
                    match.row = row;
                }
            }
        }
    }

    /**
     * Drop
     *
     * drop the gem group onto the puzzle
     * remove the group and add puzzle component
     * this moves the gems to the PuzzleSystem
     *
     * @return none
     */
    private function drop():Void {
        if (dropping) return;
        dropping = true; // disable dropping until this group completes

        var cols:Array<Int> = [0,0,0,0,0,0];
        var count:Int = 0;
        // check how much room is needed to drop the gems
        for (gem in gems) {
            var match:Match = gem.get(Match);
            cols[match.col] += 1;
            count += 1;
        }
        // will they fit?
        for (col in 0...6) {
            if (cols[col] > 0) {
                var k:Int = 0;
                var column:Array<Piece> = Reg.puzzle.getColumn(col, false);
                for (piece in column) {
                    k += (piece.object.type == Grid.emptyObject.type) ? 1 : 0;
                }
                if (k < cols[col]) {
                    dropping = false;
                    if (hasMove(count)) return;
                    // Game Over
                    FlxG.switchState(new GameOverState(Reg.type, Reg.score));

                }
            }
        }

        // Move the gems from Group to Puzzle
        for (gem in gems) {
            var match:Match = gem.get(Match);
            gem.remove(Group);
            gem.add(new Puzzle(match.col, match.row));
        }
        Reg.dropGem.dispatch(gems);
    }

    private function hasMove(count:Int):Bool {

        // TODO: check if player lost - i.e., has no valid moves
        return false;
    }
}
