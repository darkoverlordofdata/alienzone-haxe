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
 * Static Blackboard
 * 
 *  world knowledge & events
 *
 *
 */
class Reg {

	public static var SHOW_FPS:Bool = true;				//	display frames per second?
	public static var discoveredGems:Array<String>;   	//  all the discovered crystals
	public static var puzzle:Grid;                     	//  the 7 x 6 puzzle grid


	/**
	 * event bank
	 */
	private static var _drop 	= new FlxTypedSignal<Array<Entity>->Void>();
	private static var _action 	= new FlxTypedSignal<String->FlxSprite->Void>();
	private static var _create 	= new FlxTypedSignal<Void->Void>();
	private static var _upgrade = new FlxTypedSignal<Int->Void>();
	private static var _reset 	= new FlxTypedSignal<Void->Void>();
	private static var _scored 	= new FlxTypedSignal<Int->Void>();


	/**
	 * data
	 */
	private static var _rnd:Mersenne = new Mersenne();
	private static var _score:Int = 0;
	private static var _level:Int = 0;
	private static var _music:Bool = true;
	private static var _sfx:Bool = true;
	private static var _storeName:String = "alienzone";
	private static var _store:SharedObject;

	/**
	 *	static initializer for saved state
	 */
	private static var _initialize = (function(magic:Int):Bool {

		_store = SharedObject.getLocal(_storeName);
//		_store = new FlxSave();
//		_store.bind("alienzone");

		if (_store.data.format != magic) {
			_store.data.format = magic;
			_store.data.music = _music = true;
			_store.data.sfx = _sfx = true;
		} else {
			_music = _store.data.music;
			_sfx = _store.data.sfx;
		}
		return true;

	})(0xd16a);

	public static var volume(get_volume, never):Float;
	
	private static function get_volume():Float {
		return _sfx ? Res.VOLUME_ON : Res.VOLUME_OFF;
	}

	public static var scored(get_scored, never):FlxTypedSignal<Int->Void>;

	private static function get_scored():FlxTypedSignal<Int->Void> {
		return _scored;
	}

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

	public static var level(get_level, set_level):Int;
	
	private static function get_level():Int {
		return _level;
	}

	private static function set_level(value:Int) {
		_level = value;
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
				_store.data.music = value;
				_store.flush();
			case 'sfx':
				_sfx = value;
				_store.data.sfx = value;
				_store.flush();
		}
	}

}