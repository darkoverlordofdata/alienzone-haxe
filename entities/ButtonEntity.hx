package
import alienzone.engine.BaseEntity;
import alienzone.components.Action;
import alienzone.components.Sprite;
import alienzone.components.Text;
import alienzone.components.Transform;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;

class ButtonEntity extends BaseEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, action:String, text:String="", font:String="", fill:Int=0x000000) {
        super(world);

        var button:Entity = world.create();
        graphic = new FlxSprite(0, 0, key);

        button.addComponent(new Sprite(0, 0, key));
        button.addComponent(new Transform(x, y));
        button.addComponent(new Action(action));
        button.addComponent(new Text(text, font, fill));
        button.update();
    }
}
