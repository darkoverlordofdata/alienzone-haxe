package alienzone.entities;
import alienzone.engine.BaseEntity;
import alienzone.components.Bounce;
import alienzone.components.Number;
import alienzone.components.Gravity;
import alienzone.components.Sprite;
import alienzone.components.Transform;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class GemEntity extends BaseEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, frame:Int) {
        super(world);

        var gem:Entity = world.create();
        graphic = new FlxSprite(0, 0, key);

        gem.addComponent(new Sprite(0, 0, key, frame));
        gem.addComponent(new Transform(x, y));
        gem.addComponent(new Number(frame));
        gem.addComponent(new Gravity(0, 300));
        gem.addComponent(new Bounce(0, 0.7+(Math.random()*(1.0 / 2147483647)) * 0.2));
        gem.update();
    }
}
