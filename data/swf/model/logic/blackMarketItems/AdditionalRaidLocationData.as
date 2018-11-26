package model.logic.blackMarketItems {
import common.ArrayCustom;

public class AdditionalRaidLocationData {


    public var kindId:int;

    public var count:int;

    public function AdditionalRaidLocationData() {
        super();
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function fromDto(param1:*):AdditionalRaidLocationData {
        var _loc2_:AdditionalRaidLocationData = new AdditionalRaidLocationData();
        _loc2_.kindId = param1.k;
        _loc2_.count = param1.c;
        return _loc2_;
    }
}
}
