package model.data.locations {
import common.ArrayCustom;

public class AntigenMutation {


    public var userId:Number;

    public var date:Date;

    public var antigenSpent:Number;

    public function AntigenMutation() {
        super();
    }

    public static function fromDto(param1:*):AntigenMutation {
        var _loc2_:AntigenMutation = new AntigenMutation();
        _loc2_.userId = param1.u;
        _loc2_.date = new Date(param1.d);
        _loc2_.antigenSpent = param1.a;
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
        var _loc3_:AntigenMutation = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "u": this.userId,
            "d": (this.date == null ? null : this.date.time),
            "a": this.antigenSpent
        };
        return _loc1_;
    }
}
}
