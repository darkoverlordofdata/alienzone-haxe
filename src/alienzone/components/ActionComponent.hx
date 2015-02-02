/**
 *--------------------------------------------------------------------+
 * ActionComponent.hx
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

class ActionComponent extends Component {

    public var name:String;

    public inline function new(name:String) {
        this.name = name;
    }
}
