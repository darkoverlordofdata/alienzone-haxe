package alienzone.components;
import hxE.Component;

class SpriteComponent extends Component {

    public var x:Int;
    public var y:Int;
    public var key:String;
    public var frame:Int;

    
    public function new(x:Int, y:Int, key:String, frame:Int=0) {
        super();
        this.x = x;
        this.y = y;
        this.key = key;
        this.frame = frame;
    }

}
