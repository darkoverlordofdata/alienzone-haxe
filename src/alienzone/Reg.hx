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

import alienzone.states.PlayState.GameType;
import alienzone.match3.Grid;
import alienzone.model.AwardData;
import alienzone.model.LeaderData;
import ash.core.Entity;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import flixel.util.FlxSignal.FlxTypedSignal;
import flixel.util.FlxSignal;


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
	public static var difficulty:Int = 0;

	public static var createGems(get_createGems, never):FlxTypedSignal<Void->Void>;
    public static var data(get_data, never):Dynamic;
	public static var dropGem(get_dropGem, never):FlxTypedSignal<Array<Entity>->Void>;
	public static var level(get_level, set_level):Int;
	public static var music(get_music, never):Bool;
	public static var rnd(get_rnd, never):Mersenne;
    public static var reset(get_reset, never):FlxTypedSignal<Void->Void>;
	public static var score(get_score, never):Int;
	public static var scored(get_scored, never):FlxTypedSignal<Int->Void>;
	public static var sfx(get_sfx, never):Bool;
    public static var timer(get_timer, never):FlxTypedSignal<Void->Void>;
	public static var type(get_type, never):GameType;
	public static var upgrade(get_upgrade, never):FlxTypedSignal<Int->Void>;
	public static var volume(get_volume, never):Float;
	
	/**
	 * event bank
	 */
	private static var _action:FlxTypedSignal<String->FlxSprite->Void> 	= new FlxTypedSignal<String->FlxSprite->Void>();
	private static var _create:FlxSignal 	= new FlxSignal();
	private static var _drop:FlxTypedSignal<Array<Entity>->Void> 	= new FlxTypedSignal<Array<Entity>->Void>();
	private static var _reset:FlxTypedSignal<Void->Void> 	= new FlxTypedSignal<Void->Void>();
	private static var _scored:FlxTypedSignal<Int->Void> 	= new FlxTypedSignal<Int->Void>();
    private static var _timer:FlxTypedSignal<Void->Void> 	= new FlxTypedSignal<Void->Void>();
	private static var _upgrade:FlxTypedSignal<Int->Void> 	= new FlxTypedSignal<Int->Void>();

	private static var _magic:Int = 0xd16a;
	private static var _id:String = "alienzone";

	/**
	 * model
	 */
	private static var _level:Int = 0;
	private static var _music:Bool = true;
	private static var _rnd:Mersenne = new Mersenne();
	private static var _score:Int = 0;
	private static var _sfx:Bool = true;
	private static var _store:FlxSave;
	private static var _storeName:String = "alienzone";
	private static var _type:GameType;

    /**
     * Template leaderboard model
     */
    private static var _leaderboards = [
    {id: 'CgkI3YOVjfAZEAIQBg', title: 'Infinity', image: 'images/icon.png', score: 0},
    {id: 'CgkI3YOVjfAZEAIQBw', title: 'FTL', image: 'images/icon.png', score: 0}
    ];

    /**
     * Template achievement model
     */
    private static var _achievements = [
    {id: 'CgkI3YOVjfAZEAIQAQ', title: 'Combo', desc: 'Make 2 scores with 1 drop', image: 'images/icon.png', lock: false},
    {id: 'CgkI3YOVjfAZEAIQAg', title: 'Cascading', desc: 'After your first score, the crystals settle and you make another score', image: 'images/icon.png', lock: false},
    {id: 'CgkI3YOVjfAZEAIQAw', title: 'Triple', desc: 'Score with 3 of a kind', image: 'images/icon.png', lock: false},
    {id: 'CgkI3YOVjfAZEAIQBA', title: 'Quad', desc: 'Score with 4 of a kind', image: 'images/icon.png', lock: false},
    {id: 'CgkI3YOVjfAZEAIQBQ', title: 'Cascading Combo', desc: 'Your combo results in a cascade', image: 'images/icon.png', lock: false}
    ];

	private static function get_type():GameType {
		return _type;
	}
	
    private static function get_data():Dynamic {
        return save().data;
    }
	private static function get_volume():Float {
		return _sfx ? Res.VOLUME_ON : Res.VOLUME_OFF;
	}

	private static function get_sfx():Bool {
		return _sfx;
	}

	private static function get_music():Bool {
		return _music;
	}

	private static function get_scored():FlxTypedSignal<Int->Void> {
		return _scored;
	}

	private static function get_upgrade():FlxTypedSignal<Int->Void> {
		return _upgrade;
	}

	private static function get_dropGem():FlxTypedSignal<Array<Entity>->Void> {
		return _drop;
	}

	private static function get_createGems():FlxTypedSignal<Void->Void> {
		return _create;
	}

    private static function get_reset():FlxTypedSignal<Void->Void> {
        return _reset;
    }

    private static function get_rnd():Mersenne {
		return _rnd;
	}

    private static function get_timer():FlxTypedSignal<Void->Void> {
        return _timer;
    }

    private static function get_level():Int {
		return _level;
	}

	private static function set_level(value:Int) {
		_level = value;
		_upgrade.dispatch(value);
		return value;
	}

	private static function get_score():Int {
		return _score;
	}

	/**
	 * Init
	 * 
	 * Make sure we're initialized
	 *
	 * Note: This must be called from an instance method
	 *
	 */
	public static function save():FlxSave {
		if (_store == null) {
			_store = new FlxSave();
			_store.bind(_id);

			/**
			 * format the model store?
			 */
			if (_store.data.format != _magic) {
				_store.data.format = _magic;
				_store.data.music = true;
				_store.data.sfx = true;
				_store.data.id = _id;
                _store.data.awards = new Array();
                for (award in _achievements) {
                    _store.data.awards.push(new AwardData(award.id, award.title, award.desc, award.image, award.lock));
                }
                _store.data.leaders = new Array();
                for (leader in _leaderboards) {
                    _store.data.leaders.push(new LeaderData(leader.id, leader.title, leader.image, leader.score));
                }
				_store.flush();
			}
			
			/**
			 * load persisted values
			 */
			_music = _store.data.music;
			_sfx = _store.data.sfx;
		}
		return _store;
	}
	
	public static function init(type:GameType, score:Int) {
		_type = type;
		_score = score;
		if (score == 0) {
			difficulty = 0;
		} else {
			difficulty += 1;
		}
	}

	/**
	 * Add points to the score
	 */
	public static function updateScore(points:Int) {
		_score += points;
		_scored.dispatch(points);
	}

	/**
	 * Get the option preference
	 */
	public static function getPreference(id:String):Bool {
		switch (id) {
			case 'music':	return _music;
			case 'sfx':		return _sfx;
		}
		return false;
	}
	
	/**
	 * Save the option preference
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