package model.logic.blackMarketModel.interfaces.dynamicValues {
import model.logic.blackMarketModel.interfaces.temporary.IRefreshable;

public interface IDynamicObject extends IRefreshable, IDynamicState {


    function get value():Object;
}
}
