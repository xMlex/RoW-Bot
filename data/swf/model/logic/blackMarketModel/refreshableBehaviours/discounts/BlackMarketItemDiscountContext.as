package model.logic.blackMarketModel.refreshableBehaviours.discounts {
import model.data.globalEvent.StaticDiscountTypeId;
import model.logic.discountOffers.UserDiscountOfferManager;
import model.logic.staticDiscount.StaticDiscountManager;

public class BlackMarketItemDiscountContext extends DiscountContextBase {


    private var _itemId:int;

    public function BlackMarketItemDiscountContext(param1:int) {
        super();
        this._itemId = param1;
    }

    override public function refresh():void {
        var _loc1_:Number = NaN;
        _loc1_ = StaticDiscountManager.getDiscountValueByTypeId(StaticDiscountTypeId.fromBlackMarketItemTypeId(this._itemId));
        _discount = !!_loc1_ ? Number(_loc1_) : Number(UserDiscountOfferManager.discountBlackMarketItems(this._itemId));
        _haveDiscount = _discount > 0;
    }
}
}
