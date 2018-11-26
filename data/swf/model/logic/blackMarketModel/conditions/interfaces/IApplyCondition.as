package model.logic.blackMarketModel.conditions.interfaces {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;

public interface IApplyCondition extends ICondition {


    function setContext(param1:ApplyContext):void;
}
}
