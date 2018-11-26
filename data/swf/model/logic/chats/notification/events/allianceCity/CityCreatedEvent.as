package model.logic.chats.notification.events.allianceCity {
import flash.events.Event;

public class CityCreatedEvent extends Event {

    public static const CITY_CREATED:String = "CityCreatedEvent";


    public function CityCreatedEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
