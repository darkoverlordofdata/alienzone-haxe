package alienzone.components;
import hxE.Component;

class DirectionComponent extends Component {

    public var angle:Float;
    public var angularVelocity:Float;

    public function new()
    {
        super();

        angle = 0.0;
        angularVelocity = 0.0;
    }
}
