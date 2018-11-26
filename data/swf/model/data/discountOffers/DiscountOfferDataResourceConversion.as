package model.data.discountOffers {
import common.ArrayCustom;

public class DiscountOfferDataResourceConversion {


    public var conversionJobTypes:ArrayCustom;

    public function DiscountOfferDataResourceConversion() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataResourceConversion {
        var _loc2_:DiscountOfferDataResourceConversion = new DiscountOfferDataResourceConversion();
        _loc2_.conversionJobTypes = param1.t == null ? new ArrayCustom() : new ArrayCustom(param1.t);
        return _loc2_;
    }
}
}
