package model.data.discountOffers {
public class DiscountOfferDataTowerUpgrade {


    public var towerLevelFrom:int;

    public var towerLevelTo:int;

    public function DiscountOfferDataTowerUpgrade() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferDataTowerUpgrade {
        var _loc2_:DiscountOfferDataTowerUpgrade = new DiscountOfferDataTowerUpgrade();
        _loc2_.towerLevelFrom = param1.f == null ? 0 : int(param1.f);
        _loc2_.towerLevelTo = param1.t == null ? 0 : int(param1.t);
        return _loc2_;
    }
}
}
