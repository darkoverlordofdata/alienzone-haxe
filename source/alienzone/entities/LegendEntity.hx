package alienzone.entities;
import alienzone.engine.AbstractEntity;
import alienzone.components.OpacityComponent;
import alienzone.components.SpriteComponent;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class LegendEntity extends AbstractEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, opacity:Float) {
        super(world);

        var legend:Entity = world.create();
        graphic = new FlxSprite(0, 0, key);

        legend.addComponent(new SpriteComponent(x, y, key));
        legend.addComponent(new OpacityComponent(opacity));
        legend.update();
    }
}
