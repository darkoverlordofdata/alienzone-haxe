package alienzone;

import flixel.ui.FlxButton;
import flixel.group.FlxTypedSpriteGroup;
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

    /**
     * Title
     */
    public function title(x:Int, y:Int, text:String):Entity {
    
        var label:FlxBitmapTextField = new FlxBitmapTextField(fontTitle);
        label.fixedWidth = true;
        label.color = FlxColor.YELLOW;
        label.useTextColor = false;
        label.text = text;
        label.outlineColor = FlxColor.RED;
        label.width = 320;
        label.alignment = PxTextAlign.CENTER;
        label.fontScale = 2.2;
        
        var title:Entity = new Entity()
        .add(new Display(label))
        .add(new Transform(x, y));
        engine.addEntity(title);
        return title;
    }

    public function button(x:Int, y:Int, text:String, callback):Entity {

        var group:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
        var btn:FlxButton = new FlxButton(0, 0, "", callback);
        btn.loadGraphic("images/button5.png");
        group.add(btn);

        var txt:FlxBitmapTextField = new FlxBitmapTextField(fontNormal);
        txt.x = 0;
        txt.y = 10;
        txt.fixedWidth = true;
        txt.color = FlxColor.BLACK;
        txt.useTextColor = false;
        txt.text = text;
        txt.width = 150;
        txt.alignment = PxTextAlign.CENTER;
        txt.fontScale = 1.2;
        group.add(txt);

        var button:Entity = new Entity()
        .add(new Display(group))
        .add(new Transform(x, y));
        engine.addEntity(button);
        return button;

    }
}
