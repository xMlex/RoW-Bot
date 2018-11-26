package model.data.discountOffers {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class DiscountOfferDataResourceKits {


    public var all:Boolean;

    public var kitIds:ArrayCustom;

    public var kitIdsDic:Dictionary;

    public var resourceTypeIds:ArrayCustom;

    public var resourceTypeIdsDic:Dictionary;

    public function DiscountOfferDataResourceKits() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataResourceKits {
        var _loc4_:int = 0;
        var _loc2_:DiscountOfferDataResourceKits = new DiscountOfferDataResourceKits();
        _loc2_.all = param1.a == null ? false : Boolean(param1.a);
        _loc2_.kitIds = param1.k == null ? new ArrayCustom() : new ArrayCustom(param1.k);
        var _loc3_:Dictionary = new Dictionary();
        if (param1.k) {
            for each(_loc4_ in param1.k) {
                _loc3_[_loc4_] = 1;
            }
            _loc2_.kitIdsDic = _loc3_;
        }
        else {
            _loc2_.kitIdsDic = null;
        }
        _loc2_.resourceTypeIds = param1.r == null ? new ArrayCustom() : new ArrayCustom(param1.r);
        var _loc5_:Dictionary = new Dictionary();
        if (param1.r) {
            for each(_loc4_ in param1.r) {
                _loc5_[_loc4_] = 1;
            }
            _loc2_.resourceTypeIdsDic = _loc5_;
        }
        else {
            _loc2_.resourceTypeIdsDic = null;
        }
        return _loc2_;
    }
}
}
