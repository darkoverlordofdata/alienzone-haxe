package alienzone.entities;
import alienzone.components.Transform;
import alienzone.components.Display;
import alienzone.engine.BaseEntity;
import alienzone.components.Opacity;
import alienzone.components.Sprite;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class ImageEntity extends BaseEntity {

    private var image:Entity;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, opacity:Float) {
        super(world);

        graphic = new FlxSprite(0, 0, key);
        entity = world.create();
        entity.addComponent(new Sprite(0, 0, key));
        entity.addComponent(new Opacity(opacity));
        entity.addComponent(new Display(graphic));
        entity.addComponent(new Transform(x, y));
        entity.update();

        
        
    }
}
