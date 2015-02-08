package alienzone.graphics;
import flixel.util.FlxSpriteUtil;
import openfl.Assets;
import flixel.text.pxText.PxBitmapFont;
import flixel.text.pxText.PxTextAlign;
import flixel.text.pxText.PxTextAlign;
import flixel.util.FlxColor;
import flixel.text.FlxBitmapTextField;
import flixel.ui.FlxButton;
import flixel.group.FlxTypedSpriteGroup;
import flixel.FlxSprite;

/**
 * Button Styles
 */
enum ButtonStyle {
    ButtonImage;
    ButtonThin;
    ButtonSmall;
    ButtonWide;
    ButtonBig;
}


/**
 * Create a styled button with text and callback
 *
 * this is mainly used for top level navigation
 */
class Button extends FlxTypedSpriteGroup<FlxSprite> {
    public function new(text:String, style:ButtonStyle, callback) {
        super();
        
        if (style == ButtonImage) {
            var btn:FlxButton = new FlxButton(0, 0, "", callback);
            btn.loadGraphic(text);
            btn.antialiasing = true;
            add(btn);
        } else {
            var fontName:String = "fonts/opendyslexic";
            var fontNormal:PxBitmapFont;
            var fntNormal = Xml.parse(Assets.getText('${fontName}.fnt'));
            fontNormal = new PxBitmapFont().loadAngelCode(Assets.getBitmapData('${fontName}_0.png'), fntNormal);
            var fontScale:Float = 1.0;
            var width = 150;
            var offset = 10;
    
            var btn:FlxButton = new FlxButton(0, 0, "", callback);
            var txt:FlxBitmapTextField = new FlxBitmapTextField(fontNormal);
            txt.antialiasing = true;
            btn.antialiasing = true;
    
            /**
             *  Set the button style
             */
            switch (style) {
                case ButtonThin:
                    btn.makeGraphic(100, 24, FlxColor.TRANSPARENT, true);
                    FlxSpriteUtil.drawRoundRect(btn, 0, 0, 100, 24, 10, 10, 0xffd17af6);
                    txt.fontScale = 0.8;
                    txt.width = 100;
                    txt.y = 0;
                    txt.x = 0;
                    txt.fixedWidth = true;
                    txt.color = FlxColor.BLACK;
                    txt.useTextColor = false;
                    txt.text = text;
                    txt.alignment = PxTextAlign.CENTER;
                
                case ButtonSmall:
                    btn.makeGraphic(50, 24, FlxColor.TRANSPARENT, true);
                    FlxSpriteUtil.drawRoundRect(btn, 0, 0, 50, 24, 10, 10, 0xffd17af6);
                    txt.fontScale = 0.8;
                    txt.width = 50;
                    txt.y = 0;
                    txt.x = 0;
                    txt.fixedWidth = true;
                    txt.color = FlxColor.BLACK;
                    txt.useTextColor = false;
                    txt.text = text;
                    txt.alignment = PxTextAlign.CENTER;
                
                case ButtonWide:
                    btn.makeGraphic(100, 50, FlxColor.TRANSPARENT, true);
                    FlxSpriteUtil.drawRoundRect(btn, 0, 0, 100, 50, 30, 30, 0xffd17af6);
                    txt.fontScale = 0.6;
                    txt.width = 100;
                    txt.y = 10;
                    txt.x = 0;
                    txt.fixedWidth = true;
                    txt.color = FlxColor.BLACK;
                    txt.useTextColor = false;
                    txt.text = text;
                    txt.alignment = PxTextAlign.CENTER;
    
                case ButtonBig:
                    btn.makeGraphic(150, 60, FlxColor.TRANSPARENT, true);
                    FlxSpriteUtil.drawRoundRect(btn, 0, 0, 150, 60, 30, 30, 0xffd17af6);
                    txt.fontScale = 1.5;
                    txt.width = 150;
                    txt.y = 7;
                    txt.x = 0;
                    txt.fixedWidth = true;
                    txt.color = FlxColor.BLACK;
                    txt.useTextColor = false;
                    txt.text = text;
                    txt.alignment = PxTextAlign.CENTER;
    
                default:
                    btn.makeGraphic(150, 60, FlxColor.TRANSPARENT, true);
                    FlxSpriteUtil.drawRoundRect(btn, 0, 0, 150, 60, 30, 30, 0xffd17af6);
                    txt.fontScale = 1.2;
                    txt.width = 150;
                    txt.y = 10;
                    txt.x = 0;
                    txt.fixedWidth = true;
                    txt.color = FlxColor.BLACK;
                    txt.useTextColor = false;
                    txt.text = text;
                    txt.alignment = PxTextAlign.CENTER;
            }
            add(btn);
            add(txt);
        }
        antialiasing = true;

    }
}
