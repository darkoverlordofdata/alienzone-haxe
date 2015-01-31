package alienzone.entities;
import alienzone.components.TransformComponent;
import alienzone.components.TransformComponent;
import alienzone.components.DisplayComponent;
import flixel.FlxSprite;
import hxE.EntityWorld;
import hxE.Entity;
import engine.AbstractEntity;

class ButtonEntity extends AbstractEntity {

    public var graphic:FlxSprite;

    public function new(world:EntityWorld, x:Int, y:Int, key:String, action:String, text:String="", font:String="", color:Int=0x000000) {
        super(world);

        var button:Entity = world.create();
        graphic = new FlxSprite(0, 0, key);

        button.addComponent(new DisplayComponent(graphic));
        button.addComponent(new TransformComponent(x, y));
        button.update();
    }
}
