package model.logic.blackMarketModel.interfaces.dynamicValues {
import model.logic.blackMarketModel.interfaces.temporary.IRefreshable;

public interface IDynamicString extends IRefreshable {


    function get value():String;
}
}
