package model.data.acceleration.types {
import common.ArrayCustom;

import model.data.Resources;

public class ResourceMiningBoostType {


    public var boostTypeId:int;

    public var percentage:int;

    public var price:Resources;

    public var period:Number;

    public function ResourceMiningBoostType() {
        super();
    }

    public static function fromDto(param1:*):ResourceMiningBoostType {
        var _loc2_:ResourceMiningBoostType = new ResourceMiningBoostType();
        _loc2_.boostTypeId = param1.t;
        _loc2_.percentage = param1.s;
        _loc2_.price = Resources.fromDto(param1.r);
        _loc2_.period = param1.p;
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
