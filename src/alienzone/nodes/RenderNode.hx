package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Display;
import alienzone.components.Transform;
import flixel.FlxSprite;


class RenderNode extends Node<RenderNode> {

    private var display:Display;

    public var transform:Transform;
    public var graphic(get_graphic, never):FlxSprite;

    private inline function get_graphic():FlxSprite {
        return display.graphic;
    }

}
