package alienzone.systems;

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
 *	CommandNode
 *	    Player
 *	RenderGemNode
 *	    Match
 *	    Graphic
 *
 */
class InputPanelSystem extends System {

    public var container:FlxGroup;              //  the container of this system
    public var factory:EntityFactory;           //  create entities
    public var puzzle:Grid;                     //  the 7 x 6 puzzle grid

    private var player:NodeList<CommandNode>;   //  command input
    private var groupNodes:NodeList<GroupNode>; //  gem nodes
    private var uniqueId:Int;                   //  unique id for each gem
    private var gems:Array<Entity>;             //  gem entities
    private var rot:Int;                        //  rotate frame (0-3)
    private var pos:Int;                        //  horizontal cursor (0-4)
    private var known:Int;                      //  start off with set of 3 crystals
    private var discovered:Int;                 //  we discover the remaining crystals
    private var dropping:Bool;                  //  crystals being dropped?
    private var maps:Array<Array<Array<Array<Int>>>> = [    //  crystal rotation maps:
        [[[1,0],[0,0]], [[0,1],[0,0]], [[0,0],[0,1]], [[0,0],[1,0]]],
        [[[1,0],[2,0]], [[2,1],[0,0]], [[0,2],[0,1]], [[0,0],[1,2]]],
        [[[1,0],[2,3]], [[2,1],[3,0]], [[3,2],[0,1]], [[0,3],[1,2]]],
        [[[1,4],[2,3]], [[2,1],[3,4]], [[3,2],[4,1]], [[4,3],[1,2]]]
    ];


    /**
     * Initialize the player gameboard
     */
    public function new(container:FlxGroup, factory:EntityFactory) {
        super();
        this.factory = factory;
        this.container = container;
        uniqueId = 0;
        rot = 0;
        pos = 0;
        known = 2;
        discovered = 0;
        dropping = false;
        Reg.discoveredGems = [];
        for (i in 0...Res.GEMTYPES.length) {
            if (i < (discovered+known)) {
                Reg.discoveredGems.push(Res.GEMTYPES[i]);
            }
        }
        Reg.legend = known;
        createGems();
    }
    
    override public function addToEngine(engine:Engine):Void {
        player = engine.getNodeList(CommandNode);
        groupNodes = engine.getNodeList(GroupNode);
        Reg.createGems.add(createGems);
    }
    
    /**
     * Respond to the player's command
     */
    override public function update(time:Float):Void {

        for (node in player) {
            var command = node.command.command;
            node.command.command = '';
            switch (command) {
                case 'left':    move(-1);
                case 'down':    drop();
                case 'right':   move(1);
                case 'lrot':    rotate(-1);
                case 'rrot':    rotate(1);
            }
        }
    }

    override public function removeFromEngine(engine:Engine):Void {
        player = null;
        groupNodes = null;
        Reg.createGems.remove(createGems);
    }

    /**
     * create a gem group
     */
    private function createGems():Void {
        var i:Int = Std.int(Math.max(2, (Reg.legend+2)/2)-1);
        var cursor:Array<Array<Int>> = maps[i][0];
        rot = 0;
        pos = 0;
        gems = [];
        for (row in 0...2) {
            for (col in 0...2) {
                if (cursor[row][col] != 0) {
                    uniqueId += 1;
                    var frame:Int = Reg.rnd.nextInt(Reg.discoveredGems.length);
                    gems.push(factory.gem(uniqueId, gems.length, col, row, 'gem', frame));
                }
            }
        }
        dropping = false;
    }
    
    /**
     *  Move left or right
     */
    private function move(dir:Int):Void {
        var left:Int = 5;
        var right:Int = 0;
        
        for (gem in gems) {
            var match:Match = gem.get(Match);
            if (match.col < left) left = match.col;
            if (match.col > right) right = match.col;
        }
        
        if (dir == -1) {
            if (left <= 0) return;
        } else {
            if (right >= 5) return;
        }
        pos += dir;
        updateGems();
    }

    private function rotate(dir:Int):Void {
        if (pos>=5) return;
        rot += dir;
        if (rot < 0) rot = 3;
        if (rot > 3) rot = 0;
        updateGems();
    }

    private function updateGems():Void {

        var cursor:Array<Array<Int>> = maps[gems.length-1][rot];
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
     */
    private function drop():Void {
        if (dropping) return;
        dropping = true;

        var cols:Array<Int> = [0,0,0,0,0,0];
        // check how much room is needed to drop the gems
        for (gem in gems) {
            var match:Match = gem.get(Match);
            cols[match.col] += 1;
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
                    // TODO: check if we lost - i.e., no valid moves left
                    return;
                }
            }
        }

        // Move the gems to the Puzzle
        for (gem in gems) {
            var match:Match = gem.get(Match);
            gem.remove(Group);
            gem.add(new Puzzle(match.col, match.row));
        }
        Reg.dropGem.dispatch(gems);
    }
    

}
