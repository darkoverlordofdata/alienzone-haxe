package alienzone.components;


class Sprite {

    public var x:Int;
    public var y:Int;
    public var key:String;
    public var frame:Int;

    public inline function new(x:Int, y:Int, key:String, frame:Int=0) {
        this.x = x;
        this.y = y;
        this.key = key;
        this.frame = frame;
    }

}
