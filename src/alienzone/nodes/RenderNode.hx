package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Display;
import alienzone.components.Transform;
import flixel.FlxObject;


class RenderNode extends Node<RenderNode> {

    private var display:Display;

    public var transform:Transform;
    public var graphic(get_graphic, never):FlxObject;

    private inline function get_graphic():FlxObject {
        return display.graphic;
    }

}
