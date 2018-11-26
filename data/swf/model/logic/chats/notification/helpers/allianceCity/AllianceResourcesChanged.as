package model.logic.chats.notification.helpers.allianceCity {
import model.logic.AllianceManager;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.NotificationHelper;
import model.logic.chats.notification.events.allianceCity.AllianceResourcesChangedEvent;
import model.logic.chats.notification.objects.allianceCity.AllianceNotificationData;
import model.modules.allianceCity.data.resourceHistory.AllianceResources;

public class AllianceResourcesChanged implements INotificationTypeHelper {


    private var _data:AllianceNotificationData;

    private var _newResources:AllianceResources;

    public function AllianceResourcesChanged(param1:AllianceNotificationData) {
        super();
        if (param1 == null) {
            return;
        }
        this._data = param1;
        this.setData();
    }

    private function setData():void {
        this._newResources = this._data.allianceResources;
    }

    public function get getData():Object {
        return this._data;
    }

    public function execute():void {
        AllianceManager.currentAlliance.gameData.cityData.resources = this._newResources;
        var _loc1_:AllianceResourcesChangedEvent = new AllianceResourcesChangedEvent(AllianceResourcesChangedEvent.ALLIANCE_RESOURCES_CHANGED);
        NotificationHelper.events.dispatchEvent(_loc1_);
    }
}
}
