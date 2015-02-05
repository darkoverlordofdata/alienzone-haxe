package alienzone.match3;
class Point {

    public var x:Int;
    public var y:Int;
    
    public inline function new(x:Int, y:Int) {
        this.x = x;
        this.y = y;
    }

    public function toString() {
        return 'match3.Point($x, $y)';
    }
}
