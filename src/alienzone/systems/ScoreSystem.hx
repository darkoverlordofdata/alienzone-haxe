package alienzone.systems;

import flixel.text.FlxBitmapTextField;
import flixel.group.FlxGroup;
import alienzone.nodes.ScoreNode;
import ash.tools.ListIteratingSystem;


class ScoreSystem extends ListIteratingSystem<ScoreNode> {

    public var container:FlxGroup;
    public var factory:EntityFactory;

    public function new(container:FlxGroup, factory:EntityFactory) {
        super(ScoreNode, updateNode);
        this.factory = factory;
        this.container = container;
    }

    private function updateNode(node:ScoreNode, time:Float):Void {
        
        node.score.points = Reg.score;
        var gui:FlxBitmapTextField = cast(node.graphic, FlxBitmapTextField);
        gui.text = '${node.text.value}: ${node.score.points}';
    }
}
