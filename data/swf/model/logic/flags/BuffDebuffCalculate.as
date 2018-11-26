package model.logic.flags {
import common.DateUtil;
import common.queries.util.query;

import model.data.alliances.AllianceNote;
import model.data.locations.allianceCity.flags.AllianceTacticsEffect;
import model.data.locations.allianceCity.flags.AllianceTacticsEffectType;
import model.data.locations.allianceCity.flags.enumeration.AllianceEffectApplyingType;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;

public class BuffDebuffCalculate {


    public function BuffDebuffCalculate() {
        super();
    }

    public static function getEffectByType(param1:Number):AllianceTacticsEffectType {
        return StaticDataManager.allianceData.tacticsData.allianceEffectTypesById[param1];
    }

    public static function getEffectsByApplyingType(param1:int):Array {
        var allianceEffectApplyingType:int = param1;
        return query(StaticDataManager.allianceData.tacticsData.allianceEffectTypes).where(function (param1:AllianceTacticsEffectType):Boolean {
            return param1.applyingType == allianceEffectApplyingType;
        }).toArray();
    }

    public static function getApplyEffectCount(param1:Array, param2:int):int {
        var activeTacticsEffects:Array = param1;
        var allianceEffectApplyingType:int = param2;
        return query(activeTacticsEffects).where(function (param1:AllianceTacticsEffect):Boolean {
            return param1.toTime.time > ServerTimeManager.serverTimeNow.time && getEffectByType(param1.typeId).applyingType == allianceEffectApplyingType;
        }).count();
    }

    public static function getActiveEffectByTypeCount(param1:AllianceNote, param2:Number):int {
        var allianceNote:AllianceNote = param1;
        var typeId:Number = param2;
        return query(allianceNote.activeTacticsEffects).where(function (param1:AllianceTacticsEffect):Boolean {
            return param1.toTime.time > ServerTimeManager.serverTimeNow.time && param1.typeId == typeId;
        }).count();
    }

    public static function getBonusValueByType(param1:Array, param2:int):int {
        var activeTacticsEffects:Array = param1;
        var allianceEffectBonusType:int = param2;
        var countByType:int = query(activeTacticsEffects).sum(function (param1:AllianceTacticsEffect):int {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (param1.toTime.time > ServerTimeManager.serverTimeNow.time) {
                _loc2_ = getEffectByType(param1.typeId);
                if (_loc2_.bonusType == allianceEffectBonusType) {
                    _loc3_ = _loc2_.applyingType == AllianceEffectApplyingType.BUFF ? 1 : -1;
                    return _loc3_ * _loc2_.value;
                }
            }
            return 0;
        });
        return countByType;
    }

    public static function getFirstEndingActiveEffectByType(param1:Array):AllianceTacticsEffect {
        var activeTacticsEffects:Array = param1;
        return query(activeTacticsEffects).where(function (param1:AllianceTacticsEffect):Boolean {
            return param1.toTime.time > ServerTimeManager.serverTimeNow.time;
        }).min(function (param1:AllianceTacticsEffect):* {
            return param1;
        }, function (param1:AllianceTacticsEffect, param2:AllianceTacticsEffect):int {
            return DateUtil.compare(param1.toTime, param2.toTime);
        });
    }
}
}
