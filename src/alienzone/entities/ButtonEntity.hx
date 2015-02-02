package alienzone.entities;
import alienzone.engine.AbstractEntity;
import alienzone.components.ActionComponent;
import alienzone.components.SpriteComponent;
import alienzone.components.TextComponent;
import alienzone.components.TransformComponent;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class ButtonEntity extends AbstractEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, action:String, text:String="", font:String="", fill:Int=0x000000) {
        super(world);

        var button:Entity = world.create();
        graphic = new FlxSprite(0, 0, key);

        button.addComponent(new SpriteComponent(0, 0, key));
        button.addComponent(new TransformComponent(x, y));
        button.addComponent(new ActionComponent(action));
        button.addComponent(new TextComponent(text, font, fill));
        button.update();
    }
}
