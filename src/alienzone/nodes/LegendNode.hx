package alienzone.nodes;

import alienzone.components.Transform;
import ash.core.Node;
import alienzone.components.Display;
import alienzone.components.Level;
import flixel.FlxSprite;


class LegendNode extends Node<LegendNode> {

    private var display:Display;
    public var level:Level;
    public var transform:Transform;
    public var graphic(get_graphic, never):FlxSprite;

    private inline function get_graphic():FlxSprite {
        return display.graphic;
    }

}
