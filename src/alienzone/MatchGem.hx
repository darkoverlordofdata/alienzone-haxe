package alienzone;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween;
import alienzone.match3.Grid;
import alienzone.match3.Grid;
import alienzone.match3.Piece;
import alienzone.systems.PlayerSystem;
import flixel.FlxSprite;
import alienzone.match3.MatchObject;

/**
 * Gem Class -
 *
 * a bridge to the Match3 game logic module
 */
class MatchGem extends MatchObject {

    /**
     * == New Gem ==
     *   * Set the sprite
     *   * Set the initial position
     *
     * param  [Phaser.GameState]  parent object
     * param  [String]  gem type
     * param  [Number]  x coordinate
     * param  [Number]  y coordinate
     * returns this
     */
    public function new(type:String) {
        super(type);
        
    }

    /**
     * Drop method
     *
     * param  [Function]  next function
     * returns none
     */
    public function drop(puzzle:Grid, x:Int, next):Bool {

        var column:Array<Piece> = puzzle.getColumn(x, false);
        var lastEmpty:Piece = Grid.getLastEmptyPiece(column);
        
        if (lastEmpty != null) {
            lastEmpty.object = this;
            //fall(lastEmpty.x, lastEmpty.y, next);
            return true;
        } else {
            return false;
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
//    private function fall(x:Int, y:Int, next):Void {
//
//        var point = {
//            x: x * GEMSIZE,
//            y: y * GEMSIZE + MARGINTOP * GEMSIZE
//        };
//
//        FlxTween.tween(sprite, point, 1, {
//            type:FlxTween.ONESHOT, 
//            ease:FlxEase.bounceOut, 
//            complete:next
//        });
//    }



}
