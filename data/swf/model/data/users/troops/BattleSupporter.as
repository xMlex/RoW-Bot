package model.data.users.troops {
import common.ArrayCustom;

public class BattleSupporter {


    public var userId:Number;

    public var allianceRankId:Number;

    public var troopsInitial:Troops;

    public var troopsLosses:Troops;

    public function BattleSupporter() {
        super();
    }

    public static function fromDto(param1:*):BattleSupporter {
        var _loc2_:BattleSupporter = new BattleSupporter();
        _loc2_.userId = param1.i;
        _loc2_.troopsInitial = param1.t == null ? null : Troops.fromDto(param1.t);
        _loc2_.troopsLosses = param1.l == null ? null : Troops.fromDto(param1.l);
        _loc2_.allianceRankId = param1.r == null ? Number(Number.NaN) : Number(param1.r);
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
        var _loc3_:BattleSupporter = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.userId,
            "t": (this.troopsInitial == null ? null : this.troopsInitial.toDto()),
            "l": (this.troopsLosses == null ? null : this.troopsLosses.toDto()),
            "r": (!!isNaN(this.allianceRankId) ? null : this.allianceRankId)
        };
        return _loc1_;
    }
}
}
