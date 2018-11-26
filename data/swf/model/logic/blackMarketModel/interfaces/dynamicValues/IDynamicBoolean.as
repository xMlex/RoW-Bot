package model.logic.blackMarketModel.interfaces.dynamicValues {
import model.logic.blackMarketModel.interfaces.temporary.IRefreshable;

public interface IDynamicBoolean extends IRefreshable {


    function get value():Boolean;
}
}
