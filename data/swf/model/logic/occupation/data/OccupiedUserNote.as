package model.logic.occupation.data {
import common.ArrayCustom;

public class OccupiedUserNote {


    public var userId:Number;

    public var level:int;

    public var lastVisitDate:Date;

    public function OccupiedUserNote() {
        super();
    }

    public static function fromDto(param1:*):OccupiedUserNote {
        var _loc2_:OccupiedUserNote = new OccupiedUserNote();
        _loc2_.userId = param1.i;
        _loc2_.level = param1.l;
        _loc2_.lastVisitDate = new Date(param1.v);
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
        var _loc3_:OccupiedUserNote = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.userId,
            "l": this.level,
            "v": (this.lastVisitDate == null ? null : this.lastVisitDate.time)
        };
        return _loc1_;
    }
}
}
