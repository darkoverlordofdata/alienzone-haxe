package alienzone.systems;

import alienzone.components.Transform;
import ash.core.Entity;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import alienzone.nodes.CommandNode;
import alienzone.nodes.GemNode;
import flixel.group.FlxGroup;
import alienzone.match3.MatchObject;
import alienzone.match3.Piece;
import alienzone.match3.Grid;


/**
 * Input control system:
 *
 * Move a group of 1-4 gems on a 2 x 6 grid.
 * A gem group occupies 2 or 4 adjacent cells.
 * Position and drop the group onto the puzzle area.
 * Puzzle area is a 7 x 6 grid
 *
 *    0   1   2   3   4   5
 *  +---+---+---+---+---+---+
 *  |   |   |   |   |   |   | 0
 *  +---+---+---+---+---+---+
 *  |   |   |   |   |   |   | 1
 *  +---+---+---+---+---+---+
 *  +===+===+===+===+===+===+
 *  |   |   |   |   |   |   | 0
 *  +---+---+---+---+---+---+
 *  |   |   |   |   |   |   | 1
 *  +---+---+---+---+---+---+
 *  |   |   |   |   |   |   | 2
 *  +---+---+---+---+---+---+
 *  |   |   |   |   |   |   | 3
 *  +---+---+---+---+---+---+
 *  |   |   |   |   |   |   | 4
 *  +---+---+---+---+---+---+
 *  |   |   |   |   |   |   | 5
 *  +---+---+---+---+---+---+
 *  |   |   |   |   |   |   | 6
 *  +---+---+---+---+---+---+
 */

class PlayerSystem extends System {

    public var container:FlxGroup;              //  the container of this system
    public var factory:EntityFactory;           //  create entities
    public var puzzle:Grid;                     //  the 7 x 6 puzzle grid

    private var player:NodeList<CommandNode>;   //  command input
    private var gemNodes:NodeList<GemNode>;     //  gem nodes
    private var gems:Array<Entity>;             //  gem entities
    private var rot:Int = 0;                    //  rotate frame (0-3)
    private var pos:Int = 0;                    //  horizontal cursor (0-4)
    private var offset:Int = 0;                 //  display offset
    private var board:Int = 0;                  //  level up board number
    private var count:Int = 2;                  //  # of crystals
    private var known:Int = 3;                  //  start off with set of 3 crystals
    private var discovered:Int = 0;             //  we discover the remaining crystals
    private var dropping:Bool = false;          //  crystals being dropped?
    private var discoveredGems:Array<String>;   //  all the discovered crystals
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
        discoveredGems = [];
        for (i in 0...Res.GEMTYPES.length) {
            if (i < (discovered+known)) {
                discoveredGems.push(Res.GEMTYPES[i]);
            }
        }
        puzzle = new Grid(6, 7, 'down');

    }
    
    override public function addToEngine(engine:Engine):Void {
        player = engine.getNodeList(CommandNode);
        gemNodes = engine.getNodeList(GemNode);
        createGems();
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
        gemNodes = null;
    }

    /**
     * create a gem group
     */
    private function createGems():Void {
        var i:Int = Std.int(Math.max(2, (count+Reg.legend)/2)-1);
        var cursor:Array<Array<Int>> = maps[i][0];
        rot = 0;
        pos = 0;
        offset = 0;
        gems = [];
        for (row in 0...2) {
            for (col in 0...2) {
                if (cursor[row][col] != 0) {
                    var frame:Int = Reg.rnd.nextInt(discoveredGems.length);
//                    var frame:Int = Std.int(Math.random() * discoveredGems.length);
                    gems.push(factory.gem(col, row, 'gem', frame));
                }
            }
        }
    }
    
    private function move1(dir:Int):Void {
        for (gem in gemNodes) {
            gem.match.col = gem.match.col + dir;
            if (gem.match.col < 0) gem.match.col = 0;
            if (gem.match.col > 5) gem.match.col = 5;
            gem.transform.x = gem.match.col * Res.GEMSIZE;
        }
    }

    private function move(dir:Int):Void {
        if (pos+dir >= 0 && pos+dir <=5) {
            pos += dir+offset;
            offset = 0;
            updateGems();
            return;
        }

        if (pos+dir < 0) {
            if (gems.length == 2 && rot == 2) {
                offset = -1;
                updateGems();
                return;
            }
        }
    }

    private function rotate(dir:Int):Void {
        if (offset == -1) return;
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
                    var x:Int = Std.int(Math.max(0, Math.min(5, pos+col+offset)));
                    var transform:Transform = gems[cursor[row][col]-1].get(Transform);
                    transform.x = x * Res.GEMSIZE;
                    transform.y = row * Res.GEMSIZE;
                }            
            }
        }
    }

    /**
     * Drop
     *
     * drop the gems onto the puzzle
     */
    private function drop():Void {
        if (dropping) return;
        dropping = true;
        
        var dropped:Int = 0;
        var cursor:Array<Array<Int>> = maps[gems.length-1][rot];
        
        
        
    }
    
        
    private function updateScore(matches:Array<Gem>, type:String) {
        var points:Int = (Res.GEMTYPES.indexOf(type) + 1) * matches.length * (board+1);
        Reg.updateScore(points);
    }

    public function gameOver() {
    }


}
