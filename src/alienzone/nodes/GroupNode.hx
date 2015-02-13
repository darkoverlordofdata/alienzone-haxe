package alienzone.nodes;

import ash.core.Node;
import alienzone.components.Display;
import alienzone.components.Match;
import alienzone.components.Group;
import flixel.FlxSprite;


class GroupNode extends Node<GroupNode> {

    private var display:Display;

    public var graphic(get_graphic, never):FlxSprite;
    public var match:Match;
    public var group:Group;

    private inline function get_graphic():FlxSprite {
        return display.graphic;
    }

}
