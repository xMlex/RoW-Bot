package model.data.users {
import common.ArrayCustom;

public class DailyResourceFlow {


    public var resources:Number;

    public var date:Date;

    public function DailyResourceFlow() {
        super();
    }

    public static function fromDto(param1:*):DailyResourceFlow {
        var _loc2_:DailyResourceFlow = new DailyResourceFlow();
        _loc2_.resources = param1.r;
        _loc2_.date = param1.d == null ? null : new Date(param1.d);
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
        var _loc3_:DailyResourceFlow = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "r": this.resources,
            "d": (this.date == null ? null : this.date.time)
        };
        return _loc1_;
    }
}
}
