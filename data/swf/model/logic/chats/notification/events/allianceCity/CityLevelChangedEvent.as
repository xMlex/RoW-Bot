package model.logic.chats.notification.events.allianceCity {
import flash.events.Event;

public class CityLevelChangedEvent extends Event {

    public static const CITY_LEVEL_CHANGED:String = "CityLevelChangedEvent";


    public function CityLevelChangedEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
