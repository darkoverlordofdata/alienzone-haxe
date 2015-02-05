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
import ash.core.Engine;
import flixel.group.FlxGroup;
import flixel.FlxG;
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
        // Set up the engine
        engine = new Engine();
        engine.addSystem(new RenderSystem(this), SystemPriorities.render);

        // Add the entities
        factory = new EntityFactory(engine)
        .fps(0, 0)
        .title(0, 50, "AlienZone")
        .button(80, 150, "Infinity", function() {
            FlxG.switchState(new PlayState(GameType.Infinity));
        })
        .button(80, 250, "FTL", function() {
            FlxG.switchState(new PlayState(GameType.FTL));
        });

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