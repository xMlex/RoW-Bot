package model.data.discountOffers {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class DiscountOfferDataDrawings {


    public var all:Boolean;

    public var drawingIds:ArrayCustom;

    public var drawingIdsDic:Dictionary;

    public function DiscountOfferDataDrawings() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataDrawings {
        var _loc4_:int = 0;
        var _loc2_:DiscountOfferDataDrawings = new DiscountOfferDataDrawings();
        _loc2_.all = param1.a == null ? false : Boolean(param1.a);
        _loc2_.drawingIds = param1.d == null ? new ArrayCustom() : new ArrayCustom(param1.d);
        var _loc3_:Dictionary = new Dictionary();
        if (param1.t) {
            for each(_loc4_ in param1.t) {
                _loc3_[_loc4_] = 1;
            }
            _loc2_.drawingIdsDic = _loc3_;
        }
        else {
            _loc2_.drawingIdsDic = null;
        }
        return _loc2_;
    }
}
}
