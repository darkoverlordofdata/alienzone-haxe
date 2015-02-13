package alienzone.systems;

import flixel.FlxSprite;
import flixel.FlxSprite;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import alienzone.components.Display;
import alienzone.components.Match;
import alienzone.nodes.GroupNode;
import flixel.group.FlxGroup;
import flixel.FlxObject;


class RenderGemSystem extends System {

    private var nodes:NodeList<GroupNode>;
    public var container:FlxGroup;
    public var factory:EntityFactory;


    public function new(container:FlxGroup, factory:EntityFactory) {
        super();
        this.factory = factory;
        this.container = container;
    }

    override public function addToEngine(engine:Engine):Void {
        nodes = engine.getNodeList(GroupNode);
        for (node in nodes)
            addToDisplay(node);
        nodes.nodeAdded.add(addToDisplay);
        nodes.nodeRemoved.add(removeFromDisplay);
    }

    private function addToDisplay(node:GroupNode):Void {
        container.add(node.graphic);
    }

    private function removeFromDisplay(node:GroupNode):Void {
        container.remove(node.graphic);
    }

    override public function update(time:Float):Void {
        for (node in nodes) {
            var graphic:FlxSprite = node.graphic;
            var match:Match = node.match;

            graphic.x = match.x;
            graphic.y = match.y;
        }
    }

    override public function removeFromEngine(engine:Engine):Void {
        nodes = null;
    }

}
