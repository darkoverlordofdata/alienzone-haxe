package alienzone.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import alienzone.components.Display;
import alienzone.components.Transform;
import alienzone.nodes.RenderNode;
import flixel.group.FlxGroup;
import flixel.FlxObject;


class RenderSystem extends System {

    public var container:FlxGroup;
    private var nodes:NodeList<RenderNode>;


    public function new(container:FlxGroup) {
        super();
        this.container = container;
    }

    override public function addToEngine(engine:Engine):Void {
        nodes = engine.getNodeList(RenderNode);
        for (node in nodes)
            addToDisplay(node);
        nodes.nodeAdded.add(addToDisplay);
        nodes.nodeRemoved.add(removeFromDisplay);
    }

    private function addToDisplay(node:RenderNode):Void {
        container.add(node.displayObject);
    }

    private function removeFromDisplay(node:RenderNode):Void {
        container.removeChild(node.graphic);
    }

    override public function update(time:Float):Void {
        for (node in nodes) {
            var graphic:Display = node.graphic;
            var transform:Transform = node.transform;

            graphic.x = transform.x;
            graphic.y = transform.y;
            graphic.rotation = transform.rotation * 180 / Math.PI;
        }
    }

    override public function removeFromEngine(engine:Engine):Void {
        nodes = null;
    }

}
