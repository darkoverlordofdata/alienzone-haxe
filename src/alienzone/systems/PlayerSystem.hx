package alienzone.systems;

import alienzone.components.Match;
import flixel.FlxSprite;
import alienzone.components.Display;
import alienzone.components.Display;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import ash.core.Entity;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import alienzone.nodes.CommandNode;
import alienzone.nodes.GroupNode;
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
    private var gemNodes:NodeList<GroupNode>;     //  gem nodes
    private var uniqueId:Int;                   //  unique id for each gem
    private var gemx:Map<Int,Entity>;           //  gem index in cursor group
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
        puzzle = new Grid(6, 7, 'down');
        gemx = new Map();
    }
    
    override public function addToEngine(engine:Engine):Void {
        player = engine.getNodeList(CommandNode);
        gemNodes = engine.getNodeList(GroupNode);
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
                    uniqueId += 1;
                    var frame:Int = Reg.rnd.nextInt(discoveredGems.length);
                    gemx[uniqueId] = factory.gem(uniqueId, gems.length, col, row, 'gem', frame);
                    gems.push(gemx[uniqueId]);
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
                    //var xform:Transform = gem.get(Transform);
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
     */
    private function drop():Void {
        if (dropping) return;
        dropping = true;
        
        var dropped:Int = 0;
        var cursor:Array<Array<Int>> = maps[gems.length-1][rot];
        /**
         * take off in the reverse order
         */
        for (row in [1, 0]) {
            for (col in [1, 0]) {
                if (cursor[row][col] != 0) {
                    dropEach(gems[cursor[row][col]-1], function(s) {
                        dropped += 1;
                        // If all gems have been dropped
                        if (dropped == gems.length) {
                            handleMatches();
                            dropping = false;
                        }
                    });
                }
            }
        }
    }
    
    private function dropEach(gem:Entity, next):Void {
        // Get the gem column
        var match:Match = gem.get(Match);
        var column:Array<Piece> = puzzle.getColumn(match.col, false);
        // Get the last empty piece to place the gem
        var lastEmpty:Piece = Grid.getLastEmptyPiece(column);
        // If an empty piece has been found
        if (lastEmpty != null) {
            // Bind this gem to the piece
            lastEmpty.object = match;
            // And make it fall
            fall(lastEmpty.x, lastEmpty.y, gem, next);
        } else {
            gameOver();
        }
    }

    /**
     * Fall method
     *
     * param  [Number]  x coordinate
     * param  [Number]  y coordinate
     * param  [Function]  next function
     * returns none
     */
    private function fall(x:Int, y:Int, gem:Entity, next):Void {
        var match:Match = gem.get(Match);
        var moveto = {
            x:  x * Res.GEMSIZE,
            y:  y * Res.GEMSIZE + 2 * Res.GEMSIZE
        };
        FlxTween.tween(match, moveto, 0.75, {complete: next, ease: FlxEase.bounceOut});
    }

    /**
     * Update the score
     * 
     * @param [Array] matches - array of matching gems
     * @param [String] type - gem type name 
     */
    private function updateScore(matches:Array<Piece>, type:String):Void {
        var points:Int = (Res.GEMTYPES.indexOf(type) + 1) * matches.length * (board+1);
        Reg.updateScore(points);
    }

    /**
     * :(
     *
     */
    public function gameOver() {
    }

    private function handleMatches():Void {

        var piecesToUpgrade:Array<String>;
        var matches:Array<Array<Piece>> = puzzle.getMatches();
        
        if (matches.length != 0) {
            piecesToUpgrade = [];
            puzzle.forEachMatch(function(matchingPieces:Array<Piece>, type:String){
                updateScore(matchingPieces, type);
                piecesToUpgrade.push(type);
                for (matchingPiece in matchingPieces) {
                    var match:Match = cast(matchingPiece.object, Match);
                    var gem:Entity = gemx[match.id];
                    trace('$match');
                    var sprite = gem.get(Display).graphic;
                    sprite.destroy();
//                    gem.remove(Transform);
//                    gem.remove(Display);

//                    FlxTween.color(sprite, 0.15, 0, 0, 1, 0, {
//                        type:FlxTween.LOOPING,
//                        loopDelay: 0.15,
//                        ease:FlxEase.sineInOut,
//                        complete:function(s:FlxTween) {
//                            sprite.destroy();
//                        }
//                    });
                
                }
            });
            puzzle.clearMatches();
            handleUpgrade(piecesToUpgrade);
        }
        handleFalling();
    }

    /**
     * Handle Falling
     * Apply gravity and get falling Pieces
     */
    private function handleFalling() {
        var fallingPieces:Array<Piece> = puzzle.applyGravity();
        var hasFall:Int = 0;

        if (fallingPieces.length > 0) {
            trace('fallingPieces.length = ${fallingPieces.length}');
            hasFall = 0;
            for (piece in fallingPieces) {
                var match:Match = cast(piece.object, Match);
                var gem:Entity = gems[match.index];
                fall(Std.int(match.x), Std.int(match.y), gem, function(s) {
                    hasFall += 1;
                    if (hasFall == fallingPieces.length) {
                        handleMatches();
                    }
                });
            }
        } else {
            createGems();
        }
    }

    /**
     * Handle Upgrade
     *
     * return none
     */
    private function handleUpgrade(piecesToUpgrade:Array<String>) {

        var levelUp:Bool = false;
        for (type in piecesToUpgrade) {
            var upgradeIndex:Int = Res.GEMTYPES.indexOf(type) + 1;
            
            trace()
            
            if (upgradeIndex >= Res.GEMTYPES.length) {
            /**
             * Level Up...
             */
            }
            
            if (Reg.legend < upgradeIndex) {
                levelUp = true;
            }

            Reg.legend = upgradeIndex;
            var upgradedType:String = Res.GEMTYPES[upgradeIndex];
            if (upgradedType != null) {
                if (discoveredGems.indexOf(upgradedType) == -1)
                    discoveredGems.push(upgradedType);
            }
        }
        if (levelUp)
            board += 1;
    }


}
