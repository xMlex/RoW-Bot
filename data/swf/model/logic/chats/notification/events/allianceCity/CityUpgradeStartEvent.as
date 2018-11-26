package model.logic.chats.notification.events.allianceCity {
import flash.events.Event;

public class CityUpgradeStartEvent extends Event {

    public static const CITY_UPGRADE_START:String = "CityUpgradeStartEvent";


    public function CityUpgradeStartEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
