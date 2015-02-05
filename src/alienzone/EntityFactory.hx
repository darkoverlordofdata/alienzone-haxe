package alienzone;

import ash.core.Entity;
import ash.core.Engine;
import ash.fsm.EntityStateMachine;
import ash.tools.ComponentPool;
import flixel.FlxSprite;

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

import alienzone.graphics.Button;
import alienzone.graphics.FPS;
import alienzone.graphics.Title;


class EntityFactory {

    private var engine:Engine;

    public function new(engine:Engine) {
        this.engine = engine;
    }

    /**
     * Start
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
        .add(new Opacity(opacity))
        .add(new Display(sprite))
        .add(new Transform(x, y));
        engine.addEntity(image);
        return this;
    }

    /**
     * Title
     *
     * @param x
     * @param y
     * @param text
     * @return Entity
     */
    public function title(x:Int, y:Int, text:String):EntityFactory {
        var title:Entity = new Entity()
        .add(new Display(new Title(0, 0, text)))
        .add(new Transform(x, y));
        engine.addEntity(title);
        return this;
    }

    /**
     * Button
     * 
     * @param x
     * @param y 
     * @param text 
     * @param callback
     * @return Entity
     */
    public function button(x:Int, y:Int, text:String, callback):EntityFactory {
        var button:Entity = new Entity()
        .add(new Display(new Button(0, 0, text, callback)))
        .add(new Transform(x, y));
        engine.addEntity(button);
        return this;

    }

    /**
     * FPS
     * 
     * @param x
     * @param y 
     * @return Entity
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
     * @return Entity
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
     * @return Entity
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
     * @return Entity
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
     * @param text
     * @param callback
     * @return Entity
     */
    public function option(x:Int, y:Int, text:String, callback):EntityFactory {
        var option:Entity = new Entity();
        return this;
    }


    /**
     * Score
     *
     * @param x
     * @param y
     * @param text
     * @param callback
     * @return Entity
     */
    public function score(x:Int, y:Int, text:String, callback):EntityFactory {
        var score:Entity = new Entity();
        return this;
    }
}
