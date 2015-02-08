package alienzone.systems;

import flixel.text.FlxBitmapTextField;
import flixel.group.FlxGroup;
import alienzone.nodes.LegendNode;
import ash.tools.ListIteratingSystem;


class LegendSystem extends ListIteratingSystem<LegendNode> {

    public var container:FlxGroup;
    public var factory:EntityFactory;

    public function new(container:FlxGroup, factory:EntityFactory) {
        super(LegendNode, updateNode);
        this.factory = factory;
        this.container = container;
    }

    private function updateNode(node:LegendNode, time:Float):Void {
        node.graphic.animation.frameIndex = node.level.value;
        node.graphic.alpha = node.alpha.alpha;
    
    }
}
