package alienzone.components;

import flixel.FlxObject;


class Display {

    public var graphic(default, null):FlxObject;

    public inline function new(graphic:FlxObject) {
        this.graphic = graphic;
    }
}
