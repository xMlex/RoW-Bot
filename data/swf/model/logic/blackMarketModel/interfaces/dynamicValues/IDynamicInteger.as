package model.logic.blackMarketModel.interfaces.dynamicValues {
import model.logic.blackMarketModel.interfaces.temporary.IRefreshable;

public interface IDynamicInteger extends IRefreshable, IDynamicState {


    function get value():int;
}
}
