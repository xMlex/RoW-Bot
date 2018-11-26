package model.data.acceleration.types {
import common.ArrayCustom;

import model.data.Resources;

public class CaravansCapacityBoostType {


    public var typeId:int;

    public var price:Resources;

    public var period:Number;

    public var boostValue:int;

    public function CaravansCapacityBoostType() {
        super();
    }

    public static function fromDto(param1:*):CaravansCapacityBoostType {
        var _loc2_:CaravansCapacityBoostType = new CaravansCapacityBoostType();
        _loc2_.typeId = param1.i;
        _loc2_.price = Resources.fromDto(param1.r);
        _loc2_.period = param1.p;
        _loc2_.boostValue = param1.b;
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return null;
        }
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
