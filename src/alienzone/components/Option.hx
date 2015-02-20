/**
 *--------------------------------------------------------------------+
 * components/Option.hx
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
 */
package alienzone.components;

class Option  {

    public var name:String;
    public var enabled:Bool;

    public inline function new(name:String, enabled:Bool) {
        this.name = name;
        this.enabled = enabled;
    }
}
