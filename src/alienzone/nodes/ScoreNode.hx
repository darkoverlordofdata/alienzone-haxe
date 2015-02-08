package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Display;
import alienzone.components.Text;
import alienzone.components.GameState;
import flixel.FlxSprite;


class ScoreNode extends Node<ScoreNode> {

    private var display:Display;
    public var text:Text;
    public var score:GameState;
    public var graphic(get_graphic, never):FlxSprite;

    private inline function get_graphic():FlxSprite {
        return display.graphic;
    }

}
