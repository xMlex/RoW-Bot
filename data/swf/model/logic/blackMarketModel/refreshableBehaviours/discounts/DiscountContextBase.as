package model.logic.blackMarketModel.refreshableBehaviours.discounts {
import model.logic.blackMarketModel.interfaces.IDiscountContext;

public class DiscountContextBase implements IDiscountContext {


    protected var _discount:Number = 0;

    protected var _haveDiscount:Boolean;

    public function DiscountContextBase() {
        super();
    }

    public function get value():Number {
        return this._discount;
    }

    public function get haveDiscount():Boolean {
        return this._haveDiscount;
    }

    public function refresh():void {
        throw new Error("DiscountContextBase.refresh() не был переопределён в наследнике!");
    }
}
}
