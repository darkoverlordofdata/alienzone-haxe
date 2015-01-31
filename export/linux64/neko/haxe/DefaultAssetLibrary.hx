package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if (flash || js)
import openfl.display.Loader;
import openfl.events.Event;
import openfl.net.URLLoader;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl._v2.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		path.set ("assets/sounds/sfx/Powerup8.ogg", "assets/sounds/sfx/Powerup8.ogg");
		type.set ("assets/sounds/sfx/Powerup8.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup10.ogg", "assets/sounds/sfx/Powerup10.ogg");
		type.set ("assets/sounds/sfx/Powerup10.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup19.ogg", "assets/sounds/sfx/Powerup19.ogg");
		type.set ("assets/sounds/sfx/Powerup19.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup2.ogg", "assets/sounds/sfx/Powerup2.ogg");
		type.set ("assets/sounds/sfx/Powerup2.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup19.m4a", "assets/sounds/sfx/Powerup19.m4a");
		type.set ("assets/sounds/sfx/Powerup19.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup7.m4a", "assets/sounds/sfx/Powerup7.m4a");
		type.set ("assets/sounds/sfx/Powerup7.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup17.m4a", "assets/sounds/sfx/Powerup17.m4a");
		type.set ("assets/sounds/sfx/Powerup17.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup10.m4a", "assets/sounds/sfx/Powerup10.m4a");
		type.set ("assets/sounds/sfx/Powerup10.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup11.m4a", "assets/sounds/sfx/Powerup11.m4a");
		type.set ("assets/sounds/sfx/Powerup11.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup20.m4a", "assets/sounds/sfx/Powerup20.m4a");
		type.set ("assets/sounds/sfx/Powerup20.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup20.ogg", "assets/sounds/sfx/Powerup20.ogg");
		type.set ("assets/sounds/sfx/Powerup20.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup3.m4a", "assets/sounds/sfx/Powerup3.m4a");
		type.set ("assets/sounds/sfx/Powerup3.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup18.ogg", "assets/sounds/sfx/Powerup18.ogg");
		type.set ("assets/sounds/sfx/Powerup18.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup3.ogg", "assets/sounds/sfx/Powerup3.ogg");
		type.set ("assets/sounds/sfx/Powerup3.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup17.ogg", "assets/sounds/sfx/Powerup17.ogg");
		type.set ("assets/sounds/sfx/Powerup17.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup9.m4a", "assets/sounds/sfx/Powerup9.m4a");
		type.set ("assets/sounds/sfx/Powerup9.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup2.m4a", "assets/sounds/sfx/Powerup2.m4a");
		type.set ("assets/sounds/sfx/Powerup2.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup.m4a", "assets/sounds/sfx/Powerup.m4a");
		type.set ("assets/sounds/sfx/Powerup.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup4.ogg", "assets/sounds/sfx/Powerup4.ogg");
		type.set ("assets/sounds/sfx/Powerup4.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup14.ogg", "assets/sounds/sfx/Powerup14.ogg");
		type.set ("assets/sounds/sfx/Powerup14.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup18.m4a", "assets/sounds/sfx/Powerup18.m4a");
		type.set ("assets/sounds/sfx/Powerup18.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup7.ogg", "assets/sounds/sfx/Powerup7.ogg");
		type.set ("assets/sounds/sfx/Powerup7.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup8.m4a", "assets/sounds/sfx/Powerup8.m4a");
		type.set ("assets/sounds/sfx/Powerup8.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup14.m4a", "assets/sounds/sfx/Powerup14.m4a");
		type.set ("assets/sounds/sfx/Powerup14.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup13.ogg", "assets/sounds/sfx/Powerup13.ogg");
		type.set ("assets/sounds/sfx/Powerup13.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup.ogg", "assets/sounds/sfx/Powerup.ogg");
		type.set ("assets/sounds/sfx/Powerup.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup15.ogg", "assets/sounds/sfx/Powerup15.ogg");
		type.set ("assets/sounds/sfx/Powerup15.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup15.m4a", "assets/sounds/sfx/Powerup15.m4a");
		type.set ("assets/sounds/sfx/Powerup15.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup13.m4a", "assets/sounds/sfx/Powerup13.m4a");
		type.set ("assets/sounds/sfx/Powerup13.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup5.m4a", "assets/sounds/sfx/Powerup5.m4a");
		type.set ("assets/sounds/sfx/Powerup5.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup11.ogg", "assets/sounds/sfx/Powerup11.ogg");
		type.set ("assets/sounds/sfx/Powerup11.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup6.ogg", "assets/sounds/sfx/Powerup6.ogg");
		type.set ("assets/sounds/sfx/Powerup6.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup12.ogg", "assets/sounds/sfx/Powerup12.ogg");
		type.set ("assets/sounds/sfx/Powerup12.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup16.m4a", "assets/sounds/sfx/Powerup16.m4a");
		type.set ("assets/sounds/sfx/Powerup16.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup4.m4a", "assets/sounds/sfx/Powerup4.m4a");
		type.set ("assets/sounds/sfx/Powerup4.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup6.m4a", "assets/sounds/sfx/Powerup6.m4a");
		type.set ("assets/sounds/sfx/Powerup6.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup5.ogg", "assets/sounds/sfx/Powerup5.ogg");
		type.set ("assets/sounds/sfx/Powerup5.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup16.ogg", "assets/sounds/sfx/Powerup16.ogg");
		type.set ("assets/sounds/sfx/Powerup16.ogg", AssetType.SOUND);
		path.set ("assets/sounds/sfx/Powerup12.m4a", "assets/sounds/sfx/Powerup12.m4a");
		type.set ("assets/sounds/sfx/Powerup12.m4a", AssetType.BINARY);
		path.set ("assets/sounds/sfx/Powerup9.ogg", "assets/sounds/sfx/Powerup9.ogg");
		type.set ("assets/sounds/sfx/Powerup9.ogg", AssetType.SOUND);
		path.set ("assets/images/button4.png", "assets/images/button4.png");
		type.set ("assets/images/button4.png", AssetType.IMAGE);
		path.set ("assets/images/slots.png", "assets/images/slots.png");
		type.set ("assets/images/slots.png", AssetType.IMAGE);
		path.set ("assets/images/d16a.png", "assets/images/d16a.png");
		type.set ("assets/images/d16a.png", AssetType.IMAGE);
		path.set ("assets/images/legend.png", "assets/images/legend.png");
		type.set ("assets/images/legend.png", AssetType.IMAGE);
		path.set ("assets/images/bucky.png", "assets/images/bucky.png");
		type.set ("assets/images/bucky.png", AssetType.IMAGE);
		path.set ("assets/images/star17 (copy).png", "assets/images/star17 (copy).png");
		type.set ("assets/images/star17 (copy).png", AssetType.IMAGE);
		path.set ("assets/images/button5.png", "assets/images/button5.png");
		type.set ("assets/images/button5.png", AssetType.IMAGE);
		path.set ("assets/images/button2.png", "assets/images/button2.png");
		type.set ("assets/images/button2.png", AssetType.IMAGE);
		path.set ("assets/images/legend_board.png", "assets/images/legend_board.png");
		type.set ("assets/images/legend_board.png", AssetType.IMAGE);
		path.set ("assets/images/09-white.png", "assets/images/09-white.png");
		type.set ("assets/images/09-white.png", AssetType.IMAGE);
		path.set ("assets/images/orientation.jpg", "assets/images/orientation.jpg");
		type.set ("assets/images/orientation.jpg", AssetType.IMAGE);
		path.set ("assets/images/loading.png", "assets/images/loading.png");
		type.set ("assets/images/loading.png", AssetType.IMAGE);
		path.set ("assets/images/gems.png", "assets/images/gems.png");
		type.set ("assets/images/gems.png", AssetType.IMAGE);
		path.set ("assets/images/achievement.png", "assets/images/achievement.png");
		type.set ("assets/images/achievement.png", AssetType.IMAGE);
		path.set ("assets/images/en_generic_rgb_wo_45.png", "assets/images/en_generic_rgb_wo_45.png");
		type.set ("assets/images/en_generic_rgb_wo_45.png", AssetType.IMAGE);
		path.set ("assets/images/button.png", "assets/images/button.png");
		type.set ("assets/images/button.png", AssetType.IMAGE);
		path.set ("assets/images/arrows/left.png", "assets/images/arrows/left.png");
		type.set ("assets/images/arrows/left.png", AssetType.IMAGE);
		path.set ("assets/images/arrows/right.png", "assets/images/arrows/right.png");
		type.set ("assets/images/arrows/right.png", AssetType.IMAGE);
		path.set ("assets/images/arrows/down.png", "assets/images/arrows/down.png");
		type.set ("assets/images/arrows/down.png", AssetType.IMAGE);
		path.set ("assets/images/arrows/lrot.png", "assets/images/arrows/lrot.png");
		type.set ("assets/images/arrows/lrot.png", AssetType.IMAGE);
		path.set ("assets/images/arrows/rrot.png", "assets/images/arrows/rrot.png");
		type.set ("assets/images/arrows/rrot.png", AssetType.IMAGE);
		path.set ("assets/images/games_achievements.png", "assets/images/games_achievements.png");
		type.set ("assets/images/games_achievements.png", AssetType.IMAGE);
		path.set ("assets/images/music_option.png", "assets/images/music_option.png");
		type.set ("assets/images/music_option.png", AssetType.IMAGE);
		path.set ("assets/images/scores.png", "assets/images/scores.png");
		type.set ("assets/images/scores.png", AssetType.IMAGE);
		path.set ("assets/images/sfx_option.png", "assets/images/sfx_option.png");
		type.set ("assets/images/sfx_option.png", AssetType.IMAGE);
		path.set ("assets/images/games_controller.png", "assets/images/games_controller.png");
		type.set ("assets/images/games_controller.png", AssetType.IMAGE);
		path.set ("assets/images/logo.png", "assets/images/logo.png");
		type.set ("assets/images/logo.png", AssetType.IMAGE);
		path.set ("assets/images/09-red.png", "assets/images/09-red.png");
		type.set ("assets/images/09-red.png", AssetType.IMAGE);
		path.set ("assets/images/star17.png", "assets/images/star17.png");
		type.set ("assets/images/star17.png", AssetType.IMAGE);
		path.set ("assets/images/games_leaderboards.png", "assets/images/games_leaderboards.png");
		type.set ("assets/images/games_leaderboards.png", AssetType.IMAGE);
		path.set ("assets/images/icon.png", "assets/images/icon.png");
		type.set ("assets/images/icon.png", AssetType.IMAGE);
		path.set ("assets/images/label.png", "assets/images/label.png");
		type.set ("assets/images/label.png", AssetType.IMAGE);
		path.set ("assets/config/config.yaml", "assets/config/config.yaml");
		type.set ("assets/config/config.yaml", AssetType.TEXT);
		path.set ("assets/fonts/OpenDyslexic-BoldItalic.ttf", "assets/fonts/OpenDyslexic-BoldItalic.ttf");
		type.set ("assets/fonts/OpenDyslexic-BoldItalic.ttf", AssetType.FONT);
		path.set ("assets/fonts/OpenDyslexicAlta-Regular.ttf", "assets/fonts/OpenDyslexicAlta-Regular.ttf");
		type.set ("assets/fonts/OpenDyslexicAlta-Regular.ttf", AssetType.FONT);
		path.set ("assets/fonts/OpenDyslexicAlta-Bold.ttf", "assets/fonts/OpenDyslexicAlta-Bold.ttf");
		type.set ("assets/fonts/OpenDyslexicAlta-Bold.ttf", AssetType.FONT);
		path.set ("assets/fonts/OpenDyslexic-Regular.ttf", "assets/fonts/OpenDyslexic-Regular.ttf");
		type.set ("assets/fonts/OpenDyslexic-Regular.ttf", AssetType.FONT);
		path.set ("assets/fonts/OpenDyslexic-Italic.ttf", "assets/fonts/OpenDyslexic-Italic.ttf");
		type.set ("assets/fonts/OpenDyslexic-Italic.ttf", AssetType.FONT);
		path.set ("assets/fonts/OpenDyslexicMono-Regular.ttf", "assets/fonts/OpenDyslexicMono-Regular.ttf");
		type.set ("assets/fonts/OpenDyslexicMono-Regular.ttf", AssetType.FONT);
		path.set ("assets/fonts/OpenDyslexicAlta-BoldItalic.ttf", "assets/fonts/OpenDyslexicAlta-BoldItalic.ttf");
		type.set ("assets/fonts/OpenDyslexicAlta-BoldItalic.ttf", AssetType.FONT);
		path.set ("assets/fonts/OpenDyslexicAlta-Italic.ttf", "assets/fonts/OpenDyslexicAlta-Italic.ttf");
		type.set ("assets/fonts/OpenDyslexicAlta-Italic.ttf", AssetType.FONT);
		path.set ("assets/fonts/OpenDyslexic-Bold.ttf", "assets/fonts/OpenDyslexic-Bold.ttf");
		type.set ("assets/fonts/OpenDyslexic-Bold.ttf", AssetType.FONT);
		path.set ("fonts/OpenDyslexic-BoldItalic.ttf", "fonts/OpenDyslexic-BoldItalic.ttf");
		type.set ("fonts/OpenDyslexic-BoldItalic.ttf", AssetType.FONT);
		path.set ("fonts/OpenDyslexicAlta-Regular.ttf", "fonts/OpenDyslexicAlta-Regular.ttf");
		type.set ("fonts/OpenDyslexicAlta-Regular.ttf", AssetType.FONT);
		path.set ("fonts/OpenDyslexicAlta-Bold.ttf", "fonts/OpenDyslexicAlta-Bold.ttf");
		type.set ("fonts/OpenDyslexicAlta-Bold.ttf", AssetType.FONT);
		path.set ("fonts/OpenDyslexic-Regular.ttf", "fonts/OpenDyslexic-Regular.ttf");
		type.set ("fonts/OpenDyslexic-Regular.ttf", AssetType.FONT);
		path.set ("fonts/OpenDyslexic-Italic.ttf", "fonts/OpenDyslexic-Italic.ttf");
		type.set ("fonts/OpenDyslexic-Italic.ttf", AssetType.FONT);
		path.set ("fonts/OpenDyslexicMono-Regular.ttf", "fonts/OpenDyslexicMono-Regular.ttf");
		type.set ("fonts/OpenDyslexicMono-Regular.ttf", AssetType.FONT);
		path.set ("fonts/OpenDyslexicAlta-BoldItalic.ttf", "fonts/OpenDyslexicAlta-BoldItalic.ttf");
		type.set ("fonts/OpenDyslexicAlta-BoldItalic.ttf", AssetType.FONT);
		path.set ("fonts/OpenDyslexicAlta-Italic.ttf", "fonts/OpenDyslexicAlta-Italic.ttf");
		type.set ("fonts/OpenDyslexicAlta-Italic.ttf", AssetType.FONT);
		path.set ("fonts/OpenDyslexic-Bold.ttf", "fonts/OpenDyslexic-Bold.ttf");
		type.set ("fonts/OpenDyslexic-Bold.ttf", AssetType.FONT);
		path.set ("images/button4.png", "images/button4.png");
		type.set ("images/button4.png", AssetType.IMAGE);
		path.set ("images/slots.png", "images/slots.png");
		type.set ("images/slots.png", AssetType.IMAGE);
		path.set ("images/d16a.png", "images/d16a.png");
		type.set ("images/d16a.png", AssetType.IMAGE);
		path.set ("images/legend.png", "images/legend.png");
		type.set ("images/legend.png", AssetType.IMAGE);
		path.set ("images/bucky.png", "images/bucky.png");
		type.set ("images/bucky.png", AssetType.IMAGE);
		path.set ("images/star17 (copy).png", "images/star17 (copy).png");
		type.set ("images/star17 (copy).png", AssetType.IMAGE);
		path.set ("images/button5.png", "images/button5.png");
		type.set ("images/button5.png", AssetType.IMAGE);
		path.set ("images/button2.png", "images/button2.png");
		type.set ("images/button2.png", AssetType.IMAGE);
		path.set ("images/legend_board.png", "images/legend_board.png");
		type.set ("images/legend_board.png", AssetType.IMAGE);
		path.set ("images/09-white.png", "images/09-white.png");
		type.set ("images/09-white.png", AssetType.IMAGE);
		path.set ("images/orientation.jpg", "images/orientation.jpg");
		type.set ("images/orientation.jpg", AssetType.IMAGE);
		path.set ("images/loading.png", "images/loading.png");
		type.set ("images/loading.png", AssetType.IMAGE);
		path.set ("images/gems.png", "images/gems.png");
		type.set ("images/gems.png", AssetType.IMAGE);
		path.set ("images/achievement.png", "images/achievement.png");
		type.set ("images/achievement.png", AssetType.IMAGE);
		path.set ("images/en_generic_rgb_wo_45.png", "images/en_generic_rgb_wo_45.png");
		type.set ("images/en_generic_rgb_wo_45.png", AssetType.IMAGE);
		path.set ("images/button.png", "images/button.png");
		type.set ("images/button.png", AssetType.IMAGE);
		path.set ("images/arrows/left.png", "images/arrows/left.png");
		type.set ("images/arrows/left.png", AssetType.IMAGE);
		path.set ("images/arrows/right.png", "images/arrows/right.png");
		type.set ("images/arrows/right.png", AssetType.IMAGE);
		path.set ("images/arrows/down.png", "images/arrows/down.png");
		type.set ("images/arrows/down.png", AssetType.IMAGE);
		path.set ("images/arrows/lrot.png", "images/arrows/lrot.png");
		type.set ("images/arrows/lrot.png", AssetType.IMAGE);
		path.set ("images/arrows/rrot.png", "images/arrows/rrot.png");
		type.set ("images/arrows/rrot.png", AssetType.IMAGE);
		path.set ("images/games_achievements.png", "images/games_achievements.png");
		type.set ("images/games_achievements.png", AssetType.IMAGE);
		path.set ("images/music_option.png", "images/music_option.png");
		type.set ("images/music_option.png", AssetType.IMAGE);
		path.set ("images/scores.png", "images/scores.png");
		type.set ("images/scores.png", AssetType.IMAGE);
		path.set ("images/sfx_option.png", "images/sfx_option.png");
		type.set ("images/sfx_option.png", AssetType.IMAGE);
		path.set ("images/games_controller.png", "images/games_controller.png");
		type.set ("images/games_controller.png", AssetType.IMAGE);
		path.set ("images/logo.png", "images/logo.png");
		type.set ("images/logo.png", AssetType.IMAGE);
		path.set ("images/09-red.png", "images/09-red.png");
		type.set ("images/09-red.png", AssetType.IMAGE);
		path.set ("images/star17.png", "images/star17.png");
		type.set ("images/star17.png", AssetType.IMAGE);
		path.set ("images/games_leaderboards.png", "images/games_leaderboards.png");
		type.set ("images/games_leaderboards.png", AssetType.IMAGE);
		path.set ("images/icon.png", "images/icon.png");
		type.set ("images/icon.png", AssetType.IMAGE);
		path.set ("images/label.png", "images/label.png");
		type.set ("images/label.png", AssetType.IMAGE);
		path.set ("sfx/Powerup8.ogg", "sfx/Powerup8.ogg");
		type.set ("sfx/Powerup8.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup10.ogg", "sfx/Powerup10.ogg");
		type.set ("sfx/Powerup10.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup19.ogg", "sfx/Powerup19.ogg");
		type.set ("sfx/Powerup19.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup2.ogg", "sfx/Powerup2.ogg");
		type.set ("sfx/Powerup2.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup19.m4a", "sfx/Powerup19.m4a");
		type.set ("sfx/Powerup19.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup7.m4a", "sfx/Powerup7.m4a");
		type.set ("sfx/Powerup7.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup17.m4a", "sfx/Powerup17.m4a");
		type.set ("sfx/Powerup17.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup10.m4a", "sfx/Powerup10.m4a");
		type.set ("sfx/Powerup10.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup11.m4a", "sfx/Powerup11.m4a");
		type.set ("sfx/Powerup11.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup20.m4a", "sfx/Powerup20.m4a");
		type.set ("sfx/Powerup20.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup20.ogg", "sfx/Powerup20.ogg");
		type.set ("sfx/Powerup20.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup3.m4a", "sfx/Powerup3.m4a");
		type.set ("sfx/Powerup3.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup18.ogg", "sfx/Powerup18.ogg");
		type.set ("sfx/Powerup18.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup3.ogg", "sfx/Powerup3.ogg");
		type.set ("sfx/Powerup3.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup17.ogg", "sfx/Powerup17.ogg");
		type.set ("sfx/Powerup17.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup9.m4a", "sfx/Powerup9.m4a");
		type.set ("sfx/Powerup9.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup2.m4a", "sfx/Powerup2.m4a");
		type.set ("sfx/Powerup2.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup.m4a", "sfx/Powerup.m4a");
		type.set ("sfx/Powerup.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup4.ogg", "sfx/Powerup4.ogg");
		type.set ("sfx/Powerup4.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup14.ogg", "sfx/Powerup14.ogg");
		type.set ("sfx/Powerup14.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup18.m4a", "sfx/Powerup18.m4a");
		type.set ("sfx/Powerup18.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup7.ogg", "sfx/Powerup7.ogg");
		type.set ("sfx/Powerup7.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup8.m4a", "sfx/Powerup8.m4a");
		type.set ("sfx/Powerup8.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup14.m4a", "sfx/Powerup14.m4a");
		type.set ("sfx/Powerup14.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup13.ogg", "sfx/Powerup13.ogg");
		type.set ("sfx/Powerup13.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup.ogg", "sfx/Powerup.ogg");
		type.set ("sfx/Powerup.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup15.ogg", "sfx/Powerup15.ogg");
		type.set ("sfx/Powerup15.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup15.m4a", "sfx/Powerup15.m4a");
		type.set ("sfx/Powerup15.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup13.m4a", "sfx/Powerup13.m4a");
		type.set ("sfx/Powerup13.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup5.m4a", "sfx/Powerup5.m4a");
		type.set ("sfx/Powerup5.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup11.ogg", "sfx/Powerup11.ogg");
		type.set ("sfx/Powerup11.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup6.ogg", "sfx/Powerup6.ogg");
		type.set ("sfx/Powerup6.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup12.ogg", "sfx/Powerup12.ogg");
		type.set ("sfx/Powerup12.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup16.m4a", "sfx/Powerup16.m4a");
		type.set ("sfx/Powerup16.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup4.m4a", "sfx/Powerup4.m4a");
		type.set ("sfx/Powerup4.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup6.m4a", "sfx/Powerup6.m4a");
		type.set ("sfx/Powerup6.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup5.ogg", "sfx/Powerup5.ogg");
		type.set ("sfx/Powerup5.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup16.ogg", "sfx/Powerup16.ogg");
		type.set ("sfx/Powerup16.ogg", AssetType.SOUND);
		path.set ("sfx/Powerup12.m4a", "sfx/Powerup12.m4a");
		type.set ("sfx/Powerup12.m4a", AssetType.BINARY);
		path.set ("sfx/Powerup9.ogg", "sfx/Powerup9.ogg");
		type.set ("sfx/Powerup9.ogg", AssetType.SOUND);
		path.set ("config/config.yaml", "config/config.yaml");
		type.set ("config/config.yaml", AssetType.TEXT);
		path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
		type.set ("assets/sounds/flixel.ogg", AssetType.SOUND);
		path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
		type.set ("assets/sounds/beep.ogg", AssetType.SOUND);
		
		
		#elseif html5
		
		var id;
		id = "assets/music/music-goes-here.txt";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/sfx/Powerup8.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup10.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup19.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup2.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup19.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup7.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup17.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup10.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup11.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup20.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup20.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup3.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup18.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup3.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup17.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup9.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup2.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup4.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup14.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup18.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup7.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup8.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup14.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup13.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup15.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup15.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup13.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup5.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup11.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup6.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup12.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup16.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup4.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup6.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup5.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup16.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sfx/Powerup12.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/sfx/Powerup9.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/images/button4.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/slots.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/d16a.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/legend.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bucky.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/star17 (copy).png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/button5.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/button2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/legend_board.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/09-white.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/orientation.jpg";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/loading.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/gems.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/achievement.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/en_generic_rgb_wo_45.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/button.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/arrows/left.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/arrows/right.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/arrows/down.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/arrows/lrot.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/arrows/rrot.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/games_achievements.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/music_option.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/scores.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/sfx_option.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/games_controller.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/logo.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/09-red.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/star17.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/games_leaderboards.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/icon.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/label.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/config/config.yaml";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/fonts/OpenDyslexic-BoldItalic.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexicAlta-Regular.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexicAlta-Bold.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexic-Regular.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexic-Italic.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexicMono-Regular.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexicAlta-BoldItalic.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexicAlta-Italic.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexic-Bold.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexic-BoldItalic.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexicAlta-Regular.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexicAlta-Bold.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexic-Regular.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexic-Italic.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexicMono-Regular.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexicAlta-BoldItalic.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexicAlta-Italic.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexic-Bold.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "images/button4.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/slots.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/d16a.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/legend.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/bucky.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/star17 (copy).png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/button5.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/button2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/legend_board.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/09-white.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/orientation.jpg";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/loading.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/gems.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/achievement.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/en_generic_rgb_wo_45.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/button.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/arrows/left.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/arrows/right.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/arrows/down.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/arrows/lrot.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/arrows/rrot.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/games_achievements.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/music_option.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/scores.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/sfx_option.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/games_controller.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/logo.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/09-red.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/star17.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/games_leaderboards.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/icon.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "images/label.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "sfx/Powerup8.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup10.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup19.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup2.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup19.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup7.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup17.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup10.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup11.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup20.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup20.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup3.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup18.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup3.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup17.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup9.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup2.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup4.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup14.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup18.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup7.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup8.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup14.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup13.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup15.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup15.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup13.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup5.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup11.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup6.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup12.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup16.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup4.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup6.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup5.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup16.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup12.m4a";
		path.set (id, id);
		type.set (id, AssetType.BINARY);
		id = "sfx/Powerup9.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "config/config.yaml";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/flixel.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/beep.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		
		
		#else
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		Font.registerFont (__ASSET__assets_fonts_opendyslexic_bolditalic_ttf);
		Font.registerFont (__ASSET__assets_fonts_opendyslexicalta_regular_ttf);
		Font.registerFont (__ASSET__assets_fonts_opendyslexicalta_bold_ttf);
		Font.registerFont (__ASSET__assets_fonts_opendyslexic_regular_ttf);
		Font.registerFont (__ASSET__assets_fonts_opendyslexic_italic_ttf);
		Font.registerFont (__ASSET__assets_fonts_opendyslexicmono_regular_ttf);
		Font.registerFont (__ASSET__assets_fonts_opendyslexicalta_bolditalic_ttf);
		Font.registerFont (__ASSET__assets_fonts_opendyslexicalta_italic_ttf);
		Font.registerFont (__ASSET__assets_fonts_opendyslexic_bold_ttf);
		Font.registerFont (__ASSET__fonts_opendyslexic_bolditalic_ttf);
		Font.registerFont (__ASSET__fonts_opendyslexicalta_regular_ttf);
		Font.registerFont (__ASSET__fonts_opendyslexicalta_bold_ttf);
		Font.registerFont (__ASSET__fonts_opendyslexic_regular_ttf);
		Font.registerFont (__ASSET__fonts_opendyslexic_italic_ttf);
		Font.registerFont (__ASSET__fonts_opendyslexicmono_regular_ttf);
		Font.registerFont (__ASSET__fonts_opendyslexicalta_bolditalic_ttf);
		Font.registerFont (__ASSET__fonts_opendyslexicalta_italic_ttf);
		Font.registerFont (__ASSET__fonts_opendyslexic_bold_ttf);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null || (assetType == BINARY && type == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);

		#elseif (js || openfl_html5 || pixi)
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash











































































































































































