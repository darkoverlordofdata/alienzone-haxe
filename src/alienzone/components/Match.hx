package alienzone.components;

import alienzone.match3.MatchObject;
class Match extends MatchObject {

    public var x:Int;           // Display at x
    public var y:Int;           // Display at y
    public var col:Int;         // Grid column (0-5)
    public var row:Int;         // Grid row  (0-6)
    public var id:Int = 0;      // UniqueID
    public var index:Int = 0;   // Gem Group index (0-3)

    public inline function new(id:Int, type:String, size:Int, index:Int, col:Int, row:Int) {
        super(type);
        this.id = id;
        this.col = col;
        this.row = row;
        this.index = index;
        x = col * size;
        y = row * size;
        
    }

}
