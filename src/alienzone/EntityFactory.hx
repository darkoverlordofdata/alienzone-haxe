package alienzone;

import flixel.util.FlxColor;
import flixel.util.FlxColor;
import flixel.text.pxText.PxTextAlign;
import flixel.text.FlxBitmapTextField;
import flixel.text.pxText.PxBitmapFont;
import openfl.Assets;
import flixel.plugin.MouseEventManager;
import flixel.FlxSprite;

import ash.core.Entity;
import ash.core.Engine;

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
import alienzone.components.Option;
import alienzone.components.Sprite;
import alienzone.components.State;
import alienzone.components.Target;
import alienzone.components.Transform;
import alienzone.components.Velocity;

import alienzone.graphics.Button;
import alienzone.graphics.Button.ButtonStyle;
import alienzone.graphics.FPS;


class EntityFactory {

    private var engine:Engine;

    public function new(engine:Engine) {
        this.engine = engine;

    }

    /**
     * bitmapText helper
     *
     */
    private function bitmapText(fontName:String):FlxBitmapTextField {
        var font:PxBitmapFont;
        var fnt = Xml.parse(Assets.getText('${fontName}.fnt'));
        font = new PxBitmapFont().loadAngelCode(Assets.getBitmapData('${fontName}_0.png'), fnt);
        return new FlxBitmapTextField(font);
    }


    /**
     * Start new game:
     * 
     * level
     * lives
     * points 
     *  
     */
    public function start(level:Int = 0, lives:Int = 3, points:Int = 0):EntityFactory {
        var gameState:Entity = new Entity()
        .add(new GameState(level, lives, points));
        engine.addEntity(gameState);
        return this;

    }
    
    /**
     * Image
     *
     * @param x
     * @param y 
     * @param path
     * @param callback
     * @return opacity
     */
    public function image(x:Int, y:Int, path:String, opacity:Float=1.0):EntityFactory {
        var sprite:FlxSprite = new FlxSprite(0, 0, path);
        sprite.alpha = opacity;
        var image:Entity = new Entity()
        .add(new Display(sprite))
        .add(new Transform(x, y, opacity));
        engine.addEntity(image);
        return this;
    }

    /**
     * Title
     *
     * @param x
     * @param y
     * @param text
     * @return this for chaining
     */
    public function title(x:Int, y:Int, text:String):EntityFactory {
        var txt = bitmapText("fonts/outlined");
        txt.fixedWidth = true;
        txt.color = FlxColor.YELLOW;
        txt.useTextColor = false;
        txt.outlineColor = FlxColor.RED;
        txt.width = 320;
        txt.alignment = PxTextAlign.CENTER;
        txt.fontScale = 2.2;
        txt.text = text;

        var title:Entity = new Entity()
        .add(new Display(txt))
        .add(new Transform(x, y));
        engine.addEntity(title);
        return this;
    }

    /**
     * Help text
     *
     * @param x
     * @param y
     * @param text
     * @return this for chaining
     */
    public function help(x:Int, y:Int, text:String):EntityFactory {
        var txt = bitmapText("fonts/opendyslexic");
        txt.fixedWidth = true;
        txt.color = 0x00ffff;
        txt.useTextColor = false;
        txt.width = 320;
        txt.fontScale = 0.70;
        txt.alignment = PxTextAlign.CENTER;
        txt.text = text;
        txt.multiLine = true;
        
        var entity:Entity = new Entity()
        .add(new Display(txt))
        .add(new Transform(x, y));
        engine.addEntity(entity);
        return this;
    }

    /**
     * Text
     *
     * @param x
     * @param y
     * @param text
     * @return this for chaining
     */
    public function text(x:Int, y:Int, text:String):EntityFactory {
        var txt = bitmapText("fonts/opendyslexic");
        txt.fixedWidth = true;
        txt.color = FlxColor.BLACK;
        txt.useTextColor = false;
        txt.width = 320;
        txt.fontScale = 0.8;
        txt.alignment = PxTextAlign.CENTER;
        txt.text = text;
        txt.multiLine = false;

        var entity:Entity = new Entity()
        .add(new Display(txt))
        .add(new Transform(x, y));
        engine.addEntity(entity);
        return this;
    }

    /**
     * Button
     * 
     * @param x
     * @param y 
     * @param text 
     * @param callback
     * @return this for chaining
     */
    public function button(x:Int, y:Int, text:String, type:ButtonStyle, callback):EntityFactory {
        var button:Entity = new Entity()
        .add(new Display(new Button(text, type, callback)))
        .add(new Transform(x, y));
        engine.addEntity(button);
        return this;

    }

    /**
     * FPS
     * 
     * @param x
     * @param y 
     * @return this for chaining
     */
    public function fps(x:Int, y:Int):EntityFactory {
        var fps:Entity = new Entity()
        .add(new Display(new FPS()))
        .add(new Transform(x, y));
        engine.addEntity(fps);
        return this;
    }

    /**
     * Gem
     *
     * @param x
     * @param y
     * @param text
     * @param callback
     * @return this for chaining
     */
    public function gem(x:Int, y:Int, text:String, callback):EntityFactory {
        var gem:Entity = new Entity();
        return this;
    }

    /**
     * Input
     *
     * @param x
     * @param y
     * @param text
     * @param callback
     * @return this for chaining
     */
    public function input(x:Int, y:Int, text:String, callback):EntityFactory {
        var input:Entity = new Entity();
        return this;
    }

    /**
     * Legend
     *
     * @param x
     * @param y
     * @param text
     * @param callback
     * @return this for chaining
     */
    public function legend(x:Int, y:Int, text:String, callback):EntityFactory {
        var legend:Entity = new Entity();
        return this;
    }

    /**
     * Option
     *
     * @param x
     * @param y
     * @param path to sprite image - Off/On
     * @param height
     * @param width
     * @param name
     * @param value
     * @return this for chaining
     */
    public function option(x:Int, y:Int, path:String, height:Int, width:Int, name:String, value:Bool=false):EntityFactory {

        var sprite:FlxSprite = new FlxSprite(0,0);
        sprite.loadGraphic(path, true, height, width);
        sprite.animation.add('off', [0]);
        sprite.animation.add('on', [1]);

        var option:Option = new Option(name, value);
        
        MouseEventManager.add(sprite, function(s:FlxSprite) {
            option.enabled = !option.enabled;
        });


        var setting:Entity = new Entity()
        .add(new Display(sprite))
        .add(new Transform(x, y))
        .add(option);
        engine.addEntity(setting);

        return this;
    }


    /**
     * Score
     *
     * @param x
     * @param y
     * @param text
     * @param callback
     * @return this for chaining
     */
    public function score(x:Int, y:Int, text:String, callback):EntityFactory {
        var score:Entity = new Entity();
        return this;
    }
}
