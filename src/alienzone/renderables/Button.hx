package alienzone.renderables;
import openfl.Assets;
import flixel.text.pxText.PxBitmapFont;
import flixel.text.pxText.PxTextAlign;
import flixel.text.pxText.PxTextAlign;
import flixel.util.FlxColor;
import flixel.text.FlxBitmapTextField;
import flixel.ui.FlxButton;
import flixel.group.FlxTypedSpriteGroup;
import flixel.FlxSprite;

class Button extends FlxTypedSpriteGroup<FlxSprite> {
    public function new(x:Int, y:Int, text:String, callback) {
        super();
        
        var fontNormal:PxBitmapFont;
        var fntNormal = Xml.parse(Assets.getText("fonts/opendyslexic.fnt"));
        fontNormal = new PxBitmapFont().loadAngelCode(Assets.getBitmapData("fonts/opendyslexic_0.png"), fntNormal);

        var btn:FlxButton = new FlxButton(0, 0, "", callback);
        btn.loadGraphic("images/button5.png");
        add(btn);

        var txt:FlxBitmapTextField = new FlxBitmapTextField(fontNormal);
        txt.x = 0;
        txt.y = 10;
        txt.fixedWidth = true;
        txt.color = FlxColor.BLACK;
        txt.useTextColor = false;
        txt.text = text;
        txt.width = 150;
        txt.alignment = PxTextAlign.CENTER;
        txt.fontScale = 1.2;
        add(txt);

    }
}
