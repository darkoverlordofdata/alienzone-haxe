/**
 *--------------------------------------------------------------------+
 * Res.hx
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014-2015
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

/**
 * Resources
 */
class Res {

	public static var VOLUME_ON  = 0.5;
	public static var VOLUME_OFF = 0.0;
	public static var SFX_COUNT:Int = 19;			// sound effects
	public static var GEMSIZE:Int = 48;          	// Gem size constant in pixels
	public static var GEMTYPES:Array<String> = [    // All gem types:
		"blue",
		"cyan",
		"green",
		"magenta",
		"orange",
		"pink",
		"red",
		"yellow"
	];

	public static var sprite = [

        'achievement' => {path: "images/achievement.png", 	    width: 32,	height: 32},
        'googleplay' => {path: "images/googleplay.png", 	    width: 32,	height: 32},
		'title' =>		{path: "images/title.png", 			    width: 300,	height: 100},
		'infinity' =>	{path: "images/infinity.png", 		    width: 150, height: 60},
		'ftl' =>		{path: "images/ftl.png", 			    width: 150, height: 60},
		'music' =>		{path: 'images/music_option.png', 	    width: 47, 	height: 57},
		'sfx' =>		{path: 'images/sfx_option.png', 	    width: 70, 	height: 61},
		'help' =>		{path: 'images/instructions.png', 	    width: 100, height: 24},
		'legend' =>	 	{path: "images/legend.png", 		    width: 24, 	height: 24},
		'slots' => 		{path: "images/slots.png", 			    width: 288, height: 432},
		'left' => 		{path: "images/arrows/left.png", 	    width: 48, 	height: 48},
		'down' => 		{path: "images/arrows/down.png", 	    width: 48, 	height: 48},
		'right' => 		{path: "images/arrows/right.png", 	    width: 48, 	height: 48},
		'lrot' => 		{path: "images/arrows/lrot.png", 	    width: 48, 	height: 48},
		'rrot' => 		{path: "images/arrows/rrot.png", 	    width: 48, 	height: 48},
		'scores' =>		{path: "images/scores.png", 		    width: 290, height: 350},
        'save' =>		{path: "images/save.png", 		        width: 100, height: 24},
		'logo' =>		{path: "images/d16a.png", 			    width: 112, height: 115},
		'back' =>		{path: "images/back.png", 			    width: 51, 	height: 27},
		'gem' =>		{path: "images/gems.png",			    width: 48,	height: 48},
        'controller' => {path: "images/games_controller.png",   width: 64,  height: 64},
        'awards' =>     {path: "images/games_achievements.png", width: 64,  height: 64},
        'leaders' =>    {path: "images/games_leaderboards.png", width: 64,  height: 64}
	
	];



}