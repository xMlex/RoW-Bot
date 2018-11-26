package model.data.normalization {
import model.data.User;
import model.data.UserGameData;
import model.data.alliances.Alliance;
import model.data.alliances.AllianceGameData;
import model.data.alliances.normalization.INEventAlliance;
import model.data.alliances.normalization.INormalizableAlliance;
import model.data.alliances.normalization.NEventAlliance;
import model.logic.ServerTimeManager;

public class Normalizer {


    public function Normalizer() {
        super();
    }

    public static function normalizeTime(param1:Date):Date {
        var _loc2_:Number = param1.time % 1000;
        return _loc2_ == 0 ? param1 : new Date(param1.time + 1000 - _loc2_);
    }

    public static function normalize(param1:User):Date {
        var _loc2_:Date = ServerTimeManager.serverTimeNow;
        return normalize2(param1, _loc2_);
    }

    public static function normalize2(param1:User, param2:Date):Date {
        var _loc6_:INEvent = null;
        var _loc3_:UserGameData = param1.gameData;
        var _loc4_:Array = _loc3_.getNormalizableList();
        param2 = normalizeTime(param2);
        if (_loc3_.normalizationTime > param2) {
            return _loc3_.normalizationTime;
        }
        var _loc5_:Boolean = false;
        while ((_loc6_ = getNextEvent(param1, _loc4_, param2)) != null) {
            processEvent(param1, _loc6_);
            _loc5_ = true;
        }
        if (_loc3_.normalizationTime != param2) {
            processEvent(param1, new NEventUser(param2));
        }
        _loc3_.updateObjectsBuyStatus(_loc5_);
        if (param1.gameData.dragonData && param1.gameData.dragonData.activeDragon) {
            param1.gameData.dragonData.updateActiveDragonData();
        }
        if (param1.gameData.promotionOfferData != null) {
            param1.gameData.promotionOfferData.updateStatus();
        }
        param1.gameData.dispatchEvents();
        return _loc3_.normalizationTime;
    }

    private static function getNextEvent(param1:User, param2:Array, param3:Date):INEvent {
        var _loc5_:INormalizable = null;
        var _loc6_:INEvent = null;
        var _loc4_:INEvent = null;
        for each(_loc5_ in param2) {
            _loc6_ = _loc5_.getNextEvent(param1, param3);
            if (_loc6_ != null) {
                if (_loc6_.time <= param3) {
                    _loc4_ = _loc6_;
                    param3 = _loc4_.time;
                }
            }
        }
        return _loc4_;
    }

    private static function processEvent(param1:User, param2:INEvent):void {
        var _loc3_:UserGameData = param1.gameData;
        var _loc4_:Date = _loc3_.normalizationTime;
        _loc3_.normalizationTime = param2.time;
        param2.process(param1, _loc4_);
    }

    public static function normalizeAlliance(param1:Alliance):Date {
        var _loc2_:Date = ServerTimeManager.serverTimeNow;
        return normalizeAlliance2(param1, _loc2_);
    }

    public static function normalizeAlliance2(param1:Alliance, param2:Date):Date {
        var _loc6_:INEventAlliance = null;
        var _loc3_:AllianceGameData = param1.gameData;
        var _loc4_:Array = _loc3_.getNormalizableList();
        param2 = normalizeTime(param2);
        if (_loc3_.normalizationTime > param2) {
            return _loc3_.normalizationTime;
        }
        var _loc5_:Boolean = false;
        while ((_loc6_ = getNextAllianceEvent(param1, _loc4_, param2)) != null) {
            processAllianceEvent(param1, _loc6_);
            _loc5_ = true;
        }
        if (_loc3_.normalizationTime != param2) {
            processAllianceEvent(param1, new NEventAlliance(param2));
        }
        param1.gameData.dispatchEvents();
        return _loc3_.normalizationTime;
    }

    private static function getNextAllianceEvent(param1:Alliance, param2:Array, param3:Date):INEventAlliance {
        var _loc5_:INormalizableAlliance = null;
        var _loc6_:INEventAlliance = null;
        var _loc4_:INEventAlliance = null;
        for each(_loc5_ in param2) {
            _loc6_ = _loc5_.getNextEvent(param1, param3);
            if (_loc6_ != null) {
                if (_loc6_.time <= param3) {
                    _loc4_ = _loc6_;
                    param3 = _loc4_.time;
                }
            }
        }
        return _loc4_;
    }

    private static function processAllianceEvent(param1:Alliance, param2:INEventAlliance):void {
        var _loc3_:AllianceGameData = param1.gameData;
        var _loc4_:Date = _loc3_.normalizationTime;
        _loc3_.normalizationTime = param2.time;
        param2.process(param1, _loc4_);
    }
}
}
