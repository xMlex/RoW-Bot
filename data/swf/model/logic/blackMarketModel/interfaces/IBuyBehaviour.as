package model.logic.blackMarketModel.interfaces {
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.blackMarketModel.interfaces.temporary.IDelayActionInvoker;

public interface IBuyBehaviour extends IDelayActionInvoker {


    function prepareBuy(param1:int, param2:BuyContext):void;
}
}
