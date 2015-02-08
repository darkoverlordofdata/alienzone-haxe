package alienzone.systems;

import ash.tools.ListIteratingSystem;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import alienzone.nodes.CommandNode;
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

class PlayerSystem extends ListIteratingSystem<CommandNode> {
    private var nodes:NodeList<CommandNode>;
    public var container:FlxGroup;
    public var factory:EntityFactory;
    public var puzzle:Grid;             //  the 7 x 6 puzzle grid

    private var rot:Int = 0;            //  rotate frame (0-3)
    private var pos:Int = 0;            //  horizontal cursor (0-4)
    private var offset:Int = 0;         //  display offset
    private var board:Int = 0;          //  level up board number
    private var count:Int = 2;          //  # of crystals
    private var known:Int = 3;          //  start off with set of 3 crystals
    private var discovered:Int = 0;     //  we discover the remaining crystals
    private var dropping:Bool = false;  //  crystals being dropped?
    private var discoveredGems:Array<String>;   //  all the discovered crystals
    private var gems:Array<Gem>;        //  group of crystals that move on the top board
    private var maps:Array<Array<Array<Array<Int>>>> = [    //  crystal rotation maps:
        [[[1,0],[0,0]], [[0,1],[0,0]], [[0,0],[0,1]], [[0,0],[1,0]]],
        [[[1,0],[2,0]], [[2,1],[0,0]], [[0,2],[0,1]], [[0,0],[1,2]]],
        [[[1,0],[2,3]], [[2,1],[3,0]], [[3,2],[0,1]], [[0,3],[1,2]]],
        [[[1,4],[2,3]], [[2,1],[3,4]], [[3,2],[4,1]], [[4,3],[1,2]]]
    ];


    public function new(container:FlxGroup, factory:EntityFactory) {
        super(CommandNode, updateNode);
        this.factory = factory;
        this.container = container;
        discoveredGems = [];
        for (i in 0...Gem.GEMTYPES.length) {
            if (i < (discovered+known)) {
                discoveredGems.push(Gem.GEMTYPES[i]);
            }
        }
        puzzle = new Grid(6, 7, 'down');
        createGems();
        
    }
    
    private function updateNode(node:CommandNode, time:Float):Void {
        var command = node.command.command;
        node.command.command = '';
        switch (command) {
            case 'left': move(-1);
            case 'down': move(1);
            case 'right': drop();
            case 'lrot': rotate(-1);
            case 'rrot': rotate(1);
        }
    }

    public function gameOver() {
    }

    private function createGems():Void {
        var i:Int = Std.int(Math.max(2, ((count+Reg.legend)/2))-1);
        var cursor:Array<Array<Int>> = maps[i][0];
        gems = [];
        rot = 0;
        pos = 0;
        offset = 0;
        for (row in 0...2) {
            for (col in 0...2) {
                var frame:Int = Std.int(Math.random() * discoveredGems.length);
                factory.gem(col, row, 'images/gems.png', frame);
                gems.push(new Gem(this, Gem.GEMTYPES[frame], col, row));
            }
        }
        updateGems();
    }

    private function move(dir:Int):Void {
    }

    private function drop():Void {
    }

    private function rotate(dir:Int):Void {
    }

    private function updateGems() {
    }

    private function updateScore(matches:Array<Gem>, type:String) {
        var points:Int = (Gem.GEMTYPES.indexOf(type) + 1) * matches.length * (board+1);
        Reg.updateScore(points);
    }

}
