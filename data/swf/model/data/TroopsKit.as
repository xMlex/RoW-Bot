package model.data {
import common.ArrayCustom;

import model.data.users.troops.Troops;

public class TroopsKit {


    public var id:int;

    public var level:int;

    public var price:Resources;

    public var troops:Troops;

    public var attacking:Boolean;

    public function TroopsKit() {
        super();
    }

    public static function fromDto(param1:*):TroopsKit {
        var _loc2_:TroopsKit = new TroopsKit();
        _loc2_.id = param1.i;
        _loc2_.level = param1.l;
        _loc2_.price = Resources.fromDto(param1.p);
        _loc2_.troops = Troops.fromDto(param1.t);
        _loc2_.attacking = param1.a == null ? false : Boolean(param1.a);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return new ArrayCustom();
        }
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:TroopsKit = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.id,
            "l": this.level,
            "p": (this.price == null ? null : this.price.toDto()),
            "t": (this.troops == null ? null : this.troops.toDto()),
            "a": this.attacking
        };
        return _loc1_;
    }
}
}
