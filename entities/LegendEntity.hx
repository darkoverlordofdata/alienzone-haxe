package
import alienzone.engine.BaseEntity;
import alienzone.components.Opacity;
import alienzone.components.Sprite;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class LegendEntity extends BaseEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, opacity:Float) {
        super(world);

        var legend:Entity = world.create();
        graphic = new FlxSprite(0, 0, key);

        legend.addComponent(new Sprite(x, y, key));
        legend.addComponent(new Opacity(opacity));
        legend.update();
    }
}
