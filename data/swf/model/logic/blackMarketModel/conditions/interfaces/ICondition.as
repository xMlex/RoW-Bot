package model.logic.blackMarketModel.conditions.interfaces {
import model.logic.blackMarketModel.interfaces.temporary.IDelayActionInvoker;

public interface ICondition extends IDelayActionInvoker {


    function check():Boolean;

    function invokeHandler():void;
}
}
