package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Bounce;
import alienzone.components.Display;
import alienzone.components.Gravity;
import alienzone.components.Match;
import alienzone.components.Transform;
import flixel.FlxSprite;


class GemNode extends Node<GemNode> {

    private var display:Display;

    public var transform:Transform;
    public var graphic(get_graphic, never):FlxSprite;
    public var bounce:Bounce;
    public var gravity:Gravity;
    public var match:Match;

    private inline function get_graphic():FlxSprite {
        return display.graphic;
    }

}
