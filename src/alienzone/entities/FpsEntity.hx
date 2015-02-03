package alienzone.entities;
import alienzone.engine.BaseEntity;
import alienzone.components.Text;
import alienzone.components.Sprite;
import flixel.text.FlxText;
import hxE.EntityWorld;
import hxE.Entity;

class FpsEntity extends BaseEntity {

    public var graphic:FlxText;

    public function new(world:EntityWorld, x:Int, y:Int, font:String="", fill:Int=0x000000, align:String="left") {
        super(world);

        var text:Entity = world.create();
        graphic = new FlxText(x, y, name);

        text.addComponent(new Sprite(x, y, name));
        text.addComponent(new Text(name, font, fill, align));
        text.update();
    }
}
