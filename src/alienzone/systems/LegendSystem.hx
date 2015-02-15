package alienzone.systems;

import flixel.group.FlxGroup;
import alienzone.nodes.LegendNode;
import ash.tools.ListIteratingSystem;


class LegendSystem extends ListIteratingSystem<LegendNode> {

    public var container:FlxGroup;
    public var factory:EntityFactory;
    
    private var level:Int = 0;

    public function new(container:FlxGroup, factory:EntityFactory) {
        super(LegendNode, updateNode);
        this.factory = factory;
        this.container = container;
        Reg.upgrade.add(function(level:Int) {
            this.level = level;
        });
    }

    private function updateNode(node:LegendNode, time:Float):Void {
        
        if (node.level.value <= level) {
            node.transform.alpha = 1.0;
        } else {
            node.transform.alpha = 0.2;
        }
    
        node.graphic.animation.frameIndex = node.level.value;
        node.graphic.alpha = node.transform.alpha;
    
    }
}
