/**
 *--------------------------------------------------------------------+
 * MatchObject.hx
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
class MatchObject {

    public var type:String;

    public inline function new(type:String="__empty__") {
        this.type = type;
    }
}
