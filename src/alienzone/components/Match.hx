package alienzone.components;

import alienzone.match3.MatchObject;
class Match extends MatchObject {

    public var x(get_x, set_x):Int;             // Display at x
    public var y(get_y, set_y):Int;             // Display at y
    public var col:Int;       // Grid column
    public var row:Int;       // Grid row
    public var id:Int = 0;                      // UniqueID
    public var index:Int = 0;                   // Group index

    private var _x:Int = -1;                    // initial state
    private var _y:Int = -1;                    // initial state
    private var _col:Int;
    private var _row:Int;


    public inline function new(type:String, id:Int, index:Int, col:Int, row:Int) {
        super(type);
        this.id = id;
        this.col = col;
        this.row = row;
        this.index = index;
        
    }

    /**
     * Stateful Getters
     * Return calculated x/y until they've been set
     */
    private inline function get_x():Int {
        return (_x == -1) ? col * Res.GEMSIZE : _x;
    }

    private inline function set_x(x:Int):Int {
        return _x = x;
    }

    private inline function get_y():Int {
        return (_y == -1) ? row * Res.GEMSIZE : _y;
    }

    private inline function set_y(y:Int):Int {
        return _y = y;
    }

}
