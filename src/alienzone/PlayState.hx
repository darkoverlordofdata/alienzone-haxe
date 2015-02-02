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

import alienzone.engine.EntityFactory;
import alienzone.systems.DisplaySystem;
import hxE.EntityWorld;
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
    private var world:EntityWorld;
    private var displaySystem:DisplaySystem;
    private var entities:EntityFactory;


    public function new(gameType:GameType) {
        super();
        this.gameType = gameType;
        world = new EntityWorld();
        entities = new EntityFactory(world);
    }

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void {
		super.create();
        //add(new FPS());

        displaySystem = new DisplaySystem();

        world.addSystem(displaySystem);

        add(entities.sprite(50, 100, "images/d16a.png"));


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
        world.updateSystems(FlxG.elapsed);
	}
}