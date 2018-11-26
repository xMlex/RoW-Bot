package model.logic.chats.notification.events.allianceCity {
import flash.events.Event;

public class AllianceResourcesChangedEvent extends Event {

    public static const ALLIANCE_RESOURCES_CHANGED:String = "AllianceResourcesChangedEvent";


    public function AllianceResourcesChangedEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
