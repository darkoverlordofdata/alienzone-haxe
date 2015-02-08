/**
 *--------------------------------------------------------------------+
 * components/Action.hx
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014
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

class Player  {

    public var command:String;

    public inline function new(command:String="") {
        this.command = command;
    }
}
