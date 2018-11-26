package model.logic.blackMarketModel.refreshableBehaviours.discounts {
import model.logic.discountOffers.UserDiscountOfferManager;
import model.logic.staticDiscount.StaticDiscountManager;

public class SectorSkinDiscountContext extends DiscountContextBase {


    private var _itemId:int;

    public function SectorSkinDiscountContext(param1:int) {
        super();
        this._itemId = param1;
    }

    override public function refresh():void {
        var _loc1_:Number = NaN;
        _loc1_ = StaticDiscountManager.sectorSkinsDiscount;
        _discount = !!_loc1_ ? Number(_loc1_) : Number(UserDiscountOfferManager.discountSkin(this._itemId));
        _haveDiscount = _discount > 0;
    }
}
}
