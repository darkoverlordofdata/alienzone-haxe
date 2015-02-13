package alienzone;

import alienzone.components.Group;
import flixel.util.FlxSignal.FlxTypedSignal;
import flixel.ui.FlxButton;
import flixel.ui.FlxButton;
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

import alienzone.components.Bounce;
import alienzone.components.Display;
import alienzone.components.GameState;
import alienzone.components.Gravity;
import alienzone.components.Level;
import alienzone.components.Match;
import alienzone.components.Opacity;
import alienzone.components.Option;
import alienzone.components.Player;
import alienzone.components.Text;
import alienzone.components.Transform;


import alienzone.graphics.FPS;


class EntityFactory {

    private static var INTMAX:Int = 2147483647;

    public var onclick:FlxTypedSignal<String->Void>;

    private var engine:Engine;

    public function new(engine:Engine) {
        onclick = new FlxTypedSignal<String->Void>();
        this.engine = engine;

    }

    /**
     * bitmapText helper
     *
     */
    private function bitmapText(fontName:String, fontScale:Float=1.0):FlxBitmapTextField {
        var font:PxBitmapFont;
        var fnt = Xml.parse(Assets.getText('${fontName}.fnt'));
        font = new PxBitmapFont()
        .loadAngelCode(Assets.getBitmapData('${fontName}_0.png'), fnt);
        var bitmap:FlxBitmapTextField = new FlxBitmapTextField(font);
        bitmap.width = 320;
        bitmap.fixedWidth = true;
        bitmap.useTextColor = false;
        bitmap.alignment = PxTextAlign.CENTER;
        bitmap.multiLine = false;
        bitmap.fontScale = fontScale;
        return bitmap;
    }

    /**
     * Player
     *
     * @return player component
     */
    public function player():Player {
        var player = new Player();
        var entity:Entity = new Entity()
        .add(player);
        engine.addEntity(entity);
        return player;
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
    public function image(x:Int, y:Int, key:String, opacity:Float=1.0):EntityFactory {
    
        var sprite:FlxSprite = new FlxSprite(0, 0, Res.sprite[key].path);
        sprite.alpha = opacity;
        sprite.antialiasing = true;
        
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
        txt.color = FlxColor.YELLOW;
        txt.outlineColor = FlxColor.RED;
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
        txt.color = 0x00ffff;
        txt.fontScale = 0.75;
        txt.multiLine = true;
        txt.text = text;

        var entity:Entity = new Entity()
        .add(new Display(txt))
        .add(new Transform(x, y));
        engine.addEntity(entity);
        return this;
    }

    /**
     * Score
     *
     * @param x
     * @param y
     * @param text
     * @return this for chaining
     */
    public function score(x:Int, y:Int, text:String):EntityFactory {
    
        var txt = bitmapText("fonts/opendyslexic");
        txt.color = FlxColor.BEIGE;
        txt.fontScale = 1.5;
        txt.text = text;

        var score:Entity = new Entity()
        .add(new GameState(0,3,0))
        .add(new Display(txt))
        .add(new Text(text))
        .add(new Transform(x, y));
        engine.addEntity(score);
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
    public function text(x:Int, y:Int, text:String, scale:Float=1.0, color:Int=0):EntityFactory {
    
        var txt = bitmapText("fonts/opendyslexic");
        txt.color = color;
        txt.fontScale = scale;
        txt.text = text;

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
    public function button(x:Int, y:Int, action:String):EntityFactory {
    
        var btn:FlxButton = new FlxButton(0, 0, "", function() {
            onclick.dispatch(action);
        });
        btn.loadGraphic(Res.sprite[action].path);
        btn.antialiasing = true;
        
        var button:Entity = new Entity()
        .add(new Display(btn))
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
        if (Reg.SHOW_FPS) {
            var fps:Entity = new Entity()
            .add(new Display(new FPS()))
            .add(new Transform(x, y));
            engine.addEntity(fps);
        }
        return this;
    }

    /**
     * Gem
     *
     * @param id    id in current gen group
     * @param col   column in grid
     * @param row   row in grid
     * @param key   gem sprite filename
     * @param frame gem sprite frame
     * @return the gem entity
     */
    public function gem(id:Int, index:Int, col:Int, row:Int, key:String, frame:Int):Entity {
    
        var sprite:FlxSprite = new FlxSprite(0,0);
        sprite.loadGraphic(Res.sprite[key].path, true, Res.sprite[key].height, Res.sprite[key].width);
        sprite.animation.add('gem', [0, 1, 2, 3, 4, 5, 6, 7]);
        sprite.animation.frameIndex = frame;

        var gem:Entity = new Entity()
        .add(new Group(index))
        .add(new Display(sprite))
        .add(new Match(Res.GEMTYPES[frame], id, index, col, row));
        engine.addEntity(gem);
        return gem;
    }

    /**
     * Input
     *
     * @param x
     * @param y
     * @param path image for this input
     * @param action action associated with click
     * @param player component
     * @return this for chaining
     */
    public function input(x:Int, y:Int, action:String, player:Player):EntityFactory {
    
        var sprite = new FlxSprite(0, 0, Res.sprite[action].path);
        
        MouseEventManager.add(sprite, function(s:FlxSprite) {
            player.command = action;
        });
        
        var input:Entity = new Entity()
        .add(new Display(sprite))
        .add(new Transform(x, y));
        engine.addEntity(input);
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
    public function legend(x:Int, y:Int, key:String, level:Int, alpha:Float):EntityFactory {
    
        var sprite:FlxSprite = new FlxSprite(0,0);
        sprite.loadGraphic(Res.sprite[key].path, true, Res.sprite[key].height, Res.sprite[key].width);
        sprite.animation.add('level', [0, 1, 2, 3, 4, 5, 6, 7]);

        var legend:Entity = new Entity()
        .add(new Display(sprite))
        .add(new Transform(x, y))
        .add(new Level(level))
        .add(new Opacity(alpha));
        engine.addEntity(legend);

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
    public function option(x:Int, y:Int, name:String, value:Bool=false):EntityFactory {

        var sprite:FlxSprite = new FlxSprite(0,0);
        sprite.loadGraphic(Res.sprite[name].path, true, Res.sprite[name].width, Res.sprite[name].height);
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


}
