package model.logic.misc {
import configs.Global;

import model.data.Resources;
import model.data.User;
import model.data.units.Unit;
import model.data.units.payloads.TradingPayload;
import model.data.users.UserWorldData;
import model.data.users.misc.UserResourceFlow;
import model.logic.StaticDataManager;
import model.logic.StaticKnownUsersData;

public class ResourcesFlowManager {


    public function ResourcesFlowManager() {
        super();
    }

    public static function canSendResources(param1:User, param2:Number):Boolean {
        var _loc3_:UserWorldData = param1.gameData.worldData;
        var _loc4_:UserResourceFlow = _loc3_.getOrAddResourcesFlow(param2);
        var _loc5_:Number = Global.serverSettings.unit.userResourcesFlowLimit;
        return _loc4_.getResources(param1.gameData.normalizationTime) > -_loc5_;
    }

    public static function canRobResources(param1:User, param2:Number):Boolean {
        var _loc3_:UserWorldData = param1.gameData.worldData;
        var _loc4_:UserResourceFlow = _loc3_.getOrAddResourcesFlow(param2);
        var _loc5_:Number = Global.serverSettings.unit.userResourcesFlowLimit;
        return _loc4_.getResources(param1.gameData.normalizationTime) < _loc5_;
    }

    public static function howMuchIRobbedResources(param1:User, param2:Number):Number {
        var _loc3_:UserWorldData = param1.gameData.worldData;
        var _loc4_:UserResourceFlow = _loc3_.getOrAddResourcesFlow(param2);
        return _loc4_.getResources(param1.gameData.normalizationTime);
    }

    public static function reachedResourcesLimit(param1:User, param2:Number, param3:TradingPayload):Boolean {
        var _loc4_:UserWorldData = param1.gameData.worldData;
        var _loc5_:UserResourceFlow = _loc4_.getOrAddResourcesFlow(param2);
        var _loc6_:Number = Global.serverSettings.unit.userResourcesFlowLimit;
        if (!param3 || !param3.resources) {
            return _loc6_ - Math.abs(_loc5_.getResources(param1.gameData.normalizationTime)) <= 0;
        }
        var _loc7_:Resources = param3.resources.clone();
        _loc7_.scale(-1);
        var _loc8_:Number = _loc6_ - Math.abs(_loc5_.getResources(param1.gameData.normalizationTime) + _loc7_.capacity());
        return _loc8_ < 0;
    }

    public static function reachedTotalDailyResourceCaravansLimit(param1:User):Boolean {
        var _loc2_:StaticKnownUsersData = StaticDataManager.knownUsersData;
        return param1.gameData.worldData.resourceCaravansSentToday >= _loc2_.resourceCaravansTotalDailyLimit;
    }

    public static function reachedUserDailyResourceCavavansLimit(param1:User, param2:Number):Boolean {
        var _loc3_:StaticKnownUsersData = StaticDataManager.knownUsersData;
        var _loc4_:UserResourceFlow = param1.gameData.worldData.getOrAddResourcesFlow(param2);
        return _loc4_.resourceCaravansSentToday >= _loc3_.resourceCaravansUserDailyLimit;
    }

    public static function reachedTotalDailyDrawingCaravansLimit(param1:User):Boolean {
        var _loc2_:StaticKnownUsersData = StaticDataManager.knownUsersData;
        return param1.gameData.worldData.drawingCaravansSentToday >= _loc2_.drawingCaravansTotalDailyLimit;
    }

    public static function unitSent(param1:User, param2:Unit):Number {
        var _loc7_:UserResourceFlow = null;
        var _loc8_:Resources = null;
        var _loc9_:Number = NaN;
        if (param2.TargetIsLocation == true) {
            return 0;
        }
        var _loc3_:UserWorldData = param1.gameData.worldData;
        var _loc4_:* = param1.id == param2.OwnerUserId;
        var _loc5_:* = !_loc4_;
        var _loc6_:Number = !!_loc4_ ? Number(param2.TargetUserId) : Number(param2.OwnerUserId);
        if (param2.tradingPayload != null && param2.tradingOfferPayload == null && param2.StateMovingForward != null) {
            _loc7_ = _loc3_.getOrAddResourcesFlow(_loc6_);
            if (_loc4_) {
                _loc3_.updateCaravansCounter(_loc7_, param2.tradingPayload);
            }
            if (param2.tradingPayload.resources == null) {
                return 0;
            }
            _loc8_ = Resources.scale(param2.tradingPayload.resources, !!_loc4_ ? Number(-1) : Number(1));
            _loc9_ = _loc3_.changeResourcesFlow2(param1, _loc7_, _loc8_, _loc5_);
            if (_loc9_ < 0 && _loc5_) {
                truncateResources(param2.tradingPayload.resources, _loc9_);
            }
            return _loc9_;
        }
        return 0;
    }

    private static function truncateResources(param1:Resources, param2:Number):void {
        var _loc3_:Number = param1.capacity();
        var _loc4_:Number = (_loc3_ + param2) / _loc3_;
        param1.scale(_loc4_ < 0 ? Number(0) : Number(_loc4_));
    }
}
}
