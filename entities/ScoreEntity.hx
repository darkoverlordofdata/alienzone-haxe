package
import alienzone.engine.BaseEntity;
import alienzone.components.Text;
import alienzone.components.Sprite;
import flixel.text.FlxText;
import hxE.EntityWorld;
import hxE.Entity;

class ScoreEntity extends BaseEntity {

    public var graphic:FlxText;

    public function new(world:EntityWorld, x:Int, y:Int, text:String, font:String="", fill:Int=0x000000, align:String="left") {
        super(world);

        var score:Entity = world.create();
        graphic = new FlxText(x, y, text);

        score.addComponent(new Sprite(x, y, text));
        score.addComponent(new Text(name, font, fill, align));
        score.addComponent(new CountComponent(0));
        score.update();
    }
}
