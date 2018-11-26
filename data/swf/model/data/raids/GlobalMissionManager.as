package model.data.raids {
import common.ArrayCustom;
import common.DateUtil;
import common.localization.LocaleUtil;

import flash.geom.Point;
import flash.utils.Dictionary;

import integration.SocialNetworkIdentifier;

import model.logic.ServerManager;
import model.logic.ServerTimeManager;

public class GlobalMissionManager {

    public static var name01:String = LocaleUtil.getText("MissionBonus01_Thompson_ambrosy");

    public static var description01:String = LocaleUtil.getText("MissionBonus01_cinderella_mission");

    public static var name02:String = LocaleUtil.getText("MissionBonus02_main_object");

    public static var description02:String = LocaleUtil.getText("MissionBonus02_main_object_description");

    public static var name03:String = LocaleUtil.getText("MissionBonus03_main_object");

    public static var description03:String = LocaleUtil.getText("MissionBonus03_main_object_description");

    public static var name04:String = LocaleUtil.getText("MissionBonus04_main_object");

    public static var description04:String = LocaleUtil.getText("MissionBonus04_main_object_description");

    public static var objectsDataByGlobalMission:Dictionary = new Dictionary();

    public static var globalMissionArchiveDataList:ArrayCustom = new ArrayCustom();

    public static const gmMainObjectProgress02Url:String = ServerManager.buildContentUrl("ui/quests/decorForGlobalMissions/gm02_progress.swf");

    public static const gmMainObjectComplete02Url:String = ServerManager.buildContentUrl("ui/quests/decorForGlobalMissions/gm02_complete.swf");

    public static const gmMainObjectFaultSmall02Url:String = ServerManager.buildContentUrl("ui/quests/decorForGlobalMissions/gm02_faultSmall.swf");

    public static const gmMainObjectProgress02Tooltip:String = LocaleUtil.getText("MissionBonus02_main_object_progress_tooltip");

    public static const gmMainObjectComplete02Tooltip:String = LocaleUtil.getText("MissionBonus02_main_object_complete_tooltip");

    public static const gmMainObjectFault02Tooltip:String = LocaleUtil.getText("MissionBonus02_main_object_fault_tooltip");

    public static var gmMainObjectSize02:Point = new Point(227, 248);

    public static var gmMainObjectSize02_fault:Point = new Point(6, 7);

    public static var gmMainObjectSize02_faultSmall:Point = new Point(152, 103);

    private static var _gmMainObjectPosition02:Point;

    private static var _gmMainObjectPosition02_fault:Point;

    public static var myPosition:int = -1;

    public static var callTime:Date;


    public function GlobalMissionManager() {
        super();
    }

    public static function get gmMainObjectPosition02():Point {
        if (_gmMainObjectPosition02) {
            return _gmMainObjectPosition02;
        }
        if (SocialNetworkIdentifier.isVK) {
            _gmMainObjectPosition02 = new Point(4, -1);
        }
        else if (SocialNetworkIdentifier.isCM) {
            _gmMainObjectPosition02 = new Point(-2, -2);
        }
        else if (SocialNetworkIdentifier.isMR) {
            _gmMainObjectPosition02 = new Point(-2, -1);
        }
        else if (SocialNetworkIdentifier.isFB) {
            _gmMainObjectPosition02 = new Point(-3, -2);
        }
        else if (SocialNetworkIdentifier.isPortalClusters) {
            _gmMainObjectPosition02 = new Point(-3, -2);
        }
        else {
            _gmMainObjectPosition02 = new Point(-3, -2);
        }
        return _gmMainObjectPosition02;
    }

    public static function get gmMainObjectPosition02_fault():Point {
        if (_gmMainObjectPosition02_fault) {
            return _gmMainObjectPosition02_fault;
        }
        if (SocialNetworkIdentifier.isVK) {
            _gmMainObjectPosition02_fault = new Point(1, -4);
        }
        else if (SocialNetworkIdentifier.isCM) {
            _gmMainObjectPosition02_fault = new Point(-5, -5);
        }
        else if (SocialNetworkIdentifier.isMR) {
            _gmMainObjectPosition02_fault = new Point(-5, -4);
        }
        else if (SocialNetworkIdentifier.isFB) {
            _gmMainObjectPosition02_fault = new Point(-6, -5);
        }
        else if (SocialNetworkIdentifier.isPortalClusters) {
            _gmMainObjectPosition02_fault = new Point(-6, -5);
        }
        else {
            _gmMainObjectPosition02_fault = new Point(-6, -5);
        }
        return _gmMainObjectPosition02_fault;
    }

    public static function getCollectedObjectUrl(param1:int):String {
        var _loc2_:GlobalMissionUIData = objectsDataByGlobalMission[param1] as GlobalMissionUIData;
        if (_loc2_) {
            return ServerManager.buildContentUrl(_loc2_.objectPictureUrl);
        }
        return null;
    }

    public static function getCollectedObjectName(param1:int):String {
        var _loc2_:GlobalMissionUIData = objectsDataByGlobalMission[param1] as GlobalMissionUIData;
        if (_loc2_) {
            return _loc2_.objectName;
        }
        return null;
    }

    public static function getMainObjectFault02Url(param1:int, param2:int):String {
        return "ui/quests/decorForGlobalMissions/gm04_fault/0" + (param1 + 1).toString() + "v_0" + (param2 + 1).toString() + "h.png";
    }

    public static function isObsoleteDataMyPosition():Boolean {
        return callTime == null || DateUtil.getTimeBetween(callTime, ServerTimeManager.serverTimeNow) > 30000 || myPosition == -1;
    }
}
}
