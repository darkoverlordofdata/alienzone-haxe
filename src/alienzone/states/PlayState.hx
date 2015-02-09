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
package alienzone.states;

import alienzone.components.Player;
import flash.display.StageQuality;
import flixel.util.FlxColor;
import alienzone.systems.LegendSystem;
import alienzone.systems.PlayerSystem;
import alienzone.systems.RenderSystem;
import alienzone.systems.ScoreSystem;
import alienzone.systems.SystemPriorities;
import ash.core.Engine;
import ash.core.Entity;
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
    private var engine:Engine;
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
        var label:String = (gameType == GameType.Infinity) ? 'InfinitY' : 'FTL';
        var player:Player = factory.player();
        
        factory
        .fps(0, 0)
        .image(0, 0, 'slots', 0.2)
        .text(0, 0, label, 1.4, FlxColor.YELLOW)
        .score(0, 40, 'Score')
        .legend(290, 100, 'legend', 0, 1.0)
        .legend(290, 132, 'legend', 1, 1.0)
        .legend(290, 164, 'legend', 2, 1.0)
        .legend(290, 196, 'legend', 3, 0.3)
        .legend(290, 228, 'legend', 4, 0.3)
        .legend(290, 260, 'legend', 5, 0.3)
        .legend(290, 292, 'legend', 6, 0.3)
        .legend(290, 324, 'legend', 7, 0.3)
        .input(000, 430, "left", player)
        .input(050, 430, "down", player)
        .input(100, 430, "right", player)
        .input(220, 430, "lrot", player)
        .input(270, 430, "rrot", player)
        .button(260, 20, "back")        
        .onclick.add(function(action) {
            FlxG.switchState(new MenuState());
        });

        /**
         *  Run the systems
         */
        engine.addSystem(new RenderSystem(this, factory), SystemPriorities.render);
        engine.addSystem(new ScoreSystem(this, factory), SystemPriorities.animate);
        engine.addSystem(new LegendSystem(this, factory), SystemPriorities.animate);
        engine.addSystem(new PlayerSystem(this, factory), SystemPriorities.player);
    }


    /**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void {
		super.destroy();
        factory.onclick.removeAll();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
		super.update();
        engine.update(FlxG.elapsed);
	}
}