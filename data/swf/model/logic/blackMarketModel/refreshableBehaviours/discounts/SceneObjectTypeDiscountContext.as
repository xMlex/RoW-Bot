package model.logic.blackMarketModel.refreshableBehaviours.discounts {
import model.logic.discountOffers.UserDiscountOfferManager;

public class SceneObjectTypeDiscountContext extends DiscountContextBase {


    private var _itemId:int;

    public function SceneObjectTypeDiscountContext(param1:int) {
        super();
        this._itemId = param1;
    }

    override public function refresh():void {
        _discount = UserDiscountOfferManager.getDiscountCoefficient(this._itemId);
        _haveDiscount = _discount > 0;
    }
}
}
