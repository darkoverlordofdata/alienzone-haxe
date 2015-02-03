package alienzone.engine;

import flixel.FlxObject;
import hxE.EntityWorld;

class BaseEntity {

    public var graphic:FlxObject;

    private var world:EntityWorld;

    public function new(world:EntityWorld) {
        this.world = world;
    }
}
