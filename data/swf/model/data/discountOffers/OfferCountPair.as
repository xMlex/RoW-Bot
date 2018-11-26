package model.data.discountOffers {
import common.ArrayCustom;

public class OfferCountPair {


    public var discountOfferId:Number;

    public var count:int;

    public function OfferCountPair() {
        super();
    }

    public static function fromDto(param1:*):OfferCountPair {
        var _loc2_:OfferCountPair = new OfferCountPair();
        _loc2_.discountOfferId = param1.i == null ? Number(-1) : Number(param1.i);
        _loc2_.count = param1.c == null ? 0 : int(param1.c);
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
