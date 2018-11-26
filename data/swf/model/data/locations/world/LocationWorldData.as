package model.data.locations.world {
import common.ArrayCustom;

import model.data.units.Unit;

public class LocationWorldData {


    public var units:ArrayCustom;

    public function LocationWorldData() {
        super();
    }

    public static function fromDto(param1:*):LocationWorldData {
        var _loc2_:LocationWorldData = new LocationWorldData();
        _loc2_.units = Unit.fromDtos(param1.u);
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

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:LocationWorldData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {"u": (this.units == null ? null : Unit.toDtos(this.units))};
        return _loc1_;
    }
}
}
