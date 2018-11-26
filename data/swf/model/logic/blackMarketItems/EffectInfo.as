package model.logic.blackMarketItems {
import model.data.effects.EffectItem;
import model.data.effects.EffectItemState;
import model.data.effects.EffectPeriodicActionInfo;
import model.data.effects.PeriodicEffectActionState;

public class EffectInfo {


    public var effectTypeId:int;

    public var timeSeconds:Number;

    public var power:Number;

    public var targetType:uint;

    public var periodicAction:EffectPeriodicActionInfo;

    public function EffectInfo() {
        super();
    }

    public static function fromDto(param1:*):EffectInfo {
        var _loc2_:EffectInfo = new EffectInfo();
        _loc2_.effectTypeId = param1.e;
        _loc2_.timeSeconds = param1.d;
        _loc2_.power = param1.p == null ? Number(0) : Number(param1.p);
        _loc2_.targetType = param1.t;
        _loc2_.periodicAction = EffectPeriodicActionInfo.fromDto(param1.a);
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return new Array();
        }
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function toEffectItem():EffectItem {
        var _loc1_:EffectItem = new EffectItem();
        _loc1_.effectTypeId = this.effectTypeId;
        _loc1_.activeState = new EffectItemState();
        _loc1_.activeState.power = this.power;
        if (this.periodicAction != null) {
            _loc1_.activeState.periodicEffectActionState = new PeriodicEffectActionState();
            _loc1_.activeState.periodicEffectActionState.actionInfo = this.periodicAction;
        }
        return _loc1_;
    }
}
}
