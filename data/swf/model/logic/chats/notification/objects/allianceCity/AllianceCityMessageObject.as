package model.logic.chats.notification.objects.allianceCity {
import model.modules.allianceCity.logic.EffectiveTechnologyLevelHistoryItem;

public class AllianceCityMessageObject {


    public var typesList:Vector.<AllianceNotification>;

    public var date:Number;

    public var newLevels:EffectiveTechnologyLevelHistoryItem;

    public var revision:Number;

    public function AllianceCityMessageObject() {
        super();
    }
}
}
