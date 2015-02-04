package alienzone.renderables;
import flixel.text.pxText.PxTextAlign;
import flixel.util.FlxColor;
import openfl.Assets;
import flixel.text.pxText.PxBitmapFont;
import flixel.text.FlxBitmapTextField;

class Title extends FlxBitmapTextField {
    public function new(x:Int, y:Int, text:String) {

        var fontTitle:PxBitmapFont;
        var fntTitle = Xml.parse(Assets.getText("fonts/outlined.fnt"));
        fontTitle = new PxBitmapFont().loadAngelCode(Assets.getBitmapData("fonts/outlined_0.png"), fntTitle);
        super(fontTitle);

        fixedWidth = true;
        color = FlxColor.YELLOW;
        useTextColor = false;
        outlineColor = FlxColor.RED;
        width = 320;
        alignment = PxTextAlign.CENTER;
        fontScale = 2.2;
        this.text = text;
        this.x = x;
        this.y = y;
        

    }
}
