package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Font;
import lime.graphics.Image;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if (sys || nodejs)
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		className.set ("assets/images/button4.png", __ASSET__assets_images_button4_png);
		type.set ("assets/images/button4.png", AssetType.IMAGE);
		className.set ("assets/images/slots.png", __ASSET__assets_images_slots_png);
		type.set ("assets/images/slots.png", AssetType.IMAGE);
		className.set ("assets/images/d16a.png", __ASSET__assets_images_d16a_png);
		type.set ("assets/images/d16a.png", AssetType.IMAGE);
		className.set ("assets/images/legend.png", __ASSET__assets_images_legend_png);
		type.set ("assets/images/legend.png", AssetType.IMAGE);
		className.set ("assets/images/bucky.png", __ASSET__assets_images_bucky_png);
		type.set ("assets/images/bucky.png", AssetType.IMAGE);
		className.set ("assets/images/star17 (copy).png", __ASSET__assets_images_star17__copy__png);
		type.set ("assets/images/star17 (copy).png", AssetType.IMAGE);
		className.set ("assets/images/button5.png", __ASSET__assets_images_button5_png);
		type.set ("assets/images/button5.png", AssetType.IMAGE);
		className.set ("assets/images/button2.png", __ASSET__assets_images_button2_png);
		type.set ("assets/images/button2.png", AssetType.IMAGE);
		className.set ("assets/images/legend_board.png", __ASSET__assets_images_legend_board_png);
		type.set ("assets/images/legend_board.png", AssetType.IMAGE);
		className.set ("assets/images/09-white.png", __ASSET__assets_images_09_white_png);
		type.set ("assets/images/09-white.png", AssetType.IMAGE);
		className.set ("assets/images/orientation.jpg", __ASSET__assets_images_orientation_jpg);
		type.set ("assets/images/orientation.jpg", AssetType.IMAGE);
		className.set ("assets/images/loading.png", __ASSET__assets_images_loading_png);
		type.set ("assets/images/loading.png", AssetType.IMAGE);
		className.set ("assets/images/gems.png", __ASSET__assets_images_gems_png);
		type.set ("assets/images/gems.png", AssetType.IMAGE);
		className.set ("assets/images/achievement.png", __ASSET__assets_images_achievement_png);
		type.set ("assets/images/achievement.png", AssetType.IMAGE);
		className.set ("assets/images/en_generic_rgb_wo_45.png", __ASSET__assets_images_en_generic_rgb_wo_45_png);
		type.set ("assets/images/en_generic_rgb_wo_45.png", AssetType.IMAGE);
		className.set ("assets/images/button.png", __ASSET__assets_images_button_png);
		type.set ("assets/images/button.png", AssetType.IMAGE);
		className.set ("assets/images/arrows/left.png", __ASSET__assets_images_arrows_left_png);
		type.set ("assets/images/arrows/left.png", AssetType.IMAGE);
		className.set ("assets/images/arrows/right.png", __ASSET__assets_images_arrows_right_png);
		type.set ("assets/images/arrows/right.png", AssetType.IMAGE);
		className.set ("assets/images/arrows/down.png", __ASSET__assets_images_arrows_down_png);
		type.set ("assets/images/arrows/down.png", AssetType.IMAGE);
		className.set ("assets/images/arrows/lrot.png", __ASSET__assets_images_arrows_lrot_png);
		type.set ("assets/images/arrows/lrot.png", AssetType.IMAGE);
		className.set ("assets/images/arrows/rrot.png", __ASSET__assets_images_arrows_rrot_png);
		type.set ("assets/images/arrows/rrot.png", AssetType.IMAGE);
		className.set ("assets/images/games_achievements.png", __ASSET__assets_images_games_achievements_png);
		type.set ("assets/images/games_achievements.png", AssetType.IMAGE);
		className.set ("assets/images/music_option.png", __ASSET__assets_images_music_option_png);
		type.set ("assets/images/music_option.png", AssetType.IMAGE);
		className.set ("assets/images/scores.png", __ASSET__assets_images_scores_png);
		type.set ("assets/images/scores.png", AssetType.IMAGE);
		className.set ("assets/images/sfx_option.png", __ASSET__assets_images_sfx_option_png);
		type.set ("assets/images/sfx_option.png", AssetType.IMAGE);
		className.set ("assets/images/games_controller.png", __ASSET__assets_images_games_controller_png);
		type.set ("assets/images/games_controller.png", AssetType.IMAGE);
		className.set ("assets/images/logo.png", __ASSET__assets_images_logo_png);
		type.set ("assets/images/logo.png", AssetType.IMAGE);
		className.set ("assets/images/09-red.png", __ASSET__assets_images_09_red_png);
		type.set ("assets/images/09-red.png", AssetType.IMAGE);
		className.set ("assets/images/star17.png", __ASSET__assets_images_star17_png);
		type.set ("assets/images/star17.png", AssetType.IMAGE);
		className.set ("assets/images/games_leaderboards.png", __ASSET__assets_images_games_leaderboards_png);
		type.set ("assets/images/games_leaderboards.png", AssetType.IMAGE);
		className.set ("assets/images/icon.png", __ASSET__assets_images_icon_png);
		type.set ("assets/images/icon.png", AssetType.IMAGE);
		className.set ("assets/images/label.png", __ASSET__assets_images_label_png);
		type.set ("assets/images/label.png", AssetType.IMAGE);
		className.set ("assets/fonts/OpenDyslexic-BoldItalic.ttf", __ASSET__assets_fonts_opendyslexic_bolditalic_ttf);
		type.set ("assets/fonts/OpenDyslexic-BoldItalic.ttf", AssetType.FONT);
		className.set ("assets/fonts/OpenDyslexicAlta-Regular.ttf", __ASSET__assets_fonts_opendyslexicalta_regular_ttf);
		type.set ("assets/fonts/OpenDyslexicAlta-Regular.ttf", AssetType.FONT);
		className.set ("assets/fonts/OpenDyslexicAlta-Bold.ttf", __ASSET__assets_fonts_opendyslexicalta_bold_ttf);
		type.set ("assets/fonts/OpenDyslexicAlta-Bold.ttf", AssetType.FONT);
		className.set ("assets/fonts/OpenDyslexic-Regular.ttf", __ASSET__assets_fonts_opendyslexic_regular_ttf);
		type.set ("assets/fonts/OpenDyslexic-Regular.ttf", AssetType.FONT);
		className.set ("assets/fonts/OpenDyslexic-Italic.ttf", __ASSET__assets_fonts_opendyslexic_italic_ttf);
		type.set ("assets/fonts/OpenDyslexic-Italic.ttf", AssetType.FONT);
		className.set ("assets/fonts/OpenDyslexicMono-Regular.ttf", __ASSET__assets_fonts_opendyslexicmono_regular_ttf);
		type.set ("assets/fonts/OpenDyslexicMono-Regular.ttf", AssetType.FONT);
		className.set ("assets/fonts/OpenDyslexicAlta-BoldItalic.ttf", __ASSET__assets_fonts_opendyslexicalta_bolditalic_ttf);
		type.set ("assets/fonts/OpenDyslexicAlta-BoldItalic.ttf", AssetType.FONT);
		className.set ("assets/fonts/OpenDyslexicAlta-Italic.ttf", __ASSET__assets_fonts_opendyslexicalta_italic_ttf);
		type.set ("assets/fonts/OpenDyslexicAlta-Italic.ttf", AssetType.FONT);
		className.set ("assets/fonts/OpenDyslexic-Bold.ttf", __ASSET__assets_fonts_opendyslexic_bold_ttf);
		type.set ("assets/fonts/OpenDyslexic-Bold.ttf", AssetType.FONT);
		className.set ("fonts/OpenDyslexic-BoldItalic.ttf", __ASSET__fonts_opendyslexic_bolditalic_ttf);
		type.set ("fonts/OpenDyslexic-BoldItalic.ttf", AssetType.FONT);
		className.set ("fonts/OpenDyslexicAlta-Regular.ttf", __ASSET__fonts_opendyslexicalta_regular_ttf);
		type.set ("fonts/OpenDyslexicAlta-Regular.ttf", AssetType.FONT);
		className.set ("fonts/OpenDyslexicAlta-Bold.ttf", __ASSET__fonts_opendyslexicalta_bold_ttf);
		type.set ("fonts/OpenDyslexicAlta-Bold.ttf", AssetType.FONT);
		className.set ("fonts/OpenDyslexic-Regular.ttf", __ASSET__fonts_opendyslexic_regular_ttf);
		type.set ("fonts/OpenDyslexic-Regular.ttf", AssetType.FONT);
		className.set ("fonts/OpenDyslexic-Italic.ttf", __ASSET__fonts_opendyslexic_italic_ttf);
		type.set ("fonts/OpenDyslexic-Italic.ttf", AssetType.FONT);
		className.set ("fonts/OpenDyslexicMono-Regular.ttf", __ASSET__fonts_opendyslexicmono_regular_ttf);
		type.set ("fonts/OpenDyslexicMono-Regular.ttf", AssetType.FONT);
		className.set ("fonts/OpenDyslexicAlta-BoldItalic.ttf", __ASSET__fonts_opendyslexicalta_bolditalic_ttf);
		type.set ("fonts/OpenDyslexicAlta-BoldItalic.ttf", AssetType.FONT);
		className.set ("fonts/OpenDyslexicAlta-Italic.ttf", __ASSET__fonts_opendyslexicalta_italic_ttf);
		type.set ("fonts/OpenDyslexicAlta-Italic.ttf", AssetType.FONT);
		className.set ("fonts/OpenDyslexic-Bold.ttf", __ASSET__fonts_opendyslexic_bold_ttf);
		type.set ("fonts/OpenDyslexic-Bold.ttf", AssetType.FONT);
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		
		#elseif html5
		
		var id;
		id = "assets/music/music-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/sounds-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
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
		id = "assets/fonts/OpenDyslexic-BoldItalic.ttf";
		className.set (id, __ASSET__assets_fonts_opendyslexic_bolditalic_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexicAlta-Regular.ttf";
		className.set (id, __ASSET__assets_fonts_opendyslexicalta_regular_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexicAlta-Bold.ttf";
		className.set (id, __ASSET__assets_fonts_opendyslexicalta_bold_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexic-Regular.ttf";
		className.set (id, __ASSET__assets_fonts_opendyslexic_regular_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexic-Italic.ttf";
		className.set (id, __ASSET__assets_fonts_opendyslexic_italic_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexicMono-Regular.ttf";
		className.set (id, __ASSET__assets_fonts_opendyslexicmono_regular_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexicAlta-BoldItalic.ttf";
		className.set (id, __ASSET__assets_fonts_opendyslexicalta_bolditalic_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexicAlta-Italic.ttf";
		className.set (id, __ASSET__assets_fonts_opendyslexicalta_italic_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/OpenDyslexic-Bold.ttf";
		className.set (id, __ASSET__assets_fonts_opendyslexic_bold_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexic-BoldItalic.ttf";
		className.set (id, __ASSET__fonts_opendyslexic_bolditalic_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexicAlta-Regular.ttf";
		className.set (id, __ASSET__fonts_opendyslexicalta_regular_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexicAlta-Bold.ttf";
		className.set (id, __ASSET__fonts_opendyslexicalta_bold_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexic-Regular.ttf";
		className.set (id, __ASSET__fonts_opendyslexic_regular_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexic-Italic.ttf";
		className.set (id, __ASSET__fonts_opendyslexic_italic_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexicMono-Regular.ttf";
		className.set (id, __ASSET__fonts_opendyslexicmono_regular_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexicAlta-BoldItalic.ttf";
		className.set (id, __ASSET__fonts_opendyslexicalta_bolditalic_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexicAlta-Italic.ttf";
		className.set (id, __ASSET__fonts_opendyslexicalta_italic_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/OpenDyslexic-Bold.ttf";
		className.set (id, __ASSET__fonts_opendyslexic_bold_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		
		
		#else
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__assets_fonts_opendyslexic_bolditalic_ttf);
		openfl.text.Font.registerFont (__ASSET__assets_fonts_opendyslexicalta_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__assets_fonts_opendyslexicalta_bold_ttf);
		openfl.text.Font.registerFont (__ASSET__assets_fonts_opendyslexic_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__assets_fonts_opendyslexic_italic_ttf);
		openfl.text.Font.registerFont (__ASSET__assets_fonts_opendyslexicmono_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__assets_fonts_opendyslexicalta_bolditalic_ttf);
		openfl.text.Font.registerFont (__ASSET__assets_fonts_opendyslexicalta_italic_ttf);
		openfl.text.Font.registerFont (__ASSET__assets_fonts_opendyslexic_bold_ttf);
		openfl.text.Font.registerFont (__ASSET__fonts_opendyslexic_bolditalic_ttf);
		openfl.text.Font.registerFont (__ASSET__fonts_opendyslexicalta_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__fonts_opendyslexicalta_bold_ttf);
		openfl.text.Font.registerFont (__ASSET__fonts_opendyslexic_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__fonts_opendyslexic_italic_ttf);
		openfl.text.Font.registerFont (__ASSET__fonts_opendyslexicmono_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__fonts_opendyslexicalta_bolditalic_ttf);
		openfl.text.Font.registerFont (__ASSET__fonts_opendyslexicalta_italic_ttf);
		openfl.text.Font.registerFont (__ASSET__fonts_opendyslexic_bold_ttf);
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/images/button4.png", __ASSET__assets_images_button4_png);
		type.set ("assets/images/button4.png", AssetType.IMAGE);
		
		className.set ("assets/images/slots.png", __ASSET__assets_images_slots_png);
		type.set ("assets/images/slots.png", AssetType.IMAGE);
		
		className.set ("assets/images/d16a.png", __ASSET__assets_images_d16a_png);
		type.set ("assets/images/d16a.png", AssetType.IMAGE);
		
		className.set ("assets/images/legend.png", __ASSET__assets_images_legend_png);
		type.set ("assets/images/legend.png", AssetType.IMAGE);
		
		className.set ("assets/images/bucky.png", __ASSET__assets_images_bucky_png);
		type.set ("assets/images/bucky.png", AssetType.IMAGE);
		
		className.set ("assets/images/star17 (copy).png", __ASSET__assets_images_star17__copy__png);
		type.set ("assets/images/star17 (copy).png", AssetType.IMAGE);
		
		className.set ("assets/images/button5.png", __ASSET__assets_images_button5_png);
		type.set ("assets/images/button5.png", AssetType.IMAGE);
		
		className.set ("assets/images/button2.png", __ASSET__assets_images_button2_png);
		type.set ("assets/images/button2.png", AssetType.IMAGE);
		
		className.set ("assets/images/legend_board.png", __ASSET__assets_images_legend_board_png);
		type.set ("assets/images/legend_board.png", AssetType.IMAGE);
		
		className.set ("assets/images/09-white.png", __ASSET__assets_images_09_white_png);
		type.set ("assets/images/09-white.png", AssetType.IMAGE);
		
		className.set ("assets/images/orientation.jpg", __ASSET__assets_images_orientation_jpg);
		type.set ("assets/images/orientation.jpg", AssetType.IMAGE);
		
		className.set ("assets/images/loading.png", __ASSET__assets_images_loading_png);
		type.set ("assets/images/loading.png", AssetType.IMAGE);
		
		className.set ("assets/images/gems.png", __ASSET__assets_images_gems_png);
		type.set ("assets/images/gems.png", AssetType.IMAGE);
		
		className.set ("assets/images/achievement.png", __ASSET__assets_images_achievement_png);
		type.set ("assets/images/achievement.png", AssetType.IMAGE);
		
		className.set ("assets/images/en_generic_rgb_wo_45.png", __ASSET__assets_images_en_generic_rgb_wo_45_png);
		type.set ("assets/images/en_generic_rgb_wo_45.png", AssetType.IMAGE);
		
		className.set ("assets/images/button.png", __ASSET__assets_images_button_png);
		type.set ("assets/images/button.png", AssetType.IMAGE);
		
		className.set ("assets/images/arrows/left.png", __ASSET__assets_images_arrows_left_png);
		type.set ("assets/images/arrows/left.png", AssetType.IMAGE);
		
		className.set ("assets/images/arrows/right.png", __ASSET__assets_images_arrows_right_png);
		type.set ("assets/images/arrows/right.png", AssetType.IMAGE);
		
		className.set ("assets/images/arrows/down.png", __ASSET__assets_images_arrows_down_png);
		type.set ("assets/images/arrows/down.png", AssetType.IMAGE);
		
		className.set ("assets/images/arrows/lrot.png", __ASSET__assets_images_arrows_lrot_png);
		type.set ("assets/images/arrows/lrot.png", AssetType.IMAGE);
		
		className.set ("assets/images/arrows/rrot.png", __ASSET__assets_images_arrows_rrot_png);
		type.set ("assets/images/arrows/rrot.png", AssetType.IMAGE);
		
		className.set ("assets/images/games_achievements.png", __ASSET__assets_images_games_achievements_png);
		type.set ("assets/images/games_achievements.png", AssetType.IMAGE);
		
		className.set ("assets/images/music_option.png", __ASSET__assets_images_music_option_png);
		type.set ("assets/images/music_option.png", AssetType.IMAGE);
		
		className.set ("assets/images/scores.png", __ASSET__assets_images_scores_png);
		type.set ("assets/images/scores.png", AssetType.IMAGE);
		
		className.set ("assets/images/sfx_option.png", __ASSET__assets_images_sfx_option_png);
		type.set ("assets/images/sfx_option.png", AssetType.IMAGE);
		
		className.set ("assets/images/games_controller.png", __ASSET__assets_images_games_controller_png);
		type.set ("assets/images/games_controller.png", AssetType.IMAGE);
		
		className.set ("assets/images/logo.png", __ASSET__assets_images_logo_png);
		type.set ("assets/images/logo.png", AssetType.IMAGE);
		
		className.set ("assets/images/09-red.png", __ASSET__assets_images_09_red_png);
		type.set ("assets/images/09-red.png", AssetType.IMAGE);
		
		className.set ("assets/images/star17.png", __ASSET__assets_images_star17_png);
		type.set ("assets/images/star17.png", AssetType.IMAGE);
		
		className.set ("assets/images/games_leaderboards.png", __ASSET__assets_images_games_leaderboards_png);
		type.set ("assets/images/games_leaderboards.png", AssetType.IMAGE);
		
		className.set ("assets/images/icon.png", __ASSET__assets_images_icon_png);
		type.set ("assets/images/icon.png", AssetType.IMAGE);
		
		className.set ("assets/images/label.png", __ASSET__assets_images_label_png);
		type.set ("assets/images/label.png", AssetType.IMAGE);
		
		className.set ("assets/fonts/OpenDyslexic-BoldItalic.ttf", __ASSET__assets_fonts_opendyslexic_bolditalic_ttf);
		type.set ("assets/fonts/OpenDyslexic-BoldItalic.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/OpenDyslexicAlta-Regular.ttf", __ASSET__assets_fonts_opendyslexicalta_regular_ttf);
		type.set ("assets/fonts/OpenDyslexicAlta-Regular.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/OpenDyslexicAlta-Bold.ttf", __ASSET__assets_fonts_opendyslexicalta_bold_ttf);
		type.set ("assets/fonts/OpenDyslexicAlta-Bold.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/OpenDyslexic-Regular.ttf", __ASSET__assets_fonts_opendyslexic_regular_ttf);
		type.set ("assets/fonts/OpenDyslexic-Regular.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/OpenDyslexic-Italic.ttf", __ASSET__assets_fonts_opendyslexic_italic_ttf);
		type.set ("assets/fonts/OpenDyslexic-Italic.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/OpenDyslexicMono-Regular.ttf", __ASSET__assets_fonts_opendyslexicmono_regular_ttf);
		type.set ("assets/fonts/OpenDyslexicMono-Regular.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/OpenDyslexicAlta-BoldItalic.ttf", __ASSET__assets_fonts_opendyslexicalta_bolditalic_ttf);
		type.set ("assets/fonts/OpenDyslexicAlta-BoldItalic.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/OpenDyslexicAlta-Italic.ttf", __ASSET__assets_fonts_opendyslexicalta_italic_ttf);
		type.set ("assets/fonts/OpenDyslexicAlta-Italic.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/OpenDyslexic-Bold.ttf", __ASSET__assets_fonts_opendyslexic_bold_ttf);
		type.set ("assets/fonts/OpenDyslexic-Bold.ttf", AssetType.FONT);
		
		className.set ("fonts/OpenDyslexic-BoldItalic.ttf", __ASSET__fonts_opendyslexic_bolditalic_ttf);
		type.set ("fonts/OpenDyslexic-BoldItalic.ttf", AssetType.FONT);
		
		className.set ("fonts/OpenDyslexicAlta-Regular.ttf", __ASSET__fonts_opendyslexicalta_regular_ttf);
		type.set ("fonts/OpenDyslexicAlta-Regular.ttf", AssetType.FONT);
		
		className.set ("fonts/OpenDyslexicAlta-Bold.ttf", __ASSET__fonts_opendyslexicalta_bold_ttf);
		type.set ("fonts/OpenDyslexicAlta-Bold.ttf", AssetType.FONT);
		
		className.set ("fonts/OpenDyslexic-Regular.ttf", __ASSET__fonts_opendyslexic_regular_ttf);
		type.set ("fonts/OpenDyslexic-Regular.ttf", AssetType.FONT);
		
		className.set ("fonts/OpenDyslexic-Italic.ttf", __ASSET__fonts_opendyslexic_italic_ttf);
		type.set ("fonts/OpenDyslexic-Italic.ttf", AssetType.FONT);
		
		className.set ("fonts/OpenDyslexicMono-Regular.ttf", __ASSET__fonts_opendyslexicmono_regular_ttf);
		type.set ("fonts/OpenDyslexicMono-Regular.ttf", AssetType.FONT);
		
		className.set ("fonts/OpenDyslexicAlta-BoldItalic.ttf", __ASSET__fonts_opendyslexicalta_bolditalic_ttf);
		type.set ("fonts/OpenDyslexicAlta-BoldItalic.ttf", AssetType.FONT);
		
		className.set ("fonts/OpenDyslexicAlta-Italic.ttf", __ASSET__fonts_opendyslexicalta_italic_ttf);
		type.set ("fonts/OpenDyslexicAlta-Italic.ttf", AssetType.FONT);
		
		className.set ("fonts/OpenDyslexic-Bold.ttf", __ASSET__fonts_opendyslexic_bold_ttf);
		type.set ("fonts/OpenDyslexic-Bold.ttf", AssetType.FONT);
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		
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
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && requestedType == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return AudioBuffer.fromFile (path.get (id));
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
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
	
	
	public override function getFont (id:String):Dynamic /*Font*/ {
		
		// TODO: Complete Lime Font API
		
		#if openfl
		#if (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), openfl.text.Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			openfl.text.Font.registerFont (fontClass);
			return cast (Type.createInstance (fontClass, []), openfl.text.Font);
			
		} else {
			
			return new openfl.text.Font (path.get (id));
			
		}
		
		#end
		#end
		
		return null;
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		return Image.fromFile (path.get (id));
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
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
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getAudioBuffer (id));
			
		//}
		
		#else
		
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
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
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
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
			#elseif (mac && java)
			var bytes = ByteArray.readFile ("../Resources/manifest");
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
								type.set (asset.id, cast (asset.type, AssetType));
								
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
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_button4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_slots_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_d16a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_legend_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bucky_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_star17__copy__png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_button5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_button2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_legend_board_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_09_white_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_orientation_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_loading_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_gems_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_achievement_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_en_generic_rgb_wo_45_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_arrows_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_arrows_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_arrows_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_arrows_lrot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_arrows_rrot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_games_achievements_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_music_option_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_scores_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sfx_option_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_games_controller_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_09_red_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_star17_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_games_leaderboards_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_icon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_label_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_opendyslexic_bolditalic_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_opendyslexicalta_regular_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_opendyslexicalta_bold_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_opendyslexic_regular_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_opendyslexic_italic_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_opendyslexicmono_regular_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_opendyslexicalta_bolditalic_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_opendyslexicalta_italic_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_opendyslexic_bold_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_opendyslexic_bolditalic_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_opendyslexicalta_regular_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_opendyslexicalta_bold_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_opendyslexic_regular_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_opendyslexic_italic_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_opendyslexicmono_regular_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_opendyslexicalta_bolditalic_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_opendyslexicalta_italic_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_opendyslexic_bold_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound { }


#elseif html5

#if openfl



































@:keep #if display private #end class __ASSET__assets_fonts_opendyslexic_bolditalic_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexic Bold Italic"; } } 
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexicalta_regular_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexicAlta"; } } 
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexicalta_bold_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexicAlta Bold"; } } 
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexic_regular_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexic"; } } 
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexic_italic_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexic Italic"; } } 
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexicmono_regular_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexicMono"; } } 
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexicalta_bolditalic_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexicAlta Bold Italic"; } } 
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexicalta_italic_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexicAlta Italic"; } } 
@:keep #if display private #end class __ASSET__assets_fonts_opendyslexic_bold_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexic Bold"; } } 
@:keep #if display private #end class __ASSET__fonts_opendyslexic_bolditalic_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexic Bold Italic"; } } 
@:keep #if display private #end class __ASSET__fonts_opendyslexicalta_regular_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexicAlta"; } } 
@:keep #if display private #end class __ASSET__fonts_opendyslexicalta_bold_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexicAlta Bold"; } } 
@:keep #if display private #end class __ASSET__fonts_opendyslexic_regular_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexic"; } } 
@:keep #if display private #end class __ASSET__fonts_opendyslexic_italic_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexic Italic"; } } 
@:keep #if display private #end class __ASSET__fonts_opendyslexicmono_regular_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexicMono"; } } 
@:keep #if display private #end class __ASSET__fonts_opendyslexicalta_bolditalic_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexicAlta Bold Italic"; } } 
@:keep #if display private #end class __ASSET__fonts_opendyslexicalta_italic_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexicAlta Italic"; } } 
@:keep #if display private #end class __ASSET__fonts_opendyslexic_bold_ttf extends openfl.text.Font { public function new () { super (); fontName = "OpenDyslexic Bold"; } } 



#end

#else

#if openfl
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

#end

#if (windows || mac || linux)


@:file("assets/music/music-goes-here.txt") class __ASSET__assets_music_music_goes_here_txt extends lime.utils.ByteArray {}
@:file("assets/data/data-goes-here.txt") class __ASSET__assets_data_data_goes_here_txt extends lime.utils.ByteArray {}
@:file("assets/sounds/sounds-go-here.txt") class __ASSET__assets_sounds_sounds_go_here_txt extends lime.utils.ByteArray {}
@:bitmap("assets/images/button4.png") class __ASSET__assets_images_button4_png extends lime.graphics.Image {}
@:bitmap("assets/images/slots.png") class __ASSET__assets_images_slots_png extends lime.graphics.Image {}
@:bitmap("assets/images/d16a.png") class __ASSET__assets_images_d16a_png extends lime.graphics.Image {}
@:bitmap("assets/images/legend.png") class __ASSET__assets_images_legend_png extends lime.graphics.Image {}
@:bitmap("assets/images/bucky.png") class __ASSET__assets_images_bucky_png extends lime.graphics.Image {}
@:bitmap("assets/images/star17 (copy).png") class __ASSET__assets_images_star17__copy__png extends lime.graphics.Image {}
@:bitmap("assets/images/button5.png") class __ASSET__assets_images_button5_png extends lime.graphics.Image {}
@:bitmap("assets/images/button2.png") class __ASSET__assets_images_button2_png extends lime.graphics.Image {}
@:bitmap("assets/images/legend_board.png") class __ASSET__assets_images_legend_board_png extends lime.graphics.Image {}
@:bitmap("assets/images/09-white.png") class __ASSET__assets_images_09_white_png extends lime.graphics.Image {}
@:bitmap("assets/images/orientation.jpg") class __ASSET__assets_images_orientation_jpg extends lime.graphics.Image {}
@:bitmap("assets/images/loading.png") class __ASSET__assets_images_loading_png extends lime.graphics.Image {}
@:bitmap("assets/images/gems.png") class __ASSET__assets_images_gems_png extends lime.graphics.Image {}
@:bitmap("assets/images/achievement.png") class __ASSET__assets_images_achievement_png extends lime.graphics.Image {}
@:bitmap("assets/images/en_generic_rgb_wo_45.png") class __ASSET__assets_images_en_generic_rgb_wo_45_png extends lime.graphics.Image {}
@:bitmap("assets/images/button.png") class __ASSET__assets_images_button_png extends lime.graphics.Image {}
@:bitmap("assets/images/arrows/left.png") class __ASSET__assets_images_arrows_left_png extends lime.graphics.Image {}
@:bitmap("assets/images/arrows/right.png") class __ASSET__assets_images_arrows_right_png extends lime.graphics.Image {}
@:bitmap("assets/images/arrows/down.png") class __ASSET__assets_images_arrows_down_png extends lime.graphics.Image {}
@:bitmap("assets/images/arrows/lrot.png") class __ASSET__assets_images_arrows_lrot_png extends lime.graphics.Image {}
@:bitmap("assets/images/arrows/rrot.png") class __ASSET__assets_images_arrows_rrot_png extends lime.graphics.Image {}
@:bitmap("assets/images/games_achievements.png") class __ASSET__assets_images_games_achievements_png extends lime.graphics.Image {}
@:bitmap("assets/images/music_option.png") class __ASSET__assets_images_music_option_png extends lime.graphics.Image {}
@:bitmap("assets/images/scores.png") class __ASSET__assets_images_scores_png extends lime.graphics.Image {}
@:bitmap("assets/images/sfx_option.png") class __ASSET__assets_images_sfx_option_png extends lime.graphics.Image {}
@:bitmap("assets/images/games_controller.png") class __ASSET__assets_images_games_controller_png extends lime.graphics.Image {}
@:bitmap("assets/images/logo.png") class __ASSET__assets_images_logo_png extends lime.graphics.Image {}
@:bitmap("assets/images/09-red.png") class __ASSET__assets_images_09_red_png extends lime.graphics.Image {}
@:bitmap("assets/images/star17.png") class __ASSET__assets_images_star17_png extends lime.graphics.Image {}
@:bitmap("assets/images/games_leaderboards.png") class __ASSET__assets_images_games_leaderboards_png extends lime.graphics.Image {}
@:bitmap("assets/images/icon.png") class __ASSET__assets_images_icon_png extends lime.graphics.Image {}
@:bitmap("assets/images/label.png") class __ASSET__assets_images_label_png extends lime.graphics.Image {}
@:font("assets/fonts/OpenDyslexic-BoldItalic.ttf") class __ASSET__assets_fonts_opendyslexic_bolditalic_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexicAlta-Regular.ttf") class __ASSET__assets_fonts_opendyslexicalta_regular_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexicAlta-Bold.ttf") class __ASSET__assets_fonts_opendyslexicalta_bold_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexic-Regular.ttf") class __ASSET__assets_fonts_opendyslexic_regular_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexic-Italic.ttf") class __ASSET__assets_fonts_opendyslexic_italic_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexicMono-Regular.ttf") class __ASSET__assets_fonts_opendyslexicmono_regular_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexicAlta-BoldItalic.ttf") class __ASSET__assets_fonts_opendyslexicalta_bolditalic_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexicAlta-Italic.ttf") class __ASSET__assets_fonts_opendyslexicalta_italic_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexic-Bold.ttf") class __ASSET__assets_fonts_opendyslexic_bold_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexic-BoldItalic.ttf") class __ASSET__fonts_opendyslexic_bolditalic_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexicAlta-Regular.ttf") class __ASSET__fonts_opendyslexicalta_regular_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexicAlta-Bold.ttf") class __ASSET__fonts_opendyslexicalta_bold_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexic-Regular.ttf") class __ASSET__fonts_opendyslexic_regular_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexic-Italic.ttf") class __ASSET__fonts_opendyslexic_italic_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexicMono-Regular.ttf") class __ASSET__fonts_opendyslexicmono_regular_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexicAlta-BoldItalic.ttf") class __ASSET__fonts_opendyslexicalta_bolditalic_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexicAlta-Italic.ttf") class __ASSET__fonts_opendyslexicalta_italic_ttf extends lime.graphics.Font {}
@:font("assets/fonts/OpenDyslexic-Bold.ttf") class __ASSET__fonts_opendyslexic_bold_ttf extends lime.graphics.Font {}
@:sound("/usr/lib/haxe/lib/flixel/3,3,6/assets/sounds/flixel.mp3") class __ASSET__assets_sounds_flixel_mp3 extends lime.audio.AudioSource {}
@:sound("/usr/lib/haxe/lib/flixel/3,3,6/assets/sounds/beep.mp3") class __ASSET__assets_sounds_beep_mp3 extends lime.audio.AudioSource {}



#end

#end
#end

