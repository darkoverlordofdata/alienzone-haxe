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
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

import flixel.text.FlxBitmapTextField;
import flixel.text.pxText.PxBitmapFont;
import flixel.text.pxText.PxTextAlign;
import openfl.Assets;

import alienzone.FPS;


/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {

    private var font:PxBitmapFont;
    private var font0:PxBitmapFont;

    /**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create() {
		super.create();

        var XMLData = Xml.parse(Assets.getText("fonts/opendyslexic.fnt"));
        var XMLData0 = Xml.parse(Assets.getText("fonts/outlined.fnt"));
        font = new PxBitmapFont().loadAngelCode(Assets.getBitmapData("fonts/opendyslexic_0.png"), XMLData);
        font0 = new PxBitmapFont().loadAngelCode(Assets.getBitmapData("fonts/outlined_0.png"), XMLData0);

        title(0, 50, "AlienZone");
        button(80, 150, "Infinity", onInfinity);
        button(80, 250, "FTL", onFTL);
//        add(new FPS());

    }

    /**
	 * Display the game title
	 */
    private function title(x:Int, y:Int, text:String) {
        
        var title:FlxBitmapTextField = new FlxBitmapTextField(font0);
        title.x = x;
        title.y = y;
        title.fixedWidth = true;
        title.color = FlxColor.YELLOW;
        title.useTextColor = false;
        title.text = text;
        title.outlineColor = FlxColor.RED;
        title.width = 320;
        title.alignment = PxTextAlign.CENTER;
        title.fontScale = 2.2;
        add(title);
    }

    /**
	 * Display a menu button
	 */
    private function button(x:Int, y:Int, text:String, callback:Void->Void) {

        var btn = new FlxButton(x, y, "", callback);
        btn.loadGraphic("images/button5.png");
        add(btn);

        var txt:FlxBitmapTextField = new FlxBitmapTextField(font);
        txt.x = x;
        txt.y = y+10;
        txt.fixedWidth = true;
        txt.color = FlxColor.BLACK;
        txt.useTextColor = false;
        txt.text = text;
        txt.width = 150;
        txt.alignment = PxTextAlign.CENTER;
        txt.fontScale = 1.2;
        add(txt);

//        var txt = new FlxText(x, y+15, 150);
//        txt.text = text;
//        txt.setFormat(Reg.font, 30, FlxColor.BLACK, "center");
//        add(txt);
    
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