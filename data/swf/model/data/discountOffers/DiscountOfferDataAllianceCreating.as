package model.data.discountOffers {
public class DiscountOfferDataAllianceCreating {


    public var enabled:Boolean;

    public function DiscountOfferDataAllianceCreating() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataAllianceCreating {
        var _loc2_:DiscountOfferDataAllianceCreating = new DiscountOfferDataAllianceCreating();
        _loc2_.enabled = param1.e == null ? false : Boolean(param1.e);
        return _loc2_;
    }
}
}
