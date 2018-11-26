package model.logic.blackMarketModel.refreshableBehaviours.discounts {
import model.logic.discountOffers.UserDiscountOfferManager;

public class SaleConsumptionDiscountContext extends DiscountContextBase {


    private var _itemId:int;

    public function SaleConsumptionDiscountContext(param1:int) {
        super();
        this._itemId = param1;
    }

    override public function refresh():void {
        _discount = UserDiscountOfferManager.discountBoost(this._itemId);
        _haveDiscount = _discount > 0;
    }
}
}
