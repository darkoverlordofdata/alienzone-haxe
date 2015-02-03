/**
 *--------------------------------------------------------------------+
 * PlayState.hx
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

import alienzone.systems.RenderSystem;
import alienzone.systems.SystemPriorities;
import ash.tick.ITickProvider;
import ash.core.Engine;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxState;


enum GameType {
    Infinity;
    FTL;
}

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState {

    private var gameType:GameType;
    private var container:FlxGroup;
    private var engine:Engine;
    private var tickProvider:ITickProvider;
    private var factory:EntityFactory;


    public function new(gameType:GameType) {
        super();
        this.gameType = gameType;
    }

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void {
		super.create();
        
        // Set up the Ash engine
        engine = new Engine();
        engine.addSystem(new RenderSystem(this), SystemPriorities.render);
        
        // Add the entities
        factory = new EntityFactory(engine);
        factory.title(0,50,"AlienZed");
        factory.button(80, 150, "Infinity", onInfinity);
        factory.button(80, 250, "FTL", onFTL);
        factory.start();
        //add(new FPS());
        
    }

    /**
	 * Run the Infinity game
	 */
    private function onInfinity() {
        trace("onInfinity");
    }

    /**
	 * Run the FTL game
	 */
    private function onFTL() {
        trace("onFTL");
    }

/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void {
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
		super.update();
        engine.update(FlxG.elapsed);
	}
}