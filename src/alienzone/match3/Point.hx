/**
 *--------------------------------------------------------------------+
 * Point.hx
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014-2015
 *--------------------------------------------------------------------+
 *
 * This file is a part of Alien Zone
 *
 * Alien Zone is free software; you can copy, modify, and distribute
 * it under the terms of the GPLv3 License
 *
 *--------------------------------------------------------------------+
 *
 *
 * @see https://github.com/hugeen/jmatch3
 */
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
