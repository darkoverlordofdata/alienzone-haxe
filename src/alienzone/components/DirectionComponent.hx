package alienzone.components;
import hxE.Component;

class DirectionComponent extends Component {

    public var angle:Float;
    public var angularVelocity:Float;

    public inline function new() {
        angle = 0.0;
        angularVelocity = 0.0;
    }
}
