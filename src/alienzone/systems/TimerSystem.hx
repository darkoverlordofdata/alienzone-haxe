package alienzone.systems;

import alienzone.nodes.TimerNode;
import ash.tools.ListIteratingSystem;
import flixel.text.FlxBitmapTextField;
import flixel.group.FlxGroup;


class TimerSystem extends ListIteratingSystem<TimerNode> {

    public var container:FlxGroup;
    public var factory:EntityFactory;
    
    private var reset:Bool = true;
    private var countdown:Float = 0;

    public function new(container:FlxGroup, factory:EntityFactory) {
        super(TimerNode, updateNode);
        this.factory = factory;
        this.container = container;
        Reg.reset.add(function(){
            reset = true;
        });
    }

    private function updateNode(node:TimerNode, time:Float):Void {
        if (reset) {
            countdown = node.time.seconds;
            reset = false;
        }
        
        countdown -= time;

        if (countdown >= 0) {
            var d1:Int = Std.int(countdown*10);
            var d2:Int = d1%10;
            d1 = Std.int(d1/10);

            var txt:FlxBitmapTextField = cast(node.graphic, FlxBitmapTextField);
            txt.text = '$d1:$d2';
        } else {
            Reg.timer.dispatch();
        }
    }
}
