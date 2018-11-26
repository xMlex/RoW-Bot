package model.data.promotionOffers.triggerData {
public class UserPromotionOfferTriggerData {


    private var _triggerType:int;

    public function UserPromotionOfferTriggerData() {
        super();
    }

    public static function fromDto(param1:*):UserPromotionOfferTriggerData {
        var _loc2_:UserPromotionOfferTriggerData = new UserPromotionOfferTriggerData();
        _loc2_._triggerType = param1.t;
        return _loc2_;
    }

    public function get triggerType():int {
        return this._triggerType;
    }
}
}
