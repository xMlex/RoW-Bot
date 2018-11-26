package model.data.users.troops {
import common.ArrayCustom;

import model.data.Resources;

public class IntelligenceResult {


    public var troopsInSector:Troops;

    public var troopsInBunker:Troops;

    public var resources:Resources;

    public function IntelligenceResult() {
        super();
    }

    public static function fromDto(param1:*):IntelligenceResult {
        var _loc2_:IntelligenceResult = new IntelligenceResult();
        _loc2_.troopsInSector = param1.i == null ? null : Troops.fromDto(param1.i);
        _loc2_.troopsInBunker = param1.b == null ? null : Troops.fromDto(param1.b);
        _loc2_.resources = param1.c == null ? null : Resources.fromDto(param1.c);
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
        var _loc3_:IntelligenceResult = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": (this.troopsInSector == null ? null : this.troopsInSector.toDto()),
            "b": (this.troopsInBunker == null ? null : this.troopsInBunker.toDto()),
            "c": (this.resources == null ? null : this.resources.toDto())
        };
        return _loc1_;
    }
}
}
