package model.data.discountOffers {
public class DiscountOfferDataInstantUnitReturn {


    public var enabled:Boolean;

    public function DiscountOfferDataInstantUnitReturn() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataInstantUnitReturn {
        var _loc2_:DiscountOfferDataInstantUnitReturn = new DiscountOfferDataInstantUnitReturn();
        _loc2_.enabled = param1.e == null ? false : Boolean(param1.e);
        return _loc2_;
    }
}
}
