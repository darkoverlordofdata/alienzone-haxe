package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Transform;
import alienzone.components.Display;
import alienzone.components.Time;
import flixel.FlxSprite;


class TimerNode extends Node<TimerNode> {

    private var display:Display;

    public var time:Time;
    public var transform:Transform;
    public var graphic(get_graphic, never):FlxSprite;

    private inline function get_graphic():FlxSprite {
        return display.graphic;
    }

}
