package model.logic.chats.notification.helpers.allianceCity {
import model.logic.AllianceManager;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.NotificationHelper;
import model.logic.chats.notification.events.allianceCity.CityUpgradeStartEvent;
import model.logic.chats.notification.objects.allianceCity.AllianceNotificationData;

public class CityUpgradeStart implements INotificationTypeHelper {


    private var _data:AllianceNotificationData;

    private var _dateStart:Date;

    private var _dateFinish:Date;

    public function CityUpgradeStart(param1:AllianceNotificationData) {
        super();
        if (param1 == null) {
            return;
        }
        this._data = param1;
        this.setData();
    }

    private function setData():void {
        this._dateStart = this._data.startTime;
        this._dateFinish = this._data.finishTime;
    }

    public function get getData():Object {
        return this._data;
    }

    public function execute():void {
        AllianceManager.currentAllianceCity.gameData.allianceCityData.upgradeStartTime = this._dateStart;
        AllianceManager.currentAllianceCity.gameData.allianceCityData.upgradeFinishTime = this._dateFinish;
        var _loc1_:CityUpgradeStartEvent = new CityUpgradeStartEvent(CityUpgradeStartEvent.CITY_UPGRADE_START);
        NotificationHelper.events.dispatchEvent(_loc1_);
    }
}
}
