package alienzone.entities;
import alienzone.engine.AbstractEntity;
import alienzone.components.OpacityComponent;
import alienzone.components.SpriteComponent;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class ImageEntity extends AbstractEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, opacity:Float) {
        super(world);

        var image:Entity = world.create();
        graphic = new FlxSprite(x, y, key);

        image.addComponent(new SpriteComponent(x, y, key));
        image.addComponent(new OpacityComponent(opacity));
        image.update();
    }
}
