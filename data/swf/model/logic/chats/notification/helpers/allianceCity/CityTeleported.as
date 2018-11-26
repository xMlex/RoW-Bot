package model.logic.chats.notification.helpers.allianceCity {
import common.ArrayCustom;

import model.data.locations.LocationNote;
import model.data.locations.allianceCity.LocationCityData;
import model.data.map.MapPos;
import model.logic.AllianceManager;
import model.logic.LocationNoteManager;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.NotificationHelper;
import model.logic.chats.notification.events.allianceCity.CityTeleportedEvent;
import model.logic.chats.notification.objects.allianceCity.AllianceNotificationData;

public class CityTeleported implements INotificationTypeHelper {


    private var _data:AllianceNotificationData;

    private var _mapPos:MapPos;

    private var _teleportationTime:Date;

    public function CityTeleported(param1:AllianceNotificationData) {
        super();
        if (param1 == null) {
            return;
        }
        this._data = param1;
        this.setData();
    }

    private function setData():void {
        this._mapPos = this._data.position;
        this._teleportationTime = this._data.teleportationTime;
    }

    public function get getData():Object {
        return this._data;
    }

    public function execute():void {
        AllianceManager.currentAllianceCity.gameData.mapPos = this._mapPos;
        AllianceManager.currentAllianceCity.gameData.allianceCityData.lastTeleportationTime = this._teleportationTime;
        var _loc1_:LocationNote = new LocationNote();
        _loc1_.id = AllianceManager.currentAllianceCity.id;
        _loc1_.segmentId = AllianceManager.currentAlliance.segmentId;
        _loc1_.revision = AllianceManager.currentAllianceCity.gameData.revision;
        _loc1_.mapPos = AllianceManager.currentAllianceCity.gameData.mapPos;
        _loc1_.name = AllianceManager.currentAllianceCity.gameData.name;
        _loc1_._occupantAllianceId = AllianceManager.currentAlliance.id;
        _loc1_.allianceCityInfo = new LocationCityData();
        _loc1_.allianceCityInfo.level = AllianceManager.currentAllianceCity.gameData.allianceCityData.currentLevel;
        _loc1_.allianceCityInfo.allianceId = AllianceManager.currentAlliance.id;
        _loc1_.allianceCityInfo.timeCreated = AllianceManager.currentAllianceCity.gameData.allianceCityData.timeCreated;
        _loc1_.allianceCityInfo.timeDowngrade = AllianceManager.currentAllianceCity.gameData.allianceCityData.lastDowngradeTime;
        LocationNoteManager.update(new ArrayCustom([_loc1_]));
        var _loc2_:CityTeleportedEvent = new CityTeleportedEvent(CityTeleportedEvent.CITY_TELEPORTED);
        NotificationHelper.events.dispatchEvent(_loc2_);
    }
}
}
