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
package alienzone.states;

import alienzone.states.PlayState.GameType;
import alienzone.systems.OptionSystem;
import alienzone.systems.RenderSystem;
import alienzone.systems.SystemPriorities;
import ash.core.Engine;
import flixel.FlxG;
import flash.display.StageQuality;
import flixel.FlxState;

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
        factory
        .image(10, 10, 'title')
        .button(80, 150, 'infinity')
        .button(80, 250, 'ftl')
        .option(10, 400, 'music', true)
        .button(105, 410, 'help')
        .option(250, 400, 'sfx', true)
        .fps(0, 0)
        .onclick.add(function(action:String) {
            switch (action) {
                case 'infinity':    FlxG.switchState(new PlayState(GameType.Infinity));
                case 'ftl':         FlxG.switchState(new PlayState(GameType.FTL));
                case 'hrlp':        FlxG.switchState(new HelpState());

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
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update() {
		super.update();
        engine.update(FlxG.elapsed);
	}
}