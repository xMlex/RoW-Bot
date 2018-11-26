package model.logic.blackMarketModel.refreshableBehaviours.discounts {
import model.logic.staticDiscount.StaticDiscountManager;

public class BlackMarketConfigUnitDiscountContext extends DiscountContextBase {


    public function BlackMarketConfigUnitDiscountContext() {
        super();
    }

    override public function refresh():void {
        var _loc1_:int = StaticDiscountManager.blackMarketDiscount;
        _discount = _loc1_ * 0.01;
        _haveDiscount = _discount > 0;
    }
}
}
