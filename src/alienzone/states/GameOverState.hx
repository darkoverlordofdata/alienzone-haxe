/**
 *--------------------------------------------------------------------+
 * GameOverState.hx
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

import alienzone.systems.ScoreSystem;
import alienzone.states.PlayState.GameType;
import alienzone.model.LeaderData;
import alienzone.systems.OptionSystem;
import alienzone.systems.RenderSystem;
import alienzone.systems.SystemPriorities;
import ash.core.Engine;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import flash.display.StageQuality;


/**
 * Show the leaderboard
 */
class GameOverState extends FlxState {

    private var engine:Engine;
    private var factory:EntityFactory;
    
    public function new(gameType:GameType, score:Int=0) {
        super();
        Reg.init(gameType, score);
    }

    /**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create() {
        FlxG.camera.fade(FlxColor.BLACK, .33, true);
		super.create();
        FlxG.stage.quality = StageQuality.BEST;
        FlxG.camera.antialiasing = true;
        
        /**
         *  Create the engine
         */
        engine = new Engine();
        factory = new EntityFactory(engine);
        
        var update:Bool = false;
        switch (Reg.type) {
            case GameType.Infinity:
                update = Reg.data.leaders[0].score < Reg.score;
            case GameType.FTL:
                update = Reg.data.leaders[1].score < Reg.score;

        }

        /**
         *  Initialize the entities
         */

        factory.fps(0, 0);
        factory.image(15, 100, 'scores', 0.5);
        factory.text(0, 130, 'Scores', 1.4, FlxColor.YELLOW);
        var y:Int = 140;
        for (i in 0...Reg.data.leaders.length) {
            var data:Dynamic = Reg.data.leaders[i];
            var leader:LeaderData = new LeaderData(data.id, data.title, data.image, data.score);
            factory.leader(40, y+=40, leader, 1.0, FlxColor.YELLOW);
        }
        factory.image(10, 10, 'logo');
        factory.text(55, 20, "Alien Zone", 1.4, FlxColor.YELLOW);
        factory.score(0, 280, 'Score');
        factory.text(0, 400, '${String.fromCharCode(0xa9)}2014 Dark Overlord of Data', 0.8);
        factory.button(270, 0, 'back');
        if (update) factory.button(100, 340, 'save');
        factory.onclick.add(function(action) {
        
            switch (action) {

                case 'back':
                    FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() {
                        FlxG.switchState(new MenuState());
                    });

                case 'save':
                    switch (Reg.type) {
                        case GameType.Infinity:
                            Reg.data.leaders[0].score = Reg.score;
                        case GameType.FTL:
                            Reg.data.leaders[1].score = Reg.score;

                    }
                    FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() {
                        FlxG.switchState(new LeaderboardState());
                    });

            }
        });

        /**
         *  Run the systems
         */
        engine.addSystem(new RenderSystem(this, factory), SystemPriorities.render);
        engine.addSystem(new OptionSystem(this, factory), SystemPriorities.animate);
        engine.addSystem(new ScoreSystem(this, factory), SystemPriorities.animate);

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