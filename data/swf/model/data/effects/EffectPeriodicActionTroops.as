package model.data.effects {
import model.data.users.troops.Troops;

public class EffectPeriodicActionTroops {


    public var actionTypeId:int;

    public var troops:Troops;

    public function EffectPeriodicActionTroops() {
        super();
    }

    public static function fromDto(param1:*):EffectPeriodicActionTroops {
        if (param1 == null) {
            return null;
        }
        var _loc2_:EffectPeriodicActionTroops = new EffectPeriodicActionTroops();
        _loc2_.actionTypeId = param1.a;
        _loc2_.troops = Troops.fromDto(param1.t);
        return _loc2_;
    }
}
}
