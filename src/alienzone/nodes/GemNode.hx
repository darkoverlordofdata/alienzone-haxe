package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Display;
import alienzone.components.Match;
import alienzone.components.Puzzle;
import flixel.FlxSprite;


class GemNode extends Node<GemNode> {

    private var display:Display;

    public var graphic(get_graphic, never):FlxSprite;
    public var match:Match;
    public var puzzle:Puzzle;

    private inline function get_graphic():FlxSprite {
        return display.graphic;
    }

}
