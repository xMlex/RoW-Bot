package model.logic.blackMarketModel.services.interfaces {
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;

public interface IBuyService {


    function buy(param1:BuyContext):IActionResult;

    function tryBuy():IActionResult;
}
}
