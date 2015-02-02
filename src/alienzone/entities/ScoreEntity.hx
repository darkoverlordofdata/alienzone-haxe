package alienzone.entities;
import alienzone.engine.AbstractEntity;
import alienzone.components.TextComponent;
import alienzone.components.SpriteComponent;
import flixel.text.FlxText;
import hxE.EntityWorld;
import hxE.Entity;

class ScoreEntity extends AbstractEntity {

    public var graphic:FlxText;

    public function new(world:EntityWorld, x:Int, y:Int, text:String, font:String="", fill:Int=0x000000, align:String="left") {
        super(world);

        var score:Entity = world.create();
        graphic = new FlxText(x, y, text);

        score.addComponent(new SpriteComponent(x, y, text));
        score.addComponent(new TextComponent(name, font, fill, align));
        score.addComponent(new CountComponent(0));
        score.update();
    }
}
