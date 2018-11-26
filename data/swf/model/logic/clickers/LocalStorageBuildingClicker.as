package model.logic.clickers {
import common.GameType;
import common.localization.LocaleUtil;

import configs.Global;

import model.data.Resources;
import model.data.User;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.objects.info.BuildingObjInfo;
import model.data.scenes.types.info.BuildingGroupId;
import model.data.users.UserAccount;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class LocalStorageBuildingClicker {

    public static var clickedBuildingIds:Array = null;

    private static var allClicked:Boolean = false;

    private static var lastTimeClicked:Date = null;


    public function LocalStorageBuildingClicker() {
        super();
    }

    public static function shouldSendClicks():Boolean {
        if (!Global.serverSettings.localStorage.enabled) {
            return false;
        }
        if (lastTimeClicked == null || clickedBuildingIds == null || clickedBuildingIds.length == 0) {
            return false;
        }
        var _loc1_:User = UserManager.user;
        if (allClicked) {
            return true;
        }
        if ((_loc1_.gameData.normalizationTime.time - lastTimeClicked.time) / 1000 >= 1) {
            return true;
        }
        return false;
    }

    public static function populateWithClickedBuildingIds(param1:*):void {
        if (!Global.serverSettings.localStorage.enabled) {
            return;
        }
        if (lastTimeClicked == null || clickedBuildingIds == null || clickedBuildingIds.length == 0) {
            return;
        }
        param1.e = clickedBuildingIds;
        lastTimeClicked = null;
        allClicked = false;
    }

    public static function sendClicksIfNeeded():Boolean {
        var requestDto:* = undefined;
        var clickedIds:Array = null;
        if (!shouldSendClicks()) {
            return false;
        }
        requestDto = UserRefreshCmd.makeRequestDto();
        clickedIds = requestDto.e;
        new JsonCallCmd("ClickResourceBuildings", requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto) && clickedIds != null) {
                _loc2_ = ServerTimeManager.serverTimeNow;
                for each(_loc3_ in UserManager.user.gameData.sector.sectorScene.sceneObjects) {
                    _loc4_ = 0;
                    while (_loc4_ < clickedIds.length) {
                        if (clickedIds[_loc4_].i == _loc3_.id) {
                            _loc3_.buildingInfo.lastTimeCollected = _loc2_;
                        }
                        _loc4_++;
                    }
                }
            }
        }).execute();
        return true;
    }

    public static function clickResourceBuilding(param1:GeoSceneObject):String {
        var _loc2_:User = UserManager.user;
        var _loc3_:UserAccount = UserManager.user.gameData.account;
        var _loc4_:Resources = _loc3_.resourcesLimit.clone();
        _loc4_.substract(_loc3_.resources);
        if (_loc4_.capacity() < 1 && !GameType.isSparta) {
            return LocaleUtil.getText("localStorageBuildingClicker_error_global_storage_is_full");
        }
        if (param1.objectType.buildingInfo.groupId != BuildingGroupId.RESOURCE) {
            return LocaleUtil.getText("localStorageBuildingClicker_error_only_resource_building_can_be_clicked");
        }
        if (param1.getLevel() == 0) {
            return LocaleUtil.getText("localStorageBuildingClicker_error_building_is_not_active");
        }
        var _loc5_:BuildingObjInfo = param1.buildingInfo;
        if (_loc5_.localStorage == null) {
            return LocaleUtil.getText("localStorageBuildingClicker_error_building_has_no_local_storage");
        }
        if (_loc5_.lastTimeCollected != null && (_loc2_.gameData.normalizationTime.time - _loc5_.lastTimeCollected.time) / (1000 * 60) <= Global.serverSettings.localStorage.minimumCollectionIntervalMinutes) {
            return LocaleUtil.getText("localStorageBuildingClicker_error_too_early_to_click_by_building");
        }
        var _loc6_:Resources = param1.buildingInfo.localStorage.clone();
        _loc6_.threshold(_loc4_);
        if (_loc6_.capacity() <= 0 && !GameType.isSparta) {
            return LocaleUtil.getText("localStorageBuildingClicker_error_global_storage_is_full");
        }
        param1.buildingInfo.localStorage.substract(_loc6_);
        param1.buildingInfo.lastTimeCollected = _loc2_.gameData.normalizationTime;
        _loc3_.resources.add(_loc6_);
        addBuildingId(param1.id, _loc6_);
        return "";
    }

    private static function addBuildingId(param1:Number, param2:Resources):void {
        var _loc3_:* = undefined;
        var _loc4_:User = null;
        var _loc5_:int = 0;
        var _loc6_:GeoSceneObject = null;
        if (clickedBuildingIds == null) {
            clickedBuildingIds = [];
        }
        for each(_loc3_ in clickedBuildingIds) {
            if (_loc3_.i == param1) {
                return;
            }
        }
        _loc4_ = UserManager.user;
        clickedBuildingIds.push({
            "c": ++UserManager.user.gameData.sector.lastClickId,
            "i": param1,
            "r": param2.toDto()
        });
        _loc5_ = 0;
        for each(_loc6_ in _loc4_.gameData.sector.sectorScene.sceneObjects) {
            if (_loc6_.buildingInfo.localStorage != null) {
                _loc5_++;
            }
        }
        if (clickedBuildingIds.length == _loc5_) {
            allClicked = true;
        }
        lastTimeClicked = _loc4_.gameData.normalizationTime;
    }
}
}
