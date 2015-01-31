/**
 *--------------------------------------------------------------------+
 * OpacityComponent.hx
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

class OpacityComponent extends Component {

    public var alpha:Float;

    public function new(alpha:Float) {
        super();
        this.alpha = alpha;
    }
}
