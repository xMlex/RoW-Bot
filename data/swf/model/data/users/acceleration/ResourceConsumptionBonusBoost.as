package model.data.users.acceleration {
import common.ArrayCustom;

public class ResourceConsumptionBonusBoost {


    public var typeId:int;

    public var source:int;

    public var behaviorType:int;

    public var boostPercentage:int;

    public var until:Date;

    public function ResourceConsumptionBonusBoost() {
        super();
    }

    public static function fromDto(param1:*):ResourceConsumptionBonusBoost {
        var _loc2_:ResourceConsumptionBonusBoost = new ResourceConsumptionBonusBoost();
        _loc2_.typeId = param1.t;
        _loc2_.source = param1.s != null ? int(param1.s) : -1;
        _loc2_.behaviorType = param1.b != null ? int(param1.b) : -1;
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
        var _loc3_:ResourceConsumptionBonusBoost = null;
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
        if (this.source != -1) {
            _loc1_.s = this.source;
        }
        if (this.behaviorType != -1) {
            _loc1_.b = this.behaviorType;
        }
        return _loc1_;
    }
}
}
