package model.logic.blackMarketModel.services.interfaces {
import model.logic.blackMarketModel.deleteBehaviours.contexts.DeleteContext;
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;

public interface IDeleteService {


    function deleteItem(param1:DeleteContext):IActionResult;

    function tryDeleteItem():IActionResult;
}
}
