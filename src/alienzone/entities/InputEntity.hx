package alienzone.entities;
import alienzone.engine.BaseEntity;
import alienzone.components.Action;
import alienzone.components.Sprite;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class InputEntity extends BaseEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, action:String) {
        super(world);

        var input:Entity = world.create();
        graphic = new FlxSprite(x, y, key);

        input.addComponent(new Sprite(x, y, key));
        input.addComponent(new Action(action));
        input.update();
    }
}
