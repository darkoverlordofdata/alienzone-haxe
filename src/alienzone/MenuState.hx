/**
 *--------------------------------------------------------------------+
 * MenuState.hx
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014
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
package alienzone;

import alienzone.systems.OptionSystem;
import alienzone.PlayState.GameType;
import alienzone.systems.RenderSystem;
import alienzone.systems.SystemPriorities;
import ash.core.Engine;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxState;
import alienzone.graphics.Button.ButtonStyle;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {

    private var gameType:GameType;
    private var engine:Engine;
    private var factory:EntityFactory;

    /**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create() {
		super.create();
        /**
         *  Create the engine
         */
        engine = new Engine();
        factory = new EntityFactory(engine);
        engine.addSystem(new RenderSystem(this, factory), SystemPriorities.render);
        engine.addSystem(new OptionSystem(this, factory), SystemPriorities.animate);


        /**
         *  Initialize the entities
         */
        factory
        .fps(0, 0)
        .title(0, 50, "AlienZone")
        .button(80, 150, "Infinity", ButtonBig, function() {
            FlxG.switchState(new PlayState(GameType.Infinity));
        })
        .button(80, 250, "FTL", ButtonBig, function() {
            FlxG.switchState(new PlayState(GameType.FTL));
        })
        .option(10, 400, 'images/music_option.png', 47, 57, 'music', true)
        .button(105, 410, 'how to play', ButtonThin, function() {
            FlxG.switchState(new HelpState());
        })
        .option(250, 400, 'images/sfx_option.png', 70, 61, 'sfx', true)
        ;


    }

	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy() {
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update() {
		super.update();
        engine.update(FlxG.elapsed);
	}
}