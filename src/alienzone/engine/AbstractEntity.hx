package alienzone.engine;

import hxE.EntityWorld;

abstract AbstractEntity {

    private var world:EntityWorld;

    public function new(world:EntityWorld) {
        this.world = world;
    }
}
