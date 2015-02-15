package alienzone.systems;

import flixel.FlxSprite;
import flixel.FlxSprite;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import alienzone.components.Display;
import alienzone.components.Transform;
import alienzone.nodes.RenderNode;
import flixel.group.FlxGroup;
import flixel.FlxObject;


class RenderSystem extends System {

    private var nodes:NodeList<RenderNode>;
    public var container:FlxGroup;
    public var factory:EntityFactory;


    public function new(container:FlxGroup, factory:EntityFactory) {
        super();
        this.factory = factory;
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
        container.add(node.graphic);
    }

    private function removeFromDisplay(node:RenderNode):Void {
        container.remove(node.graphic);
    }

    override public function update(time:Float):Void {
        for (node in nodes) {
            var graphic:FlxSprite = node.graphic;
            var transform:Transform = node.transform;

            graphic.x = transform.x;
            graphic.y = transform.y;
            graphic.alpha = transform.alpha;
            //graphic.rotation = transform.rotation * 180 / Math.PI;
        }
    }

    override public function removeFromEngine(engine:Engine):Void {
        nodes = null;
    }

}
