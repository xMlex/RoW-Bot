package model.data.promotionOffers.bankPackageData {
public class UserPromotionOfferBankPackageData {


    private var _orderId:int;

    public function UserPromotionOfferBankPackageData() {
        super();
    }

    public static function fromDto(param1:*):UserPromotionOfferBankPackageData {
        var _loc2_:UserPromotionOfferBankPackageData = new UserPromotionOfferBankPackageData();
        _loc2_._orderId = param1.or;
        return _loc2_;
    }

    public function get orderId():int {
        return this._orderId;
    }
}
}
