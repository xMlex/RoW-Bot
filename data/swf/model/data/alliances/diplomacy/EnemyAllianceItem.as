package model.data.alliances.diplomacy {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class EnemyAllianceItem {


    public var memberIds:ArrayCustom;

    public var usersByStatsType:Dictionary;

    public function EnemyAllianceItem() {
        super();
    }

    public static function fromDto(param1:*):EnemyAllianceItem {
        var _loc3_:* = undefined;
        var _loc4_:Dictionary = null;
        var _loc5_:* = undefined;
        var _loc2_:EnemyAllianceItem = new EnemyAllianceItem();
        _loc2_.memberIds = new ArrayCustom(param1.u);
        if (param1.s != null) {
            _loc2_.usersByStatsType = new Dictionary();
            for (_loc3_ in param1.s) {
                _loc4_ = new Dictionary();
                for (_loc5_ in param1.s[_loc3_]) {
                    _loc4_[_loc5_] = param1.s[_loc3_][_loc5_];
                }
                _loc2_.usersByStatsType[_loc3_] = _loc4_;
            }
        }
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