#elseif html5












































































@:keep #if display private #end class __ASSET__assets_fonts_opendyslexic_bolditalic_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexic Bold Italic"; } #end }
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexicalta_regular_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexicAlta"; } #end }
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexicalta_bold_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexicAlta Bold"; } #end }
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexic_regular_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexic"; } #end }
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexic_italic_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexic Italic"; } #end }
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexicmono_regular_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexicMono"; } #end }
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexicalta_bolditalic_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexicAlta Bold Italic"; } #end }
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexicalta_italic_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexicAlta Italic"; } #end }
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexic_bold_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexic Bold"; } #end }
@:keep #if display private #end class __ASSET__fonts_opendyslexic_bolditalic_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexic Bold Italic"; } #end }
@:keep #if display private #end class __ASSET__fonts_opendyslexicalta_regular_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexicAlta"; } #end }
@:keep #if display private #end class __ASSET__fonts_opendyslexicalta_bold_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexicAlta Bold"; } #end }
@:keep #if display private #end class __ASSET__fonts_opendyslexic_regular_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexic"; } #end }
@:keep #if display private #end class __ASSET__fonts_opendyslexic_italic_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexic Italic"; } #end }
@:keep #if display private #end class __ASSET__fonts_opendyslexicmono_regular_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexicMono"; } #end }
@:keep #if display private #end class __ASSET__fonts_opendyslexicalta_bolditalic_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexicAlta Bold Italic"; } #end }
@:keep #if display private #end class __ASSET__fonts_opendyslexicalta_italic_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexicAlta Italic"; } #end }
@:keep #if display private #end class __ASSET__fonts_opendyslexic_bold_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "OpenDyslexic Bold"; } #end }













































































