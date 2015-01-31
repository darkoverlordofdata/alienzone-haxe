package alienzone;

import alienzone.PlayState.GameType;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import alienzone.FPS;


/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {


	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create() {
		super.create();

        title(20, 80, "Alien Zone");
        button(80, 150, "Infinity", onInfinity);
        button(80, 250, "FTL", onFTL);
        add(new FPS());

    }

    /**
	 * Display the game title
	 */
    private function title(x:Int, y:Int, text:String) {
        var title = new FlxText(x, y, 0);
        title.text = text;
        title.setFormat(Reg.font, 46, FlxColor.YELLOW, "center");
        title.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.RED, 3);
        add(title);
    }

    /**
	 * Display a menu button
	 */
    private function button(x:Int, y:Int, text:String, callback:Void->Void) {

        var btn = new FlxButton(x, y, "", callback);
        btn.loadGraphic("images/button5.png");
        add(btn);

        var txt = new FlxText(x, y+15, 150);
        txt.text = text;
        txt.setFormat(Reg.font, 30, FlxColor.BLACK, "center");
        add(txt);
    
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
	}	
}