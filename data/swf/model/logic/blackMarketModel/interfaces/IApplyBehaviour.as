package model.logic.blackMarketModel.interfaces {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.interfaces.temporary.IDelayActionInvoker;

public interface IApplyBehaviour extends IDelayActionInvoker {


    function prepareApply(param1:int, param2:ApplyContext):void;
}
}
