package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Display;
import alienzone.components.Transform;
import flixel.FlxObject;


class RenderNode extends Node<RenderNode> {

    public var transform:Transform;
    private var display:Display;

    public var graphic(get_displayObject, never):FlxObject;

    private inline function get_displayObject():FlxObject {
        return display.graphic;
    }

}
