/**
 *--------------------------------------------------------------------+
 * MenuState.hx
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

import alienzone.states.PlayState.GameType;
import alienzone.systems.OptionSystem;
import alienzone.systems.RenderSystem;
import alienzone.systems.SystemPriorities;
import ash.core.Engine;
import flash.display.StageQuality;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxSave;
import flixel.util.FlxColor;

/**
 * AlienZone top level menu
 */
class MenuState extends FlxState {

    private var gameType:GameType;
    private var engine:Engine;
    private var factory:EntityFactory;

    /**
     * Display a menu
     */
    override public function create() {
        FlxG.camera.fade(FlxColor.BLACK, .33, true);
    	super.create();
        FlxG.stage.quality = StageQuality.BEST;
        FlxG.camera.antialiasing = true;
        Reg.save();
        #if html5
        /** set the mouse cursor invisible on mobile browswer */
        var ua = js.Browser.navigator.userAgent;
        if ((~/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini|Mobile|mobile/i).match(ua)) {
            FlxG.mouse.visible = false;
        } 
        #end

        /**
         *  Create the engine
         */
        engine = new Engine();
        factory = new EntityFactory(engine);

        /**
         *  Initialize the entities
         */
        factory.fps(0, 0);
        factory.image(10, 10, 'title');
        factory.option(10, 400, 'music', Reg.getPreference('music'));
        factory.option(250, 400, 'sfx', Reg.getPreference('sfx'));
        factory.button(80, 150, 'infinity');
        factory.button(80, 250, 'ftl');
        factory.button(50, 320, 'awards', [0, 1, 2]);
        factory.button(120, 320, 'controller', [0, 1, 2]);
        factory.button(190, 320, 'leaders', [0, 1, 2]);
        factory.button(105, 410, 'help');
        factory.onclick.add(function(action:String) {
            switch (action) {
            
                case 'infinity':	
                    FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
                        FlxG.switchState(new PlayState(GameType.Infinity));
                    });

                case 'ftl':         
                    FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
                        FlxG.switchState(new PlayState(GameType.FTL));
                    });

                case 'awards':      
                    FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
                        FlxG.switchState(new AchievementsState());
                    });

                case 'controller':
                    FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
                        FlxG.switchState(new LoginState());
                    });

                case 'leaders':
                    FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
                        FlxG.switchState(new LeaderboardState());
                    });
                
                case 'help':
                    FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
                        FlxG.switchState(new HelpState());
                    });

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