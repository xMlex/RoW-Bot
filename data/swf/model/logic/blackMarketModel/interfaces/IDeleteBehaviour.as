package model.logic.blackMarketModel.interfaces {
import model.logic.blackMarketModel.deleteBehaviours.contexts.DeleteContext;
import model.logic.blackMarketModel.interfaces.temporary.IDelayActionInvoker;

public interface IDeleteBehaviour extends IDelayActionInvoker {


    function prepareDelete(param1:int, param2:DeleteContext):void;
}
}
