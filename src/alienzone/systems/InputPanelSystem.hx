package alienzone.systems;

import alienzone.components.Puzzle;
import alienzone.components.Group;
import alienzone.components.Match;
import flixel.tweens.FlxTween;
import ash.core.Entity;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import alienzone.nodes.CommandNode;
import alienzone.nodes.GroupNode;
import flixel.group.FlxGroup;


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

    private var player:NodeList<CommandNode>;   //  command input
    private var groupNodes:NodeList<GroupNode>; //  gem nodes
    private var uniqueId:Int;                   //  unique id for each gem
    private var gems:Array<Entity>;             //  gem entities
    private var rot:Int;                        //  rotate frame (0-3)
    private var pos:Int;                        //  horizontal cursor (0-4)
    private var offset:Int;                     //  display offset
    private var board:Int;                      //  level up board number
    private var count:Int;                      //  # of crystals
    private var known:Int;                      //  start off with set of 3 crystals
    private var discovered:Int;                 //  we discover the remaining crystals
    private var dropping:Bool;                  //  crystals being dropped?
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
        uniqueId = 0;
        rot = 0;
        pos = 0;
        offset = 0;
        board = 0;
        count = 2;
        known = 3;
        discovered = 0;
        dropping = false;
        discoveredGems = [];
        for (i in 0...Res.GEMTYPES.length) {
            if (i < (discovered+known)) {
                discoveredGems.push(Res.GEMTYPES[i]);
            }
        }
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
        var i:Int = Std.int(Math.max(2, (count+Reg.legend)/2)-1);
        var cursor:Array<Array<Int>> = maps[i][0];
        rot = 0;
        pos = 0;
        offset = 0;
        gems = [];
        for (row in 0...2) {
            for (col in 0...2) {
                if (cursor[row][col] != 0) {
                    uniqueId += 1;
                    var frame:Int = Reg.rnd.nextInt(discoveredGems.length);
                    gems.push(factory.gem(uniqueId, gems.length, col, row, 'gem', frame));
                }
            }
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
                    var gem:Entity = gems[cursor[row][col]-1];
                    var match:Match = gem.get(Match);
                    var moveto = {
                        x:  x * Res.GEMSIZE,
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
     * drop the gems onto the puzzle
     * remove the group component
     * add the puzzle component 
     * this moves it to the PuzzleSystem 
     *  
     */
    private function drop():Void {
        // Remove the gems from the input pannel
        for (gem in gems) {
            var match:Match = gem.get(Match);
            gem.remove(Group);
            gem.add(new Puzzle(match.col, match.row));
        }
        Reg.dropGem.dispatch(gems);
    }
    

}
