package model.logic.chats.notification.events {
import flash.events.Event;

public class RefreshLocationEvent extends Event {

    public static const REFRESH_LOCATION_EVENT:String = "RefreshLocationEvent";


    private var _data:Object;

    public function RefreshLocationEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }

    public function get eData():Object {
        return this._data;
    }

    public function set eData(param1:Object):void {
        this._data = param1;
    }
}
}
