package model.data.effects {
import common.ArrayCustom;

import model.logic.blackMarketItems.EffectInfo;

public class LightEffectItem {


    public var ownerUserId:Number;

    public var effectTypeId:int;

    public var until:Date;

    public var power:Number;

    public var source:int;

    public var periodicAction:PeriodicEffectActionStateLight;

    public var usageCount:int;

    public var sourceItemId:int;

    public function LightEffectItem() {
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

    public static function fromDto(param1:*):LightEffectItem {
        var _loc2_:LightEffectItem = new LightEffectItem();
        _loc2_.ownerUserId = param1.o;
        _loc2_.effectTypeId = param1.t;
        _loc2_.until = new Date(param1.d);
        _loc2_.power = param1.v == null ? Number(0) : Number(param1.v);
        _loc2_.source = param1.s == null ? int(EffectSource.NONE) : int(param1.s);
        _loc2_.periodicAction = param1.p == null ? null : PeriodicEffectActionStateLight.fromDto(param1.p);
        _loc2_.usageCount = param1.u;
        _loc2_.sourceItemId = param1.i;
        return _loc2_;
    }

    public function toEffectInfo():EffectInfo {
        var _loc1_:EffectInfo = new EffectInfo();
        _loc1_.effectTypeId = this.effectTypeId;
        _loc1_.power = this.power;
        _loc1_.timeSeconds = 0;
        if (this.periodicAction != null) {
            _loc1_.periodicAction = this.periodicAction.actionInfo;
        }
        return _loc1_;
    }
}
}
