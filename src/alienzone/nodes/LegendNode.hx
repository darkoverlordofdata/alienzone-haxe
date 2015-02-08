package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Display;
import alienzone.components.Level;
import alienzone.components.Opacity;
import flixel.FlxSprite;


class LegendNode extends Node<LegendNode> {

    private var display:Display;
    public var level:Level;
    public var alpha:Opacity;
    public var graphic(get_graphic, never):FlxSprite;

    private inline function get_graphic():FlxSprite {
        return display.graphic;
    }

}
