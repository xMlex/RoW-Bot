package model.logic.chats.notification.handlers {
import json.JSONOur;

import model.logic.AllianceManager;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.chats.ChatMessage;
import model.logic.chats.notification.INotificationHelper;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.helpers.allianceCity.AllianceEnemyCityDowngradeChanged;
import model.logic.chats.notification.helpers.allianceCity.AllianceResourcesChanged;
import model.logic.chats.notification.helpers.allianceCity.CityCreated;
import model.logic.chats.notification.helpers.allianceCity.CityDowngrade;
import model.logic.chats.notification.helpers.allianceCity.CityTeleported;
import model.logic.chats.notification.helpers.allianceCity.CityUpgradeFinish;
import model.logic.chats.notification.helpers.allianceCity.CityUpgradeInterrupted;
import model.logic.chats.notification.helpers.allianceCity.CityUpgradeStart;
import model.logic.chats.notification.helpers.allianceCity.RefreshAllianceCityHelper;
import model.logic.chats.notification.helpers.allianceCity.TechnologyUpgradeFinish;
import model.logic.chats.notification.helpers.allianceCity.TechnologyUpgradeStart;
import model.logic.chats.notification.objects.allianceCity.AllianceCityMessageObject;
import model.logic.chats.notification.objects.allianceCity.AllianceCityNotificationCashObject;
import model.logic.chats.notification.objects.allianceCity.AllianceNotification;
import model.logic.chats.notification.types.AllianceCityNotificationType;
import model.modules.allianceCity.logic.AllianceCityManager;
import model.modules.allianceCity.logic.EffectiveTechnologyLevelHistoryItem;

public class AllianceCityNotificationHandlerFactory implements INotificationHelper {


    private var _revision:Number;

    private var _notificationHelpersList:Vector.<INotificationTypeHelper>;

    private var _notificationCash:Vector.<AllianceCityNotificationCashObject>;

    public function AllianceCityNotificationHandlerFactory() {
        this._notificationCash = new Vector.<AllianceCityNotificationCashObject>(0);
        super();
    }

    public static function notificationDataConvert(param1:String):AllianceCityMessageObject {
        var _loc2_:AllianceCityMessageObject = new AllianceCityMessageObject();
        var _loc3_:* = JSONOur.decode(param1);
        _loc2_.typesList = AllianceNotification.fromDtos(_loc3_.n);
        _loc2_.newLevels = _loc3_.h == null ? new EffectiveTechnologyLevelHistoryItem() : EffectiveTechnologyLevelHistoryItem.fromDto(_loc3_.h);
        _loc2_.date = _loc3_.d;
        _loc2_.revision = _loc3_.r;
        return _loc2_;
    }

    public function findHandler(param1:ChatMessage):void {
        var _loc5_:AllianceNotification = null;
        var _loc7_:AllianceCityNotificationCashObject = null;
        this._notificationHelpersList = new Vector.<INotificationTypeHelper>();
        if (isNaN(UserManager.user.gameData.allianceData.allianceId)) {
            return;
        }
        var _loc2_:AllianceCityMessageObject = notificationDataConvert(param1.text);
        if (_loc2_.newLevels.date && _loc2_.newLevels.date.time > ServerTimeManager.sessionStartTimeMs) {
            AllianceCityManager.addHistoryItem(_loc2_.newLevels);
        }
        if (_loc2_.date < ServerTimeManager.sessionStartTimeMs) {
            return;
        }
        this._revision = _loc2_.revision;
        var _loc3_:int = AllianceManager.currentAllianceCity && AllianceManager.currentAllianceCity.gameData ? int(AllianceManager.currentAllianceCity.gameData.revision) : int(this._revision);
        var _loc4_:Boolean = false;
        if (this._revision - _loc3_ > 1) {
            this._notificationHelpersList.push(new RefreshAllianceCityHelper());
            _loc4_ = true;
        }
        var _loc6_:int = 0;
        while (_loc6_ < _loc2_.typesList.length) {
            _loc5_ = _loc2_.typesList[_loc6_];
            switch (_loc5_.type) {
                case AllianceCityNotificationType.CITY_REFRESH_EFFECTIVE_LEVELS:
                    if (!_loc4_) {
                        this._notificationHelpersList.push(new RefreshAllianceCityHelper());
                        _loc4_ = true;
                    }
                    break;
                case AllianceCityNotificationType.CITY_TECHNOLOGY_UPGRADE_STARTED:
                    this._notificationHelpersList.push(new TechnologyUpgradeStart(_loc5_.data));
                    break;
                case AllianceCityNotificationType.CITY_TECHNOLOGY_UPGRADE_FINISHED:
                    this._notificationHelpersList.push(new TechnologyUpgradeFinish(_loc5_.data));
                    break;
                case AllianceCityNotificationType.CITY_UPGRADE_STARTED:
                    this._notificationHelpersList.push(new CityUpgradeStart(_loc5_.data));
                    break;
                case AllianceCityNotificationType.CITY_UPGRADE_FINISHED:
                    this._notificationHelpersList.push(new CityUpgradeFinish());
                    break;
                case AllianceCityNotificationType.CITY_UNITS_CHANGED:
                    if (!_loc4_) {
                        this._notificationHelpersList.push(new RefreshAllianceCityHelper());
                        _loc4_ = true;
                    }
                    break;
                case AllianceCityNotificationType.CITY_CREATED:
                    this._notificationHelpersList.push(new CityCreated(_loc5_.data));
                    break;
                case AllianceCityNotificationType.CITY_TELEPORTED:
                    this._notificationHelpersList.push(new CityTeleported(_loc5_.data));
                    break;
                case AllianceCityNotificationType.CITY_DOWNGRADE:
                    this._notificationHelpersList.push(new CityDowngrade(_loc5_.data));
                    break;
                case AllianceCityNotificationType.CITY_UPGRADE_INTERRUPTED:
                    this._notificationHelpersList.push(new CityUpgradeInterrupted(_loc5_.data));
                    break;
                case AllianceCityNotificationType.ALLIANCE_RESOURCES_CHANGED:
                    this._notificationHelpersList.push(new AllianceResourcesChanged(_loc5_.data));
                    break;
                case AllianceCityNotificationType.ALLIANCE_ENEMY_CITY_DOWNGRADED:
                    this._notificationHelpersList.push(new AllianceEnemyCityDowngradeChanged(_loc5_.data));
                    break;
                case AllianceCityNotificationType.ALLIANCE_CITY_FLAGS_UPDATED:
                    if (!_loc4_) {
                        this._notificationHelpersList.push(new RefreshAllianceCityHelper());
                        _loc4_ = true;
                    }
            }
            _loc6_++;
        }
        if (this.isAllianceDataLoadInProgress) {
            _loc7_ = new AllianceCityNotificationCashObject();
            _loc7_.revision = this._revision;
            _loc7_.notificationHelpersList = this._notificationHelpersList;
            this._notificationCash.push(_loc7_);
        }
        if (!_loc4_ && _loc2_.typesList.length > 0) {
            if (AllianceManager.currentAllianceCity && AllianceManager.currentAllianceCity.gameData) {
                AllianceManager.currentAllianceCity.gameData.revision = this._revision;
            }
        }
    }

    public function execute():void {
        if (this.isAllianceDataLoadInProgress) {
            return;
        }
        var _loc1_:int = 0;
        while (_loc1_ < this._notificationHelpersList.length) {
            this._notificationHelpersList[_loc1_].execute();
            _loc1_++;
        }
    }

    public function get isAllianceDataLoadInProgress():Boolean {
        return !AllianceManager.currentAlliance || AllianceManager.currentAlliance && AllianceManager.currentAlliance.gameData.cityData && !isNaN(AllianceManager.currentAlliance.gameData.cityData.allianceCityId) && AllianceManager.currentAllianceCity == null;
    }

    public function executeCash():void {
        var _loc1_:AllianceCityNotificationCashObject = null;
        var _loc3_:int = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this._notificationCash.length) {
            _loc1_ = this._notificationCash[_loc2_];
            if (_loc1_.revision > AllianceManager.currentAllianceCity.gameData.revision) {
                _loc3_ = 0;
                while (_loc3_ < _loc1_.notificationHelpersList.length) {
                    _loc1_.notificationHelpersList[_loc3_].execute();
                    _loc3_++;
                }
            }
            _loc2_++;
        }
        this._notificationCash = new Vector.<AllianceCityNotificationCashObject>(0);
    }
}
}
