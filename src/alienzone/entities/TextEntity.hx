package alienzone.entities;
import alienzone.components.Display;
import alienzone.components.Transform;
import alienzone.engine.BaseEntity;
import alienzone.components.Text;
import alienzone.components.Sprite;
import flixel.text.FlxText;
import hxE.EntityWorld;
import hxE.Entity;

class TextEntity extends BaseEntity {

    public function new(world:EntityWorld, x:Int, y:Int, text:String, font:String="", fill:Int=0x000000, align:String="left") {
        super(world);

        graphic = new FlxText(0, 0, text);

//        var title:FlxBitmapTextField = new FlxBitmapTextField(font0);
//        title.x = x;
//        title.y = y;
//        title.fixedWidth = true;
//        title.color = FlxColor.YELLOW;
//        title.useTextColor = false;
//        title.text = text;
//        title.outlineColor = FlxColor.RED;
//        title.width = 320;
//        title.alignment = PxTextAlign.CENTER;
//        title.fontScale = 2.2;

        var entity:Entity = world.create();
        entity.addComponent(new Sprite(0, 0, key));
        entity.addComponent(new Text(text, font, fill, align));
        entity.addComponent(new Display(graphic));
        entity.addComponent(new Transform(x, y));
        entity.update();
    }
}
