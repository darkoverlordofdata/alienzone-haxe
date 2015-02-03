package alienzone.entities;
import alienzone.engine.BaseEntity;
import alienzone.components.Action;
import alienzone.components.Sprite;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class OptionEntity extends BaseEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, action:String) {
        super(world);

        var option:Entity = world.create();
        graphic = new FlxSprite(x, y, key);

        option.addComponent(new Sprite(x, y, key));
        option.addComponent(new Action(action));
        option.update();
    }
}
