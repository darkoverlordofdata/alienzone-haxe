package alienzone.systems;
import alienzone.components.TransformComponent;
import alienzone.components.DisplayComponent;
import hxE.systems.EntityProcessingSystem;
import hxE.ComponentTypeSlot;
import hxE.Demand;
import hxE.Entity;


class DisplaySystem extends EntityProcessingSystem {

    private var transformSlot:ComponentTypeSlot<TransformComponent>;
    private var displaySlot:ComponentTypeSlot<DisplayComponent>;

    public function new() {
        super(new Demand().has(TransformComponent).has(DisplayComponent));

        transformSlot = new ComponentTypeSlot<TransformComponent>(TransformComponent);
        displaySlot = new ComponentTypeSlot<DisplayComponent>(DisplayComponent);

        registerSlot(transformSlot);
        registerSlot(displaySlot);

    }


    override private function processEntity(e:Entity):Void {
        var transform = transformSlot.get(e);
        var display = displaySlot.get(e);

        display.graphic.x = transform.x;
        display.graphic.y = transform.y;


    }
}
