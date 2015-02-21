/**
 *--------------------------------------------------------------------+
 * LoginState.hx
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014-2015
 *--------------------------------------------------------------------+
 *
 * This file is a part of Alien Zone
 *
 * Alien Zone is free software; you can copy, modify, and distribute
 * it under the terms of the GPLv3 License
 *
 *--------------------------------------------------------------------+
 *
 */
package alienzone.states;

import flixel.util.FlxColor;
import flash.display.StageQuality;

import alienzone.systems.OptionSystem;
import alienzone.systems.RenderSystem;
import alienzone.systems.SystemPriorities;
import ash.core.Engine;
import flixel.FlxG;
import flixel.FlxState;

/**
 * A FlxState which can be used for the game's menu.
 */
class LoginState extends FlxState {

    private var engine:Engine;
    private var factory:EntityFactory;
    private var instructions:String = "
  To Login, for
  leaderboard and achievements,
  please install Alien Zone
  from Google play
";

    /**
     * Function that is called up when to state is created to set it up.
     */
    override public function create() {
        FlxG.camera.fade(FlxColor.BLACK, .33, true);
    	super.create();
        FlxG.stage.quality = StageQuality.BEST;
        FlxG.camera.antialiasing = true;
        
        /**
         *  Create the engine
         */
        engine = new Engine();
        factory = new EntityFactory(engine);

        /**
         *  Initialize the entities
         */

        factory.fps(0, 0);
        factory.image(15, 100, 'scores', 0.5);
        factory.image(10, 10, 'logo');
        factory.text(55, 20, "Alien Zone", 1.4, FlxColor.YELLOW);
        factory.help(0, 130, instructions);
        #if html5
        factory.button(90, 300, 'googleplay');
        #end
        factory.text(0, 400, '${String.fromCharCode(0xa9)}2014 Dark Overlord of Data', 0.8);
        factory.button(270, 0, 'back');
        factory.onclick.add(function(action) {
            switch (action) {

                case 'back':
                    FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
                    FlxG.switchState(new MenuState());
                });
                
                #if html5
                case 'googleplay':
                    js.Browser.window.open(Reg.GOOGLE_PLAY, '_blank');
                #end
            }   
        });

        /**
         *  Run the systems
         */
        engine.addSystem(new RenderSystem(this, factory), SystemPriorities.render);
        engine.addSystem(new OptionSystem(this, factory), SystemPriorities.animate);

    }

    /**
     * Function that is called when this state is destroyed - you might want to
     * consider setting all objects this state uses to null to help garbage collection.
     */
    override public function destroy() {
    	super.destroy();
        factory.destroy();
        factory = null;
        engine.removeAllEntities();
        engine.removeAllSystems();
        engine = null;
    }

    /**
     * Function that is called once every frame.
     */
    override public function update() {
    	super.update();
        engine.update(FlxG.elapsed);
    }
}