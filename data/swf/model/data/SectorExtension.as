package model.data {
import common.ArrayCustom;

public class SectorExtension {


    public var sideLength:int;

    public var price:Resources;

    public var requiredFriends:int;

    public var slotIds:ArrayCustom;

    public function SectorExtension() {
        super();
    }

    public static function fromDto(param1:*):SectorExtension {
        var _loc2_:SectorExtension = new SectorExtension();
        _loc2_.sideLength = param1.x;
        _loc2_.price = Resources.fromDto(param1.p);
        _loc2_.requiredFriends = param1.f == null ? 0 : int(param1.f);
        _loc2_.slotIds = param1.s == null ? null : param1.s;
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
        var _loc3_:SectorExtension = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "x": this.sideLength,
            "p": (this.price == null ? null : this.price.toDto()),
            "f": this.requiredFriends,
            "s": (!!this.slotIds ? this.slotIds : null)
        };
        return _loc1_;
    }
}
}
