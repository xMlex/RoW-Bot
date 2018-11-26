package model.data.discountOffers {
public class DiscountOfferDataSectorExtension {


    public var sizeNewLowerBound:int;

    public var sizeNewUpperBound:int;

    public var allSlotsExtension:Boolean;

    public function DiscountOfferDataSectorExtension() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataSectorExtension {
        var _loc2_:DiscountOfferDataSectorExtension = new DiscountOfferDataSectorExtension();
        _loc2_.sizeNewLowerBound = param1.l == null ? 0 : int(param1.l);
        _loc2_.sizeNewUpperBound = param1.u == null ? 0 : int(param1.u);
        _loc2_.allSlotsExtension = param1.a == null ? false : Boolean(param1.a);
        return _loc2_;
    }
}
}
