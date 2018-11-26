package model.data.users.alliances {
import common.ArrayCustom;

public class UserAllianceRequest {


    public var allianceId:Number;

    public var date:Date;

    public function UserAllianceRequest() {
        super();
    }

    public static function fromDto(param1:*):UserAllianceRequest {
        var _loc2_:UserAllianceRequest = new UserAllianceRequest();
        _loc2_.allianceId = param1.i;
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
        var _loc3_:UserAllianceRequest = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.allianceId,
            "d": (this.date == null ? null : this.date.time)
        };
        return _loc1_;
    }
}
}
