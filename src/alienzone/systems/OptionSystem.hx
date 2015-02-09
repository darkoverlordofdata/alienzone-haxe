package alienzone.systems;

import flixel.group.FlxGroup;
import alienzone.nodes.OptionNode;
import ash.tools.ListIteratingSystem;


class OptionSystem extends ListIteratingSystem<OptionNode> {

    public var container:FlxGroup;
    public var factory:EntityFactory;

    public function new(container:FlxGroup, factory:EntityFactory) {
        super(OptionNode, updateNode);
        this.factory = factory;
        this.container = container;
    }

    private function updateNode(node:OptionNode, time:Float):Void {
        if (node.option.enabled) {
            node.graphic.animation.frameIndex = 1;
            node.graphic.alpha = 1.0;
            Reg.setPreference(node.option.name, true);
        } else {
            node.graphic.animation.frameIndex = 0;
            node.graphic.alpha = 0.5;
            Reg.setPreference(node.option.name, false);
        }
    }
}
