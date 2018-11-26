package model.data.units.payloads {
import common.ArrayCustom;

import model.data.users.troops.Troops;

public class SupportTroops {


    public var ownerUserId:Number;

    public var troops:Troops;

    public function SupportTroops() {
        super();
    }

    public static function fromDto(param1:*):SupportTroops {
        var _loc2_:SupportTroops = new SupportTroops();
        _loc2_.ownerUserId = param1.o;
        _loc2_.troops = Troops.fromDto(param1.t);
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
        var _loc3_:SupportTroops = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "o": this.ownerUserId,
            "t": (this.troops == null ? null : this.troops.toDto())
        };
        return _loc1_;
    }
}
}
