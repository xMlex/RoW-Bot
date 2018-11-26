package model.data.raids {
import common.ArrayCustom;

import model.data.Resources;
import model.data.users.troops.Troops;

public class RaidResult {


    public var locationStrengthLeft:Number;

    public var resourcesFound:Resources;

    public var resourcesTaken:Resources;

    public var troops:Troops;

    public var questBonus:Number;

    public var questPrototypeId:int;

    public var skillPoints:int;

    public function RaidResult() {
        super();
    }

    public static function fromDto(param1:*):RaidResult {
        var _loc2_:RaidResult = new RaidResult();
        _loc2_.locationStrengthLeft = param1.s == null ? Number(Number.NaN) : Number(param1.s);
        _loc2_.resourcesFound = param1.e == null ? null : Resources.fromDto(param1.e);
        _loc2_.resourcesTaken = param1.r == null ? null : Resources.fromDto(param1.r);
        _loc2_.troops = param1.f == null ? null : Troops.fromDto(param1.f);
        _loc2_.questBonus = param1.g == null ? Number(0) : Number(param1.g);
        _loc2_.questPrototypeId = param1.q == null ? 50001 : int(param1.q);
        _loc2_.skillPoints = param1.p == null ? 0 : int(param1.p);
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
}
}
