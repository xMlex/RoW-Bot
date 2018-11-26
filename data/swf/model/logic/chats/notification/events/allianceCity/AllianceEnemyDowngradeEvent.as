package model.logic.chats.notification.events.allianceCity {
import flash.events.Event;

public class AllianceEnemyDowngradeEvent extends Event {

    public static const ALLIANCE_ENEMY_DOWNGRADE_CHANGED:String = "AllianceEnemyDowngradeEvent";


    public function AllianceEnemyDowngradeEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
