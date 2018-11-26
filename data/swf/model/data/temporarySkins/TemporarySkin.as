package model.data.temporarySkins {
import common.queries.util.query;

import model.data.Resources;
import model.logic.blackMarketItems.EffectInfo;

public class TemporarySkin {


    public var skinTemplateId:int;

    public var skinTypeId:int;

    public var skinEffectInfo:EffectInfo;

    public var price:Resources;

    public var additionalEffectInfos:Array;

    public function TemporarySkin() {
        super();
    }

    public static function fromDto(param1:*):TemporarySkin {
        if (param1 == null) {
            return null;
        }
        var _loc2_:TemporarySkin = new TemporarySkin();
        _loc2_.skinTemplateId = param1.a;
        _loc2_.skinTypeId = param1.i;
        _loc2_.skinEffectInfo = !!param1.c ? EffectInfo.fromDto(param1.c) : null;
        _loc2_.additionalEffectInfos = EffectInfo.fromDtos(param1.e);
        _loc2_.price = Resources.fromDto(param1.p);
        return _loc2_;
    }

    public function clone():TemporarySkin {
        var _loc1_:TemporarySkin = new TemporarySkin();
        _loc1_.skinTemplateId = this.skinTemplateId;
        _loc1_.skinTypeId = this.skinTypeId;
        _loc1_.skinEffectInfo = this.skinEffectInfo;
        _loc1_.additionalEffectInfos = this.additionalEffectInfos.concat();
        return _loc1_;
    }

    public function hasEffect(param1:int):Boolean {
        var effectTypeId:int = param1;
        return this.skinEffectInfo != null && this.skinEffectInfo.effectTypeId == effectTypeId || query(this.additionalEffectInfos).any(function (param1:EffectInfo):Boolean {
            return param1.effectTypeId == effectTypeId;
        });
    }
}
}
