package alienzone.components;
class GameState {

    public var lives:Int = 3;
    public var level:Int = 0;
    public var points:Int = 0;

    public inline function new(level:Int = 0, lives:Int = 3, points:Int = 0) {
        this.level = level;
        this.lives = lives;
        this.points = points;
    }
}
