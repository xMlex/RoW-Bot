package model.data.alliances {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class WarStatisticsValue {


    public var type:int;

    public var currentAllianceValue:Number;

    public var oppositeAllianceValue:Number;

    public var currentAllianceValueByUsers:Dictionary;

    public var oppositeAllianceValueByUsers:Dictionary;

    public function WarStatisticsValue() {
        this.currentAllianceValueByUsers = new Dictionary();
        this.oppositeAllianceValueByUsers = new Dictionary();
        super();
    }

    public static function fromDto(param1:*):WarStatisticsValue {
        var _loc3_:* = undefined;
        var _loc2_:WarStatisticsValue = new WarStatisticsValue();
        _loc2_.type = param1.t;
        _loc2_.currentAllianceValue = param1.c;
        _loc2_.oppositeAllianceValue = param1.o;
        if (param1.cu != null) {
            _loc2_.currentAllianceValueByUsers = new Dictionary();
            for (_loc3_ in param1.cu) {
                _loc2_.currentAllianceValueByUsers[_loc3_] = param1.cu[_loc3_];
            }
        }
        if (param1.ou) {
            _loc2_.oppositeAllianceValueByUsers = new Dictionary();
            for (_loc3_ in param1.ou) {
                _loc2_.oppositeAllianceValueByUsers[_loc3_] = param1.ou[_loc3_];
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
