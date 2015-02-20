package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Display;
import alienzone.components.Transform;
import alienzone.components.Count;
import flixel.FlxSprite;


class LeaderNode extends Node<LeaderNode> {

    private var display:Display;

    public var transform:Transform;
    public var graphic(get_graphic, never):FlxSprite;
    public var leader:Count;

    private inline function get_graphic():FlxSprite {
        return display.graphic;
    }

}
