package alienzone.components;


class Puzzle {

    public var col:Int;
    public var row:Int;
    public var init:Bool = true;

    public inline function new(col:Int = 0, row:Int = 0) {
        this.col = col;
        this.row = row;

    }
}
