package model.data.users.acceleration {
import common.ArrayCustom;

public class ResourceMiningBoost {


    public var typeId:int;

    public var boostPercentage:int;

    public var until:Date;

    public function ResourceMiningBoost() {
        super();
    }

    public static function fromDto(param1:*):ResourceMiningBoost {
        var _loc2_:ResourceMiningBoost = new ResourceMiningBoost();
        _loc2_.typeId = param1.t;
        _loc2_.boostPercentage = param1.p;
        _loc2_.until = new Date(param1.d);
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
        var _loc3_:ResourceMiningBoost = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "t": this.typeId,
            "p": this.boostPercentage,
            "d": this.until.time
        };
        return _loc1_;
    }
}
}
