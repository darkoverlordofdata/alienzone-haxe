package alienzone;

import ash.core.Entity;
import ash.core.Engine;
import ash.fsm.EntityStateMachine;
import ash.tools.ComponentPool;
import flixel.text.pxText.PxBitmapFont;
import flixel.text.FlxBitmapTextField;
import flixel.text.pxText.PxTextAlign;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.FlxSprite;
import openfl.Assets;

import alienzone.components.Action;
import alienzone.components.Bonus;
import alienzone.components.Bounce;
import alienzone.components.Count;
import alienzone.components.Direction;
import alienzone.components.Display;
import alienzone.components.GameState;
import alienzone.components.Gravity;
import alienzone.components.Lock;
import alienzone.components.Number;
import alienzone.components.Opacity;
import alienzone.components.Sprite;
import alienzone.components.State;
import alienzone.components.Target;
import alienzone.components.Text;
import alienzone.components.Transform;
import alienzone.components.Velocity;

class EntityFactory {

    private var engine:Engine;
    private var fontNormal:PxBitmapFont;
    private var fontTitle:PxBitmapFont;

    public function new(engine:Engine) {
        this.engine = engine;
        var fntNormal = Xml.parse(Assets.getText("fonts/opendyslexic.fnt"));
        var fntTitle = Xml.parse(Assets.getText("fonts/outlined.fnt"));
        fontNormal = new PxBitmapFont().loadAngelCode(Assets.getBitmapData("fonts/opendyslexic_0.png"), fntNormal);
        fontTitle = new PxBitmapFont().loadAngelCode(Assets.getBitmapData("fonts/outlined_0.png"), fntTitle);
    }

    /**
     * Start
     */
    public function start() {
        var gameState:Entity = new Entity()
        .add(new GameState());
        engine.addEntity(gameState);
        return gameState;

    }
    
    /**
     * Image
     */
    public function image(x:Int, y:Int, path:String, opacity:Float=1.0):Entity {
        var image:Entity = new Entity()
        .add(new Sprite(0, 0, path))
        .add(new Opacity(opacity))
        .add(new Display(new FlxSprite(0, 0, path)))
        .add(new Transform(x, y));
        engine.addEntity(image);
        return image;
    }

    public function title(x:Int, y:Int, str:String) {
    
        var text:FlxBitmapTextField = new FlxBitmapTextField(fontTitle);
        text.fixedWidth = true;
        text.color = FlxColor.YELLOW;
        text.useTextColor = false;
        text.text = str;
        text.outlineColor = FlxColor.RED;
        text.width = 320;
        text.alignment = PxTextAlign.CENTER;
        text.fontScale = 2.2;
        
        var title:Entity = new Entity()
        .add(new Display(text))
        .add(new Transform(x, y));
        engine.addEntity(title);
        return title;
    }
}
