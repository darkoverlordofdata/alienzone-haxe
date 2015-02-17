package alienzone.systems;

import ash.core.Engine;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import alienzone.components.Transform;
import ash.core.Entity;
import flixel.text.FlxBitmapTextField;
import flixel.group.FlxGroup;
import alienzone.nodes.ScoreNode;
import ash.tools.ListIteratingSystem;


class ScoreSystem extends ListIteratingSystem<ScoreNode> {

    public var container:FlxGroup;
    public var factory:EntityFactory;
    
    private var colors:Array<Int> = [0xffffff00, 0xffff00ff, 0xff00ffff];
    private var cols:Array<Int> = [30, 105, 150];
    private var rows:Array<Int> = [250, 150, 250];
    private var counter:Int = 0;


    /**
     * Initialize the scoring
     *
     * @param [FlxGroup] container - top level gui container
     * @param [EntityFactory] factory - entity factory
     * @return new PuzzleSystem instance
     */
    public function new(container:FlxGroup, factory:EntityFactory) {
        super(ScoreNode, updateNode);
        this.factory = factory;
        this.container = container;
        Reg.scored.add(scored);
    }

    override public function removeFromEngine(engine:Engine):Void {
        super.removeFromEngine(engine);
        Reg.scored.removeAll();
    }
    
    private function updateNode(node:ScoreNode, time:Float):Void {
        node.score.points = Reg.score;
        var gui:FlxBitmapTextField = cast(node.graphic, FlxBitmapTextField);
        gui.text = '${node.text.value}: ${node.score.points}';
    }

    private function scored(points:Int):Void {
        var text:Entity = factory.text(cols[counter], rows[counter], '$points', 5, colors[counter]);
        counter += 1;
        if (counter > 2) counter = 0;
        
        var xform:Transform = text.get(Transform);

        if (Reg.sfx) {
            FlxG.sound.play('bonus${points % Res.SFX_COUNT}', Reg.volume);
        }
        FlxTween.tween(xform, {alpha:0}, 0.75, {
            type: FlxTween.ONESHOT,
            startDelay: 0.5,
            complete:function(s) {
                s.destroy();
            }
        });
    }


}
