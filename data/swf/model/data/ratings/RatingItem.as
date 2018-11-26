package model.data.ratings {
import common.ArrayCustom;

public class RatingItem {


    public var UserId:Number;

    public var ObjId:Number;

    public var Points:Number;

    public var Tag:int;

    public function RatingItem() {
        super();
    }

    public static function fromDto(param1:*):RatingItem {
        var _loc2_:RatingItem = new RatingItem();
        _loc2_.UserId = Number(param1.u);
        _loc2_.ObjId = param1.o == null ? Number(-1) : Number(param1.o);
        _loc2_.Points = param1.p;
        _loc2_.Tag = param1.c;
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return null;
        }
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:RatingItem = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        if (this == null) {
            return null;
        }
        var _loc1_:* = {
            "u": this.UserId,
            "o": this.ObjId,
            "p": this.Points
        };
        return _loc1_;
    }
}
}
