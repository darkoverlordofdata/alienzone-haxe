package alienzone.entities;
import alienzone.engine.AbstractEntity;
import alienzone.components.ActionComponent;
import alienzone.components.SpriteComponent;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class OptionEntity extends AbstractEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, action:String) {
        super(world);

        var option:Entity = world.create();
        graphic = new FlxSprite(x, y, key);

        option.addComponent(new SpriteComponent(x, y, key));
        option.addComponent(new ActionComponent(action));
        option.update();
    }
}
