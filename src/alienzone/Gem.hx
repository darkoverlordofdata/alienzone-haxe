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
class Gem extends MatchObject {

    public static var GEMSIZE:Int    = 48;          // Gem size constant in pixels
    public static var MARGINTOP:Int  = 2;           // Margin top equal to 2 gems height
    public static var GEMTYPES:Array<String> = [    // All gem types:
        "blue",
        "cyan",
        "green",
        "magenta",
        "orange",
        "pink",
        "red",
        "yellow"
    ];
    private var x:Int;
    private var y:Int;
    private var sprite:FlxSprite;
    private var player:PlayerSystem;

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
    public function new(player:PlayerSystem, type:String, x:Int, y:Int) {
        super(type);
        this.player = player;
        this.x = x;
        this.y = y;
        
        sprite = new FlxSprite(0, 0, 'images/gems.png');
        sprite.animation.add('gem', [0, 1, 2, 3, 4, 5, 6, 7]);
        sprite.animation.frameIndex = GEMTYPES.indexOf(type);

        move(x,y);
    }

    /**
     * Move method
     *
     * param  [Number]  x coordinate
     * param  [Number]  y coordinate
     * returns none
     */
    public function move(x:Int, y:Int):Void {
        this.x = x;
        this.y = y;
        sprite.x = x * GEMSIZE;
        sprite.y = y * GEMSIZE;
    }

    /**
     * Drop method
     *
     * param  [Function]  next function
     * returns none
     */
    public function drop(next):Void {

        var column:Array<Piece> = player.puzzle.getColumn(x, false);
        var lastEmpty:Piece = Grid.getLastEmptyPiece(column);
        
        if (lastEmpty != null) {
            lastEmpty.object = this;
            fall(lastEmpty.x, lastEmpty.y, next);
        } else {
            player.gameOver();
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
    public function fall(x:Int, y:Int, next):Void {

        var point = {
            x: x * GEMSIZE,
            y: y * GEMSIZE + MARGINTOP * GEMSIZE
        };

        FlxTween.tween(sprite, point, 1, {
            type:FlxTween.ONESHOT, 
            ease:FlxEase.bounceOut, 
            complete:next
        });
    }



}
