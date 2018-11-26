package model.data.effects {
import common.TimeSpan;

public class EffectPeriodicActionInfo {


    public var period:TimeSpan;

    public var troopsAction:EffectPeriodicActionTroops;

    public function EffectPeriodicActionInfo() {
        super();
    }

    public static function fromDto(param1:*):EffectPeriodicActionInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:EffectPeriodicActionInfo = new EffectPeriodicActionInfo();
        _loc2_.period = param1.p == null ? null : TimeSpan.fromDto(param1.p);
        _loc2_.troopsAction = EffectPeriodicActionTroops.fromDto(param1.t);
        return _loc2_;
    }
}
}
