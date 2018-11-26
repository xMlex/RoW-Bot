package model.logic.chats.notification.events.allianceCity {
import flash.events.Event;

public class CityTeleportedEvent extends Event {

    public static const CITY_TELEPORTED:String = "CityTeleportedEvent";


    public function CityTeleportedEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
