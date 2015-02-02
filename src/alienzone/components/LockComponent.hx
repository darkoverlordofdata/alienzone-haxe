/**
 *--------------------------------------------------------------------+
 * LockComponent.hx
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
import hxE.Component;

class LockComponent extends Component {

    public var value:Bool;

    public inline function new(value:Bool) {
        this.value = value;
    }
}
