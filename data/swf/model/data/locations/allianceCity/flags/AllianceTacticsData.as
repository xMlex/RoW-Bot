package model.data.locations.allianceCity.flags {
import common.queries.util.query;

import model.logic.ServerTimeManager;

public class AllianceTacticsData {


    public var prototypeIds:Array;

    public var activeEffects:Array;

    public var effectsBonuses:Array;

    public function AllianceTacticsData() {
        super();
    }

    public static function fromDto(param1:*):AllianceTacticsData {
        var _loc3_:int = 0;
        var _loc2_:AllianceTacticsData = new AllianceTacticsData();
        if (param1.p != null) {
            _loc2_.prototypeIds = [];
            for each(_loc3_ in param1.p) {
                _loc2_.prototypeIds.push(_loc3_);
            }
        }
        _loc2_.effectsBonuses = !!param1.b ? TacticsEffectsBonuses.fromDtos(param1.b) : [];
        _loc2_.activeEffects = !!param1.e ? AllianceTacticsEffect.fromDtos(param1.e) : [];
        return _loc2_;
    }

    public function get hasActiveEffects():Boolean {
        return query(this.activeEffects).any(function (param1:AllianceTacticsEffect):Boolean {
            return param1.toTime.time >= ServerTimeManager.serverTimeNow.time;
        });
    }
}
}
