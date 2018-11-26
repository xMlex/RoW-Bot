package model.data.alliances.membership {
import common.ArrayCustom;

public class AllianceMemberState {


    public var date:Date;

    public var stateId:int;

    public var stateComment:String;

    public function AllianceMemberState() {
        super();
    }

    public static function fromDto(param1:*):AllianceMemberState {
        var _loc2_:AllianceMemberState = new AllianceMemberState();
        _loc2_.date = param1.d == null ? null : new Date(param1.d);
        _loc2_.stateId = param1.s;
        _loc2_.stateComment = param1.c;
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
        var _loc3_:AllianceMemberState = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "d": (this.date == null ? null : this.date.time),
            "s": this.stateId,
            "c": this.stateComment
        };
        return _loc1_;
    }
}
}
