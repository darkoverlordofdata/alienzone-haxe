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
import alienzone.systems.PuzzleSystem;
import alienzone.systems.InputPanelSystem;
import alienzone.systems.RenderGemSystem;
import alienzone.systems.LegendSystem;
import alienzone.systems.RenderSystem;
import alienzone.systems.ScoreSystem;
import alienzone.systems.SystemPriorities;
import ash.core.Engine;
import ash.core.Entity;
import flash.display.StageQuality;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;


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
        var label:String = (gameType == GameType.Infinity) ? 'InfinitY' : 'FTL';
        var player:Player = factory.player();

        factory.fps(0, 0);
        factory.image(0, 0, 'slots', 0.2);
        factory.text(0, 0, label, 1.4, FlxColor.YELLOW);
        factory.score(0, 40, 'Score');
        factory.legend(290, 100, 'legend', 0, 1.0);
        factory.legend(290, 132, 'legend', 1, 1.0);
        factory.legend(290, 164, 'legend', 2, 1.0);
        factory.legend(290, 196, 'legend', 3, 0.3);
        factory.legend(290, 228, 'legend', 4, 0.3);
        factory.legend(290, 260, 'legend', 5, 0.3);
        factory.legend(290, 292, 'legend', 6, 0.3);
        factory.legend(290, 324, 'legend', 7, 0.3);
        factory.input(000, 430, "left", player);
        factory.input(050, 430, "down", player);
        factory.input(100, 430, "right", player);
        factory.input(220, 430, "lrot", player);
        factory.input(270, 430, "rrot", player);
        factory.button(260, 20, "back");
        factory.onclick.add(function(action) {
            FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
                FlxG.switchState(new MenuState());
            });
        });

        /**
         *  Run the systems
         */
        engine.addSystem(new RenderSystem(this, factory), SystemPriorities.render);
        engine.addSystem(new RenderGemSystem(this, factory), SystemPriorities.render);
        engine.addSystem(new ScoreSystem(this, factory), SystemPriorities.animate);
        engine.addSystem(new LegendSystem(this, factory), SystemPriorities.animate);
        engine.addSystem(new InputPanelSystem(this, factory), SystemPriorities.move);
        engine.addSystem(new PuzzleSystem(this, factory), SystemPriorities.player);
    }


    /**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void {
		super.destroy();
        factory.onclick.removeAll();
        engine.removeAllEntities();
        engine.removeAllSystems();
        factory = null;
        engine = null;
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
		super.update();
        engine.update(FlxG.elapsed);
	}
}