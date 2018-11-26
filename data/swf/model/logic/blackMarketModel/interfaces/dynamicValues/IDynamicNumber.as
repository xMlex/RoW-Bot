package model.logic.blackMarketModel.interfaces.dynamicValues {
import model.logic.blackMarketModel.interfaces.temporary.IRefreshable;

public interface IDynamicNumber extends IRefreshable {


    function get value():Number;
}
}
