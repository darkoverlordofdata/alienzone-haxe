package alienzone.systems;

import alienzone.states.PlayState;
import alienzone.match3.Piece;
import alienzone.components.Display;
import alienzone.components.Transform;
import alienzone.components.Match;
import alienzone.nodes.GemNode;
import alienzone.match3.Grid;
import ash.core.Entity;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;


/**
 * Puzzle system:
 *
 * Puzzle area is a 7 x 6 grid. Gems are dropped here 
 * from the Input Panel. They fall into the grid, filling
 * it until a match of 3 or more is found, at which time
 * the grid is reduced by the match. Gravity is applied
 * recursively until no more matches are found.
 *
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
 *  
 *
 */
class PuzzleSystem extends System {

    public var container:FlxGroup;              //  the container of this system
    public var factory:EntityFactory;           //  create entities

    private var gemNodes:NodeList<GemNode>;     //  gem nodes
    private var gems:Map<Int,Entity>;           //  Gems in active play
    private var board:Int;                      //  level up board number

    /**
     * Initialize the puzzle area
     *
     * @param [FlxGroup] container - top level gui container
     * @param [EntityFactory] factory - entity factory
     * @return new PuzzleSystem instance
     */
    public function new(container:FlxGroup, factory:EntityFactory) {
        super();
        this.factory = factory;
        this.container = container;
        board = 0;
        gems = new Map();
    }
    
    override public function addToEngine(engine:Engine):Void {
        gemNodes = engine.getNodeList(GemNode);
        Reg.dropGem.add(dropped);
    }
    
    override public function removeFromEngine(engine:Engine):Void {
        Reg.dropGem.removeAll();
        gemNodes = null;
        gems = null;
    }

    override public function update(time:Float):Void {
    }


    /**
     * Recieve the dropped gems
     *
     * @param [Array] gems - array of gem entities
     * @return none
     */
    private function dropped(gems:Array<Entity>) {
        var dropped:Int = 0;
        for (row in [1,0]) {
            for (gem in gems) {
                var match:Match = gem.get(Match);
                if (match.row == row) {
                    var xform:Transform = new Transform(match.x, match.y);
                    // Get the gem column
                    var column:Array<Piece> = Reg.puzzle.getColumn(match.col, false);
                    // Get the last empty piece to place the gem
                    var lastEmpty:Piece = Grid.getLastEmptyPiece(column);
                    // If an empty piece has been found
                    if (lastEmpty != null) {
                        // Bind this gem to the piece
                        lastEmpty.object = match;
                        // And make it fall
                        gem.add(xform);
                        var moveto = {
                            x:  lastEmpty.x * Res.GEMSIZE,
                            y:  lastEmpty.y * Res.GEMSIZE + 2 * Res.GEMSIZE
                        };
                        FlxTween.tween(xform, moveto, .75, {
                            ease: FlxEase.bounceOut,
                            complete: function(s) {
                                if (++dropped == gems.length) {
                                    handleMatches();
                                }
                            }
                        });
                        this.gems[match.id] = gem;
                    }
                }
            }
        }
    }

    /**
     * Handle Matches
     * recursively process matching pieces
     *
     * @return none
     */
    private function handleMatches():Void {

        var piecesToUpgrade:Array<String>;
        var matches:Array<Array<Piece>> = Reg.puzzle.getMatches();

        /**
         * Add to score for all the matches, them
         * delete the matching tiles.
         */
        if (matches.length != 0) {
            piecesToUpgrade = [];
            Reg.puzzle.forEachMatch(function(matchingPieces:Array<Piece>, type:String){
                updateScore(matchingPieces, type);
                piecesToUpgrade.push(type);
                for (matchingPiece in matchingPieces) {
                    var match:Match = cast(matchingPiece.object, Match);
                    var gem:Entity = gems[match.id];
                    var sprite = gem.get(Display).graphic;
                    sprite.destroy();
                }
            });
            Reg.puzzle.clearMatches();
            upgrade(piecesToUpgrade);
        }
        
        var fallingPieces:Array<Piece> = Reg.puzzle.applyGravity();
        var hasFall:Int = 0;

        /**
         * Fill in the tiles that were opened up
         * when we scored.
         */
        if (fallingPieces.length > 0) {
            for (piece in fallingPieces) {
                var match:Match = cast(piece.object, Match);
                var gem:Entity = gems[match.id];
                var xform:Transform = gem.get(Transform);
                var moveto = {
                    x:  piece.x * Res.GEMSIZE,
                    y:  piece.y * Res.GEMSIZE + 2 * Res.GEMSIZE
                };
                FlxTween.tween(xform, moveto, .75, {
                ease: FlxEase.bounceOut,
                complete: function(s) {
                    if (++hasFall == fallingPieces.length) {
                        handleMatches();
                    }
                }
                });
            }
        } else {
            Reg.createGems.dispatch();
        }

    }


    /**
     * Upgrade
     *
     * @param [Array] piecesToUpgrade - array of oieces
     * @return none
     */
    private function upgrade(piecesToUpgrade:Array<String>) {

        var levelUp:Bool = false;
        for (type in piecesToUpgrade) {
            var upgradeIndex:Int = Res.GEMTYPES.indexOf(type) + 1;
            
            if (upgradeIndex >= Res.GEMTYPES.length) {
            /**
             * Level Up...
             */
                FlxG.switchState(new PlayState(Reg.type, Reg.score));
            }

            
            if (Reg.level < upgradeIndex) {
                levelUp = true;
                Reg.level = upgradeIndex;
            }
            var upgradedType:String = Res.GEMTYPES[upgradeIndex];
            if (upgradedType != null) {
                if (Reg.discoveredGems.indexOf(upgradedType) == -1)
                    Reg.discoveredGems.push(upgradedType);
            }
            //}
        }
        if (levelUp)
            board += 1;
    }

    /**
     * Update the score
     *
     * @param [Array] matches - array of matching gems
     * @param [String] type - gem type name
     * @return none
     */
    private function updateScore(matches:Array<Piece>, type:String):Void {
        var points:Int = (Res.GEMTYPES.indexOf(type) + 1) * matches.length * (board+1);
        Reg.updateScore(points);
    }


}
