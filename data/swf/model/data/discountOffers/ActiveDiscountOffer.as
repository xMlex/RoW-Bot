package model.data.discountOffers {
import common.ArrayCustom;

public class ActiveDiscountOffer {


    public var id:Number;

    public var segmentId:int;

    public var offerTypeId:int;

    public var validTill:Date;

    public var countLeft:int;

    public function ActiveDiscountOffer() {
        super();
    }

    public static function fromDto(param1:*):ActiveDiscountOffer {
        var _loc2_:ActiveDiscountOffer = new ActiveDiscountOffer();
        _loc2_.id = param1.i == null ? Number(0) : Number(param1.i);
        _loc2_.segmentId = param1.s == null ? 0 : int(param1.s);
        _loc2_.offerTypeId = param1.t == null ? 0 : int(param1.t);
        _loc2_.validTill = param1.v == null ? new Date() : new Date(param1.v);
        _loc2_.countLeft = param1.c == null ? 0 : int(param1.c);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
