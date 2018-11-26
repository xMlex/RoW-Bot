package model.data.discountOffers {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class DiscountOfferDataBoost {


    public var all:Boolean;

    public var boostTypeIds:ArrayCustom;

    public var typeIdsDic:Dictionary;

    public function DiscountOfferDataBoost() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataBoost {
        var _loc4_:int = 0;
        var _loc2_:DiscountOfferDataBoost = new DiscountOfferDataBoost();
        _loc2_.all = param1.a == null ? false : Boolean(param1.a);
        _loc2_.boostTypeIds = param1.t == null ? new ArrayCustom() : new ArrayCustom(param1.t);
        var _loc3_:Dictionary = new Dictionary();
        if (param1.t) {
            for each(_loc4_ in param1.t) {
                _loc3_[_loc4_] = 1;
            }
            _loc2_.typeIdsDic = _loc3_;
        }
        else {
            _loc2_.typeIdsDic = null;
        }
        return _loc2_;
    }
}
}
