package model.logic.chats.notification.helpers.allianceCity {
import flash.utils.Dictionary;

import model.logic.AllianceManager;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.NotificationHelper;
import model.logic.chats.notification.events.allianceCity.CityLevelChangedEvent;

public class CityUpgradeFinish implements INotificationTypeHelper {


    public function CityUpgradeFinish() {
        super();
    }

    public function get getData():Object {
        return null;
    }

    public function execute():void {
        AllianceManager.currentAllianceCity.gameData.allianceCityData.upgradeStartTime = null;
        AllianceManager.currentAllianceCity.gameData.allianceCityData.upgradeFinishTime = null;
        if (AllianceManager.currentAllianceCity.gameData.allianceCityData.level == AllianceManager.currentAllianceCity.gameData.allianceCityData.highestLevel) {
            AllianceManager.currentAlliance.gameData.cityData.enemyDowngrades = new Dictionary();
        }
        AllianceManager.currentAllianceCity.gameData.allianceCityData.level++;
        var _loc1_:CityLevelChangedEvent = new CityLevelChangedEvent(CityLevelChangedEvent.CITY_LEVEL_CHANGED);
        NotificationHelper.events.dispatchEvent(_loc1_);
    }
}
}
