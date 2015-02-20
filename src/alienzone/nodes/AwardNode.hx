package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Display;
import alienzone.components.Transform;
import alienzone.components.Lock;
import flixel.FlxSprite;


class AwardNode extends Node<AwardNode> {

    private var display:Display;

    public var transform:Transform;
    public var graphic(get_graphic, never):FlxSprite;
    public var award:Lock;

    private inline function get_graphic():FlxSprite {
        return display.graphic;
    }

}
