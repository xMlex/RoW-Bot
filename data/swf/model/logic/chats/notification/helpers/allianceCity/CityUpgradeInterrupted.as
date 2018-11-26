package model.logic.chats.notification.helpers.allianceCity {
import model.logic.AllianceManager;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.NotificationHelper;
import model.logic.chats.notification.events.allianceCity.CityLevelChangedEvent;
import model.logic.chats.notification.objects.allianceCity.AllianceNotificationData;

public class CityUpgradeInterrupted implements INotificationTypeHelper {


    private var _data:AllianceNotificationData;

    private var _level:int;

    public function CityUpgradeInterrupted(param1:AllianceNotificationData) {
        super();
        if (param1 == null) {
            return;
        }
        this._data = param1;
        this.setData();
    }

    private function setData():void {
        this._level = this._data.level;
    }

    public function get getData():Object {
        return this._data;
    }

    public function execute():void {
        AllianceManager.currentAllianceCity.gameData.allianceCityData.level = this._level;
        AllianceManager.currentAllianceCity.gameData.allianceCityData.upgradeStartTime = null;
        AllianceManager.currentAllianceCity.gameData.allianceCityData.upgradeFinishTime = null;
        var _loc1_:CityLevelChangedEvent = new CityLevelChangedEvent(CityLevelChangedEvent.CITY_LEVEL_CHANGED);
        NotificationHelper.events.dispatchEvent(_loc1_);
    }
}
}
