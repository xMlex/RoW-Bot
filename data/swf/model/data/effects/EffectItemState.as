package model.data.effects {
import common.TimeSpan;

public class EffectItemState {


    public var id:Number;

    public var until:Date;

    public var power:Number;

    public var state:int;

    public var blackMarketItemTypeId:int;

    public var lifeTime:TimeSpan;

    public var periodicEffectActionState:PeriodicEffectActionState;

    public var usageCount:int;

    public function EffectItemState() {
        super();
    }

    public static function fromDto(param1:*):EffectItemState {
        if (param1 == null) {
            return null;
        }
        var _loc2_:EffectItemState = new EffectItemState();
        _loc2_.id = param1.i;
        _loc2_.blackMarketItemTypeId = param1.c;
        _loc2_.state = param1.s;
        _loc2_.until = new Date(param1.d);
        _loc2_.power = param1.v == null ? Number(0) : Number(param1.v);
        _loc2_.lifeTime = param1.l == null ? null : TimeSpan.fromDto(param1.l);
        _loc2_.periodicEffectActionState = PeriodicEffectActionState.fromDto(param1.p);
        _loc2_.usageCount = param1.u;
        return _loc2_;
    }
}
}
