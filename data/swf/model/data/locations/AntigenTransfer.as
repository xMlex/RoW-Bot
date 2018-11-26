package model.data.locations {
import common.ArrayCustom;

public class AntigenTransfer {


    public var userId:Number;

    public var date:Date;

    public var antigenSent:Number;

    public var targetTowerId:Number;

    public var sourceTowerId:Number;

    public function AntigenTransfer() {
        super();
    }

    public static function fromDto(param1:*):AntigenTransfer {
        var _loc2_:AntigenTransfer = new AntigenTransfer();
        _loc2_.userId = param1.u;
        _loc2_.date = new Date(param1.d);
        _loc2_.antigenSent = param1.a;
        _loc2_.sourceTowerId = param1.s;
        _loc2_.targetTowerId = param1.t;
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
        var _loc3_:AntigenTransfer = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "u": this.userId,
            "d": this.date.time,
            "a": this.antigenSent,
            "s": this.sourceTowerId,
            "t": this.targetTowerId
        };
        return _loc1_;
    }
}
}
