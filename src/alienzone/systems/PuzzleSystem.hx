package alienzone.systems;

import alienzone.components.Transform;
import alienzone.components.Match;
import alienzone.nodes.GemNode;
import alienzone.match3.Grid;
import ash.core.Entity;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
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
 *  Score
 *
 *	Sprite
 *	Match
 *		id
 *		x
 *		y
 *		col
 *		row
 *
 */
class PuzzleSystem extends System {

    public var container:FlxGroup;              //  the container of this system
    public var factory:EntityFactory;           //  create entities
    public var puzzle:Grid;                     //  the 7 x 6 puzzle grid

    private var gemNodes:NodeList<GemNode>;     //  gem nodes
    private var gems:Map<Int,Entity>;           //  Gems in active play

    /**
     * Initialize the player gameboard
     */
    public function new(container:FlxGroup, factory:EntityFactory) {
        super();
        this.factory = factory;
        this.container = container;
        gems = new Map();
    }
    
    override public function addToEngine(engine:Engine):Void {
        gemNodes = engine.getNodeList(GemNode);
        Reg.dropGem.add(dropped);
    }
    
    override public function removeFromEngine(engine:Engine):Void {
        gemNodes = null;
        gems = null;
        Reg.dropGem.remove(dropped);
        
    }

    override public function update(time:Float):Void {
    }


    /**
     * Recieve the dropped gems
     */
    private function dropped(gems:Array<Entity>) {
        
        var k:Int = 0;
        for (gem in gems) {
            var match:Match = gem.get(Match);
            var xform:Transform = new Transform(match.x, match.y);
            var moveto = {
                x: match.x,
                y: match.row * Res.GEMSIZE + (Res.GEMSIZE * 7)
            };
            gem.add(xform);
            k++;
            FlxTween.tween(xform, moveto, .75, {
                ease: FlxEase.bounceOut,
                complete: function(s) {
                    if (--k == 0) Reg.createGems.dispatch();
                }
            });
            this.gems[match.id] = gem;
        }
    }
}
