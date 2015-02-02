package alienzone.entities;
import alienzone.engine.AbstractEntity;
import alienzone.components.TextComponent;
import alienzone.components.SpriteComponent;
import flixel.text.FlxText;
import hxE.EntityWorld;
import hxE.Entity;

class TextEntity extends AbstractEntity {

    public var graphic:FlxText;

    public function new(world:EntityWorld, x:Int, y:Int, name:String, font:String="", fill:Int=0x000000, align:String="left") {
        super(world);

        var text:Entity = world.create();
        graphic = new FlxText(x, y, name);

        text.addComponent(new SpriteComponent(x, y, name));
        text.addComponent(new TextComponent(name, font, fill, align));
        text.update();
    }
}
