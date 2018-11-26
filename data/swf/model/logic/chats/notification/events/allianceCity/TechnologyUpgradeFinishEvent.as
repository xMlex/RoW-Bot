package model.logic.chats.notification.events.allianceCity {
import flash.events.Event;

public class TechnologyUpgradeFinishEvent extends Event {

    public static const TECHNOLOGY_UPGRADE_FINISH:String = "TechnologyUpgradeFinishEvent";


    public function TechnologyUpgradeFinishEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
