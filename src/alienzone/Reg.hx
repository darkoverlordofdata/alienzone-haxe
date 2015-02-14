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

import alienzone.match3.Grid;
import ash.core.Entity;
import flixel.FlxSprite;
import flixel.util.FlxSignal.FlxTypedSignal;
import flash.net.SharedObject;

/**
 * So-Called Static Blackboard
 */
class Reg {

	public static var SHOW_FPS:Bool = true;				//	display frames per second?
	public static var discoveredGems:Array<String>;   	//  all the discovered crystals
	public static var puzzle:Grid;                     	//  the 7 x 6 puzzle grid

	/**
	 * the event bus
	 */
	private static var _drop = new FlxTypedSignal<Array<Entity>->Void>();
	private static var _action = new FlxTypedSignal<String->FlxSprite->Void>();
	private static var _create = new FlxTypedSignal<Void->Void>();
	private static var _upgrade = new FlxTypedSignal<Int->Void>();
	private static var _reset = new FlxTypedSignal<Void->Void>();
	private static var _scored = new FlxTypedSignal<Int->Void>();


	private static var _storage:String = "alienzone";
	private static var _rnd:Mersenne = new Mersenne();
	private static var _score:Int = 0;
	private static var _legend:Int = 0;
	private static var _music:Bool = true;
	private static var _sfx:Bool = true;
	private static var _save:SharedObject;

	/**
	 *	static initializer for saved state
	 */
	private static var _initialize = (function(magic:Int):Bool {

		_save = SharedObject.getLocal(_storage);
//		_save = new FlxSave();
//		_save.bind("alienzone");

		if (_save.data.format != magic) {
			_save.data.format = magic;
			_save.data.music = _music = true;
			_save.data.sfx = _sfx = true;
		} else {
			_music = _save.data.music;
			_sfx = _save.data.sfx;
		}
		return true;

	})(0xd16a);


	public static var upgrade(get_upgrade, never):FlxTypedSignal<Int->Void>;

	private static function get_upgrade():FlxTypedSignal<Int->Void> {
		return _upgrade;
	}

	
	public static var dropGem(get_dropGem, never):FlxTypedSignal<Array<Entity>->Void>;
	
	private static function get_dropGem():FlxTypedSignal<Array<Entity>->Void> {
		return _drop;
	}
	
	public static var createGems(get_createGems, never):FlxTypedSignal<Void->Void>;
	
	private static function get_createGems():FlxTypedSignal<Void->Void> {
		return _create;
	}

	public static var rnd(get_rnd, never):Mersenne;
	
	private static function get_rnd():Mersenne {
		return _rnd;
	}

	public static var legend(get_legend, set_legend):Int;
	
	private static function get_legend():Int {
		return _legend;
	}

	private static function set_legend(value:Int) {
		_legend = value;
		_upgrade.dispatch(value);
		return value;
	}

	public static var score(get_score, never):Int;

	private static function get_score():Int {
		return _score;
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