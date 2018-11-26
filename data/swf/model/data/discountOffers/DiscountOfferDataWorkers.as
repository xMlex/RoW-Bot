package model.data.discountOffers {
public class DiscountOfferDataWorkers {


    public var enabled:Boolean;

    public function DiscountOfferDataWorkers() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataWorkers {
        var _loc2_:DiscountOfferDataWorkers = new DiscountOfferDataWorkers();
        _loc2_.enabled = param1.e == null ? false : Boolean(param1.e);
        return _loc2_;
    }
}
}