#else

#if (windows || mac || linux)





@:keep class __ASSET__assets_fonts_opendyslexic_bolditalic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexic-BoldItalic.ttf"; fontName = "OpenDyslexic Bold Italic"; }}
@:keep class __ASSET__assets_fonts_opendyslexicalta_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexicAlta-Regular.ttf"; fontName = "OpenDyslexicAlta"; }}
@:keep class __ASSET__assets_fonts_opendyslexicalta_bold_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexicAlta-Bold.ttf"; fontName = "OpenDyslexicAlta Bold"; }}
@:keep class __ASSET__assets_fonts_opendyslexic_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexic-Regular.ttf"; fontName = "OpenDyslexic"; }}
@:keep class __ASSET__assets_fonts_opendyslexic_italic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexic-Italic.ttf"; fontName = "OpenDyslexic Italic"; }}
@:keep class __ASSET__assets_fonts_opendyslexicmono_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexicMono-Regular.ttf"; fontName = "OpenDyslexicMono"; }}
@:keep class __ASSET__assets_fonts_opendyslexicalta_bolditalic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexicAlta-BoldItalic.ttf"; fontName = "OpenDyslexicAlta Bold Italic"; }}
@:keep class __ASSET__assets_fonts_opendyslexicalta_italic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexicAlta-Italic.ttf"; fontName = "OpenDyslexicAlta Italic"; }}
@:keep class __ASSET__assets_fonts_opendyslexic_bold_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexic-Bold.ttf"; fontName = "OpenDyslexic Bold"; }}
@:keep class __ASSET__fonts_opendyslexic_bolditalic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexic-BoldItalic.ttf"; fontName = "OpenDyslexic Bold Italic"; }}
@:keep class __ASSET__fonts_opendyslexicalta_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexicAlta-Regular.ttf"; fontName = "OpenDyslexicAlta"; }}
@:keep class __ASSET__fonts_opendyslexicalta_bold_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexicAlta-Bold.ttf"; fontName = "OpenDyslexicAlta Bold"; }}
@:keep class __ASSET__fonts_opendyslexic_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexic-Regular.ttf"; fontName = "OpenDyslexic"; }}
@:keep class __ASSET__fonts_opendyslexic_italic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexic-Italic.ttf"; fontName = "OpenDyslexic Italic"; }}
@:keep class __ASSET__fonts_opendyslexicmono_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexicMono-Regular.ttf"; fontName = "OpenDyslexicMono"; }}
@:keep class __ASSET__fonts_opendyslexicalta_bolditalic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexicAlta-BoldItalic.ttf"; fontName = "OpenDyslexicAlta Bold Italic"; }}
@:keep class __ASSET__fonts_opendyslexicalta_italic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexicAlta-Italic.ttf"; fontName = "OpenDyslexicAlta Italic"; }}
@:keep class __ASSET__fonts_opendyslexic_bold_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexic-Bold.ttf"; fontName = "OpenDyslexic Bold"; }}


