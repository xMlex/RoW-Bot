package model.logic.autoRefresh {
import flash.events.Event;

public class AutoRefreshEvent extends Event {


    public var dto:Object;

    public function AutoRefreshEvent(param1:Object, param2:String, param3:Boolean = false, param4:Boolean = false) {
        this.dto = param1;
        super(param2, param3, param4);
    }
}
}
