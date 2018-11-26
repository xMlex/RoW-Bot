package model.logic.inventory.listener {
import flash.events.Event;

public class InventoryListenerEvent extends Event {


    public var activeItems:Array;

    public var actionType:int;

    public function InventoryListenerEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Array = null, param5:int = 0) {
        super(param1, param2, param3);
        this.activeItems = param4;
        this.actionType = param5;
    }

    override public function clone():Event {
        return new InventoryListenerEvent(type, bubbles, cancelable, this.activeItems, this.actionType);
    }
}
}
