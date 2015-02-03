package alienzone.engine;
import alienzone.entities.TextEntity;
import alienzone.entities.ImageEntity;
import flixel.text.pxText.PxBitmapFont;
import hxE.EntityWorld;
import openfl.Assets;

class EntityFactory {

    public var world:EntityWorld;
    private var fontNormal:PxBitmapFont;
    private var fontTitle:PxBitmapFont;

    public function new(world:EntityWorld) {
        this.world = world;
        var fntNormal = Xml.parse(Assets.getText("fonts/opendyslexic.fnt"));
        var fntTitle = Xml.parse(Assets.getText("fonts/outlined.fnt"));
        fontNormal = new PxBitmapFont().loadAngelCode(Assets.getBitmapData("fonts/opendyslexic_0.png"), fntNormal);
        fontTitle = new PxBitmapFont().loadAngelCode(Assets.getBitmapData("fonts/outlined_0.png"), fntTitle);
    }

    /**
     * Create a Text
     */
    public function text(x:Int, y:Int, text:String) {
        return new TextEntity(world, x, y, text);
    }

    /**
     * Create an image
     */
    public function image(x:Int, y:Int, path:String, opacity:Float=1.0):ImageEntity {
        return new ImageEntity(world, x, y, path, opacity);
    }

}
