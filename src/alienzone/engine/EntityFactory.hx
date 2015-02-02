package alienzone.engine;
import alienzone.components.TransformComponent;
import alienzone.components.TransformComponent;
import alienzone.components.DisplayComponent;
import hxE.Entity;
import hxE.EntityWorld;
import flixel.FlxSprite;

class EntityFactory {

    private var world:EntityWorld;

    public function new(world:EntityWorld) {
        this.world = world;
    }

    public function sprite(x:Int, y:Int, path:String):FlxSprite {

        var e:Entity = world.create();
        var graphic:FlxSprite = new FlxSprite(0, 0, "images/d16a.png");

        var display:DisplayComponent = new DisplayComponent(graphic);
        var transform:TransformComponent = new TransformComponent(50, 100);

        e.addComponent(display);
        e.addComponent(transform);
        e.update();

        return graphic;


    }

}
