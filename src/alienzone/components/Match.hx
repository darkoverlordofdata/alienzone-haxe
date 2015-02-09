package alienzone.components;

import alienzone.match3.MatchObject;
class Match extends MatchObject {

    public var col:Int = 0;
    public var row:Int = 0;

    public inline function new(type:String, col:Int, row:Int) {
        super(type);
        this.col = col;
        this.row = row;
    }
}
