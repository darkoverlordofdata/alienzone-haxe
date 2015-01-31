package alienzone.entities;
import alienzone.engine.AbstractEntity;
import alienzone.components.BounceComponent;
import alienzone.components.NumberComponent;
import alienzone.components.GravityComponent;
import alienzone.components.SpriteComponent;
import alienzone.components.TransformComponent;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class GemEntity extends AbstractEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, frame:Int) {
        super(world);

        var gem:Entity = world.create();
        graphic = new FlxSprite(0, 0, key);

        gem.addComponent(new SpriteComponent(0, 0, key, frame));
        gem.addComponent(new TransformComponent(x, y));
        gem.addComponent(new NumberComponent(frame));
        gem.addComponent(new GravityComponent(0, 300));
        gem.addComponent(new BounceComponent(0, 0.7+(Math.random()*(1.0 / 2147483647)) * 0.2));
        gem.update();
    }
}
