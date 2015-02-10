/**
 *--------------------------------------------------------------------+
 * Reg.hx
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

import flixel.FlxSprite;
import flixel.util.FlxSignal.FlxTypedSignal;
import flixel.util.FlxSave;
import flash.net.SharedObject;

class Reg {

	public static var SHOW_FPS:Bool = true;
	public static var rnd:Mersenne = new Mersenne();

	private static var _action = new FlxTypedSignal<String->FlxSprite->Void>();
	private static var _pegged = new FlxTypedSignal<Int->Void>();
	private static var _reset = new FlxTypedSignal<Void->Void>();
	private static var _scored = new FlxTypedSignal<Int->Void>();
	private static var _score:Int = 0;
	private static var _legend:Int = 0;
	private static var _music:Bool = true;
	private static var _sfx:Bool = true;
	private static var _save:SharedObject;
	private static var _loader = {

		_save = SharedObject.getLocal("alienzone");
//		_save = new FlxSave();
//		_save.bind("alienzone");
	
		if (_save.data.format != 0xd16a) {
			_save.data.format = 0xd16a;
			_save.data.music = _music = true;
			_save.data.sfx = _sfx = true;
		} else {
			_music = _save.data.music;
			_sfx = _save.data.sfx;
		}
		true;

	};
	
	public static var legend(get_legend, set_legend):Int;
	
	public static function get_legend():Int {
		return _legend;
	}
	
	public static function set_legend(value:Int) {
		_legend = value;
		_pegged.dispatch(value);
		return value;
	}
	
	public static function updateScore(points:Int) {
		_score += points;
		_scored.dispatch(points);
	}
	
	public static function getPreference(id:String):Bool {
		switch (id) {
			case 'music':	return _music;
			case 'sfx':		return _sfx;
		}
		return false;
	}
	
	/**
	 * Persist the preference change
	 */
	public static function setPreference(id:String, value:Bool):Void {
		switch (id) {
			case 'music': 	
				_music = value;
				_save.data.music = value;
				_save.flush();
			case 'sfx':
				_sfx = value;
				_save.data.sfx = value;
				_save.flush();
		}
	}

}