#else


class __ASSET__assets_fonts_opendyslexic_bolditalic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexic-BoldItalic.ttf"; fontName = "OpenDyslexic Bold Italic";  }}
class __ASSET__assets_fonts_opendyslexicalta_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexicAlta-Regular.ttf"; fontName = "OpenDyslexicAlta";  }}
class __ASSET__assets_fonts_opendyslexicalta_bold_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexicAlta-Bold.ttf"; fontName = "OpenDyslexicAlta Bold";  }}
class __ASSET__assets_fonts_opendyslexic_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexic-Regular.ttf"; fontName = "OpenDyslexic";  }}
class __ASSET__assets_fonts_opendyslexic_italic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexic-Italic.ttf"; fontName = "OpenDyslexic Italic";  }}
class __ASSET__assets_fonts_opendyslexicmono_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexicMono-Regular.ttf"; fontName = "OpenDyslexicMono";  }}
class __ASSET__assets_fonts_opendyslexicalta_bolditalic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexicAlta-BoldItalic.ttf"; fontName = "OpenDyslexicAlta Bold Italic";  }}
class __ASSET__assets_fonts_opendyslexicalta_italic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexicAlta-Italic.ttf"; fontName = "OpenDyslexicAlta Italic";  }}
class __ASSET__assets_fonts_opendyslexic_bold_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/OpenDyslexic-Bold.ttf"; fontName = "OpenDyslexic Bold";  }}
class __ASSET__fonts_opendyslexic_bolditalic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexic-BoldItalic.ttf"; fontName = "OpenDyslexic Bold Italic";  }}
class __ASSET__fonts_opendyslexicalta_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexicAlta-Regular.ttf"; fontName = "OpenDyslexicAlta";  }}
class __ASSET__fonts_opendyslexicalta_bold_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexicAlta-Bold.ttf"; fontName = "OpenDyslexicAlta Bold";  }}
class __ASSET__fonts_opendyslexic_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexic-Regular.ttf"; fontName = "OpenDyslexic";  }}
class __ASSET__fonts_opendyslexic_italic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexic-Italic.ttf"; fontName = "OpenDyslexic Italic";  }}
class __ASSET__fonts_opendyslexicmono_regular_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexicMono-Regular.ttf"; fontName = "OpenDyslexicMono";  }}
class __ASSET__fonts_opendyslexicalta_bolditalic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexicAlta-BoldItalic.ttf"; fontName = "OpenDyslexicAlta Bold Italic";  }}
class __ASSET__fonts_opendyslexicalta_italic_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexicAlta-Italic.ttf"; fontName = "OpenDyslexicAlta Italic";  }}
class __ASSET__fonts_opendyslexic_bold_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/OpenDyslexic-Bold.ttf"; fontName = "OpenDyslexic Bold";  }}


#end

#end
