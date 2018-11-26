package model.data.alliances.membership {
import common.ArrayCustom;

public class AllianceRequest {


    public var userId:Number;

    public var date:Date;

    public function AllianceRequest() {
        super();
    }

    public static function fromDto(param1:*):AllianceRequest {
        var _loc2_:AllianceRequest = new AllianceRequest();
        _loc2_.userId = param1.i;
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
        var _loc3_:AllianceRequest = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.userId,
            "d": (this.date == null ? null : this.date.time)
        };
        return _loc1_;
    }
}
}
