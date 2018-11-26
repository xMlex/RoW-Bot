package model.data.discountOffers {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class DiscountOfferDataResurrection {


    public var all:Boolean;

    public var allStrategies:Boolean;

    public var allGold:Boolean;

    public var groupId:int;

    public var kindId:int;

    public var typeIds:ArrayCustom;

    public var typeIdsDic:Dictionary;

    public function DiscountOfferDataResurrection() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataResurrection {
        var _loc4_:int = 0;
        var _loc2_:DiscountOfferDataResurrection = new DiscountOfferDataResurrection();
        _loc2_.all = param1.a == null ? false : Boolean(param1.a);
        _loc2_.allStrategies = param1.s == null ? false : Boolean(param1.s);
        _loc2_.allGold = param1.e == null ? false : Boolean(param1.e);
        _loc2_.groupId = param1.g == null ? -1 : int(param1.g);
        _loc2_.kindId = param1.k == null ? -1 : int(param1.k);
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
