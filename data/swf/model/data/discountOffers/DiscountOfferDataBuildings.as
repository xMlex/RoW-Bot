package model.data.discountOffers {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class DiscountOfferDataBuildings {


    public var all:Boolean;

    public var allPerimeter:Boolean;

    public var groupId:int;

    public var decorTypes:ArrayCustom;

    public var defensiveKind:int;

    public var slotKindId:int;

    public var typeIds:ArrayCustom;

    public var typeIdsDic:Dictionary;

    public function DiscountOfferDataBuildings() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataBuildings {
        var _loc4_:int = 0;
        var _loc2_:DiscountOfferDataBuildings = new DiscountOfferDataBuildings();
        _loc2_.all = param1.a == null ? false : Boolean(param1.a);
        _loc2_.allPerimeter = param1.p == null ? false : Boolean(param1.p);
        _loc2_.groupId = param1.g == null ? -1 : int(param1.g);
        _loc2_.decorTypes = param1.e == null ? null : new ArrayCustom(param1.e);
        _loc2_.defensiveKind = param1.d == null ? -1 : int(param1.d);
        _loc2_.slotKindId = param1.s == null ? -1 : int(param1.s);
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
