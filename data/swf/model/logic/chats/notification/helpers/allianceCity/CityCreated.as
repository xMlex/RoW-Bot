package model.logic.chats.notification.helpers.allianceCity {
import common.ArrayCustom;

import flash.events.Event;

import model.data.alliances.city.AllianceCityData;
import model.data.locations.Location;
import model.data.locations.LocationNote;
import model.data.locations.allianceCity.LocationCityData;
import model.logic.AllianceManager;
import model.logic.LocationNoteManager;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.NotificationHelper;
import model.logic.chats.notification.events.allianceCity.CityCreatedEvent;
import model.logic.chats.notification.objects.allianceCity.AllianceNotificationData;
import model.logic.commands.allianceCity.GetAllianceCityCmd;
import model.modules.allianceCity.data.resourceHistory.AllianceResources;

public class CityCreated implements INotificationTypeHelper {


    private var _data:AllianceNotificationData;

    private var _cityId:int;

    public function CityCreated(param1:AllianceNotificationData) {
        super();
        if (param1 == null) {
            return;
        }
        this._data = param1;
        this.setData();
    }

    private function setData():void {
        this._cityId = this._data.cityId;
    }

    public function get getData():Object {
        return this._data;
    }

    public function execute():void {
        if (!AllianceManager.currentAlliance.gameData.cityData) {
            AllianceManager.currentAlliance.gameData.cityData = new AllianceCityData();
            AllianceManager.currentAlliance.gameData.cityData.resources = new AllianceResources();
        }
        AllianceManager.currentAlliance.gameData.cityData.allianceCityId = this._cityId;
        new GetAllianceCityCmd(AllianceManager.currentAlliance.id, 0).ifResult(function (param1:Location):void {
            AllianceManager.currentAllianceCity = param1;
            var _loc2_:* = new LocationNote();
            _loc2_.id = param1.id;
            _loc2_.segmentId = AllianceManager.currentAlliance.segmentId;
            _loc2_.revision = param1.gameData.revision;
            _loc2_.mapPos = param1.gameData.mapPos;
            _loc2_.name = param1.gameData.name;
            _loc2_._occupantAllianceId = AllianceManager.currentAlliance.id;
            _loc2_.allianceCityInfo = new LocationCityData();
            _loc2_.allianceCityInfo.level = param1.gameData.allianceCityData.currentLevel;
            _loc2_.allianceCityInfo.allianceId = AllianceManager.currentAlliance.id;
            _loc2_.allianceCityInfo.timeCreated = param1.gameData.allianceCityData.timeCreated;
            _loc2_.allianceCityInfo.timeDowngrade = param1.gameData.allianceCityData.lastDowngradeTime;
            LocationNoteManager.update(new ArrayCustom([_loc2_]));
            var _loc3_:* = new CityCreatedEvent(CityCreatedEvent.CITY_CREATED);
            NotificationHelper.events.dispatchEvent(_loc3_);
        }).doFinally(function ():void {
            AllianceManager.cityIsAlreadyLoaded = true;
            if (AllianceManager.currentAllianceCity != null) {
                AllianceManager.events.dispatchEvent(new Event(AllianceManager.ALLIANCE_CITY_LOADED));
            }
        }).execute();
    }
}
}
