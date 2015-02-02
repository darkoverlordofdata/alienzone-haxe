package alienzone.components;
import hxE.Component;
import flixel.FlxObject;


class DisplayComponent extends Component {
// Simply store a display object to show!
    public var graphic:FlxObject;

    public inline function new(graphic:FlxObject) {
        super();
        this.graphic = graphic;
    }

}
