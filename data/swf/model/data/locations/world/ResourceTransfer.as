package model.data.locations.world {
import common.ArrayCustom;

import model.data.Resources;

public class ResourceTransfer {


    public var userId:Number;

    public var date:Date;

    public var resources:Resources;

    public function ResourceTransfer() {
        super();
    }

    public static function fromDto(param1:*):ResourceTransfer {
        var _loc2_:ResourceTransfer = new ResourceTransfer();
        _loc2_.userId = param1.u;
        _loc2_.date = new Date(param1.d);
        _loc2_.resources = Resources.fromDto(param1.r);
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
        var _loc3_:ResourceTransfer = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "u": this.userId,
            "d": (this.date == null ? null : this.date.time),
            "r": this.resources.toDto()
        };
        return _loc1_;
    }
}
}
