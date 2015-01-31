package alienzone.entities;
import alienzone.engine.AbstractEntity;
import alienzone.components.ActionComponent;
import alienzone.components.SpriteComponent;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class InputEntity extends AbstractEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, action:String) {
        super(world);

        var input:Entity = world.create();
        graphic = new FlxSprite(x, y, key);

        input.addComponent(new SpriteComponent(x, y, key));
        input.addComponent(new ActionComponent(action));
        input.update();
    }
}
