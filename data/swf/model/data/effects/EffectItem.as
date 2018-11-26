package model.data.effects {
import common.ArrayCustom;

import configs.Global;

public class EffectItem {


    public var ownerUserId:Number;

    public var targetUserId:Number;

    public var effectTypeId:int;

    public var activeState:EffectItemState;

    public var nextState:EffectItemState;

    public var finishedState:EffectItemState;

    public var source:int;

    public var sourceItemId:int;

    public function EffectItem() {
        super();
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function fromDto(param1:*):EffectItem {
        var _loc2_:EffectItem = new EffectItem();
        _loc2_.ownerUserId = param1.o;
        _loc2_.targetUserId = param1.z;
        _loc2_.effectTypeId = param1.t;
        _loc2_.activeState = EffectItemState.fromDto(param1.a);
        _loc2_.nextState = EffectItemState.fromDto(param1.n);
        _loc2_.finishedState = EffectItemState.fromDto(param1.f);
        _loc2_.source = int(param1.s);
        _loc2_.sourceItemId = param1.i;
        return _loc2_;
    }

    public function isBMSourced():Boolean {
        if (Global.EFFECT_SOURCE_MODEL_ENABLED) {
            return (this.source & EffectSource.BlackMarketItem) != EffectSource.NONE;
        }
        return true;
    }

    public function toLightEffect():LightEffectItem {
        var _loc1_:LightEffectItem = new LightEffectItem();
        _loc1_.effectTypeId = this.effectTypeId;
        _loc1_.ownerUserId = this.ownerUserId;
        _loc1_.until = !!this.activeState ? this.activeState.until : null;
        _loc1_.power = !!this.activeState ? Number(this.activeState.power) : Number(0);
        return _loc1_;
    }
}
}
