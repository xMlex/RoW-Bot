package model.data.promotionOffers {
public class PromotionOfferPriority {

    private static var _priorityByTypeId:Object = new Object();

    {
        _priorityByTypeId[PromotionOfferTypeId.TRIGGER] = 1;
        _priorityByTypeId[PromotionOfferTypeId.AGGRESSIVE_DISCOUNT] = 2;
        _priorityByTypeId[PromotionOfferTypeId.BANK_PACKAGES] = 3;
        _priorityByTypeId[PromotionOfferTypeId.RETENTION_PACK] = 4;
    }

    public function PromotionOfferPriority() {
        super();
    }

    public static function getPriorityByTypeId(param1:int):int {
        var _loc2_:int = 0;
        if (_priorityByTypeId[param1] != null) {
            _loc2_ = _priorityByTypeId[param1];
        }
        return _loc2_;
    }
}
}
