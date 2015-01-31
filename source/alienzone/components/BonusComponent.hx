/**
 *--------------------------------------------------------------------+
 * BonusComponent.hx
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

class BonusComponent extends Component {

    public var src:String;

    public function new(src:String) {
        super();
        this.src = src;
    }
}
