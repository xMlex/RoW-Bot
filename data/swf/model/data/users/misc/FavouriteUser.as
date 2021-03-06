package model.data.users.misc {
import common.ArrayCustom;

public class FavouriteUser {


    public var userId:Number;

    public var typeId:int;

    public var comment:String;

    public var addDate:Date;

    public function FavouriteUser() {
        super();
    }

    public static function fromDto(param1:*):FavouriteUser {
        var _loc2_:FavouriteUser = new FavouriteUser();
        _loc2_.userId = param1.u;
        _loc2_.typeId = param1.t;
        _loc2_.comment = param1.c;
        if (param1.d) {
            _loc2_.addDate = new Date(param1.d);
        }
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
        var _loc3_:FavouriteUser = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "u": this.userId,
            "t": this.typeId,
            "c": this.comment,
            "d": (this.addDate == null ? null : this.addDate.time)
        };
        return _loc1_;
    }
}
}
