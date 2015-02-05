package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Display;
import alienzone.components.Option;
import flixel.FlxSprite;


class OptionNode extends Node<OptionNode> {

    private var display:Display;

    public var option:Option;
    public var graphic(get_graphic, never):FlxSprite;

    private inline function get_graphic():FlxSprite {
        return display.graphic;
    }

}
