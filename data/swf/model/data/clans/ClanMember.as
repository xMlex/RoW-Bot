package model.data.clans {
import common.ArrayCustom;

public class ClanMember {

    public static const State_Normal:int = 0;

    public static const State_Invited:int = 1;


    public var userId:Number;

    public var state:int = 0;

    public var receiveBattleReports:Boolean = false;

    public function ClanMember() {
        super();
    }

    public static function fromDto(param1:*):ClanMember {
        var _loc2_:ClanMember = new ClanMember();
        _loc2_.userId = param1.u;
        _loc2_.state = param1.s;
        _loc2_.receiveBattleReports = param1.b;
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
