package model.data.effects {
public class PeriodicEffectActionState {


    public var actionInfo:EffectPeriodicActionInfo;

    public var nextActionTime:Date;

    public function PeriodicEffectActionState() {
        super();
    }

    public static function fromDto(param1:*):PeriodicEffectActionState {
        if (param1 == null) {
            return null;
        }
        var _loc2_:PeriodicEffectActionState = new PeriodicEffectActionState();
        _loc2_.actionInfo = EffectPeriodicActionInfo.fromDto(param1.a);
        _loc2_.nextActionTime = param1.l == null ? null : new Date(param1.l);
        return _loc2_;
    }
}
}
