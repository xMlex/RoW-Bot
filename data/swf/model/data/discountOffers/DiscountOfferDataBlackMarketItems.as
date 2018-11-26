package model.data.discountOffers {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class DiscountOfferDataBlackMarketItems {


    public var typeIds:ArrayCustom;

    public var typeIdsDic:Dictionary;

    public function DiscountOfferDataBlackMarketItems() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataBlackMarketItems {
        var _loc4_:int = 0;
        var _loc2_:DiscountOfferDataBlackMarketItems = new DiscountOfferDataBlackMarketItems();
        _loc2_.typeIds = param1.t == null ? new ArrayCustom() : new ArrayCustom(param1.t);
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
