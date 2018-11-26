package model.logic.blackMarketModel.interfaces {
import model.logic.blackMarketModel.interfaces.temporary.IRefreshable;

public interface IDiscountContext extends IRefreshable {


    function get value():Number;

    function get haveDiscount():Boolean;
}
}
