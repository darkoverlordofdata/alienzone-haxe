package alienzone.graphics;
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
        
        var fontName:String = "fonts/opendyslexic";
        var fontNormal:PxBitmapFont;
        var fntNormal = Xml.parse(Assets.getText('${fontName}.fnt'));
        fontNormal = new PxBitmapFont().loadAngelCode(Assets.getBitmapData('${fontName}_0.png'), fntNormal);
        var fontScale:Float = 1.0;
        var width = 150;
        var offset = 10;

        var btn:FlxButton = new FlxButton(0, 0, "", callback);
        var txt:FlxBitmapTextField = new FlxBitmapTextField(fontNormal);

        /**
         *  Set the button style
         */
        switch (style) {
            case ButtonThin:
                btn.loadGraphic("images/button.png");
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
                btn.loadGraphic("images/button2.png");
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
                btn.loadGraphic("images/button4.png");
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
                btn.loadGraphic("images/button5.png");
                txt.fontScale = 1.2;
                txt.width = 150;
                txt.y = 10;
                txt.x = 0;
                txt.fixedWidth = true;
                txt.color = FlxColor.BLACK;
                txt.useTextColor = false;
                txt.text = text;
                txt.alignment = PxTextAlign.CENTER;

            default:
                btn.loadGraphic("images/button5.png");
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
}
