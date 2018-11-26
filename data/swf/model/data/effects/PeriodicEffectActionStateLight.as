package model.data.effects {
public class PeriodicEffectActionStateLight {


    public var actionInfo:EffectPeriodicActionInfo;

    public function PeriodicEffectActionStateLight() {
        super();
    }

    public static function fromDto(param1:*):PeriodicEffectActionStateLight {
        if (param1 == null) {
            return null;
        }
        var _loc2_:PeriodicEffectActionStateLight = new PeriodicEffectActionStateLight();
        _loc2_.actionInfo = param1.a == null ? null : EffectPeriodicActionInfo.fromDto(param1.a);
        return _loc2_;
    }
}
}
