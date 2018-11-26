package model.logic.chats.notification.events.allianceCity {
import flash.events.Event;

public class TechnologyUpgradeStartEvent extends Event {

    public static const TECHNOLOGY_UPGRADE_START:String = "TechnologyUpgradeStartEvent";


    public function TechnologyUpgradeStartEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
