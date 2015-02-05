/**
 *--------------------------------------------------------------------+
 * HelpState.hx
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
class HelpState extends FlxState {

    private var gameType:GameType;
    private var engine:Engine;
    private var factory:EntityFactory;
    private var instructions:String = "
Match 3 or more gems to score.
Use arrow keys to rotate and
move your gems, down key to drop.
Gems do not have to be in a
a straight line to match.

Timed (FTL) game will auto drop
your gems when time runs out.

Login to save scores and awards
with Google Play Games.
";

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
        .button(260, 20, "Back", ButtonSmall, function() {
            FlxG.switchState(new MenuState());
        })
        .image(15, 100, "images/scores.png", 0.5)
        .image(10, 10, "images/d16a.png")
        .help(0, 130, instructions)
        .text(0, 400, '${String.fromCharCode(0xa9)}2014 Dark Overlord of Data')
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