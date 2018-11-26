package model.data.discountOffers {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class DiscountOfferDataSkins {


    public var all:Boolean;

    public var skinTypeIds:ArrayCustom;

    public var skinTypeIdsDic:Dictionary;

    public function DiscountOfferDataSkins() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataSkins {
        var _loc4_:int = 0;
        var _loc2_:DiscountOfferDataSkins = new DiscountOfferDataSkins();
        _loc2_.all = param1.a == null ? false : Boolean(param1.a);
        _loc2_.skinTypeIds = param1.t == null ? new ArrayCustom() : new ArrayCustom(param1.t);
        var _loc3_:Dictionary = new Dictionary();
        if (param1.t) {
            for each(_loc4_ in param1.t) {
                _loc3_[_loc4_] = 1;
            }
            _loc2_.skinTypeIdsDic = _loc3_;
        }
        else {
            _loc2_.skinTypeIdsDic = null;
        }
        return _loc2_;
    }
}
}
