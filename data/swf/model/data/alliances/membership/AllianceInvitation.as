package model.data.alliances.membership {
import common.ArrayCustom;

public class AllianceInvitation {


    public var userId:Number;

    public var inviterUserId:Number;

    public var date:Date;

    public function AllianceInvitation() {
        super();
    }

    public static function fromDto(param1:*):AllianceInvitation {
        var _loc2_:AllianceInvitation = new AllianceInvitation();
        _loc2_.userId = param1.u;
        _loc2_.inviterUserId = param1.i;
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
        var _loc3_:AllianceInvitation = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "u": this.userId,
            "i": this.inviterUserId,
            "d": (this.date == null ? null : this.date.time)
        };
        return _loc1_;
    }
}
}
