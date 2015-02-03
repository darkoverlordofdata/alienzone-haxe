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

import alienzone.PlayState.GameType;
import alienzone.systems.RenderSystem;
import alienzone.systems.SystemPriorities;
import ash.tick.ITickProvider;
import ash.core.Engine;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxState;


/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {

    private var gameType:GameType;
    private var container:FlxGroup;
    private var engine:Engine;
    private var tickProvider:ITickProvider;
    private var factory:EntityFactory;

    /**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create() {
		super.create();
        // Set up the Ash engine
        engine = new Engine();
        engine.addSystem(new RenderSystem(this), SystemPriorities.render);

        // Add the entities
        factory = new EntityFactory(engine);
        factory.title(0,50,"AlienZone");
        factory.button(80, 150, "Infinity", onInfinity);
        factory.button(80, 250, "FTL", onFTL);
        factory.start();
        //add(new FPS());


    }

    /**
	 * Run the Infinity game
	 */
    private function onInfinity() {
        var playState:PlayState = new PlayState(GameType.Infinity);
        FlxG.switchState(playState);
    }

    /**
	 * Run the FTL game
	 */
    private function onFTL() {
        var playState:PlayState = new PlayState(GameType.FTL);
        FlxG.switchState(playState);
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