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

import alienzone.renderables.Button;
import alienzone.renderables.FPS;
import alienzone.renderables.Title;


class EntityFactory {

    private var engine:Engine;

    public function new(engine:Engine) {
        this.engine = engine;
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
     *
     * @param x
     * @param y 
     * @param path
     * @param callback
     * @return opacity
     */
    public function image(x:Int, y:Int, path:String, opacity:Float=1.0):Entity {
        var sprite:FlxSprite = new FlxSprite(0, 0, path);
        sprite.alpha = opacity;
        var image:Entity = new Entity()
        .add(new Opacity(opacity))
        .add(new Display(sprite))
        .add(new Transform(x, y));
        engine.addEntity(image);
        return image;
    }

    /**
     * Title
     *
     * @param x
     * @param y
     * @param text
     * @return Entity
     */
    public function title(x:Int, y:Int, text:String):Entity {
        var title:Entity = new Entity()
        .add(new Display(new Title(0, 0, text)))
        .add(new Transform(x, y));
        engine.addEntity(title);
        return title;
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
    public function button(x:Int, y:Int, text:String, callback):Entity {
        var button:Entity = new Entity()
        .add(new Display(new Button(0, 0, text, callback)))
        .add(new Transform(x, y));
        engine.addEntity(button);
        return button;

    }

    /**
     * FPS
     * 
     * @param x
     * @param y 
     * @return Entity
     */
    public function fps(x:Int, y:Int):Entity {
        var fps:Entity = new Entity()
        .add(new Display(new FPS()))
        .add(new Transform(x, y));
        engine.addEntity(fps);
        return fps;
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
    public function gem(x:Int, y:Int, text:String, callback):Entity {
        var gem:Entity = new Entity();
        return gem;
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
    public function input(x:Int, y:Int, text:String, callback):Entity {
        var input:Entity = new Entity();
        return input;
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
    public function legend(x:Int, y:Int, text:String, callback):Entity {
        var legend:Entity = new Entity();
        return legend;
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
    public function option(x:Int, y:Int, text:String, callback):Entity {
        var option:Entity = new Entity();
        return option;
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
    public function score(x:Int, y:Int, text:String, callback):Entity {
        var score:Entity = new Entity();
        return score;
    }
}
