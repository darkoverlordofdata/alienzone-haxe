package alienzone.components;

import flixel.FlxSprite;


class Display {

    public var graphic(default, null):FlxSprite;

    public inline function new(graphic:FlxSprite) {
        this.graphic = graphic;
    }
}
