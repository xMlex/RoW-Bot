package model.logic.inventory.event {
import flash.events.Event;

import model.data.scenes.objects.GeoSceneObject;

public class InventoryEvent extends Event {

    public static const DRAG_START:String = "DragStart InventoryEvent";

    public static const DRAG_COMPLETE:String = "DragComplete InventoryEvent";


    public var item:GeoSceneObject;

    public function InventoryEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:GeoSceneObject = null) {
        super(param1, param2, param3);
        this.item = param4;
    }

    override public function clone():Event {
        return new InventoryEvent(type, bubbles, cancelable, this.item);
    }
}
}
