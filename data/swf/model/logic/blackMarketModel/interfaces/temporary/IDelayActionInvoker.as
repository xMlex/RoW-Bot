package model.logic.blackMarketModel.interfaces.temporary {
public interface IDelayActionInvoker extends IInvoker {


    function registerResult(param1:Function):void;

    function registerFault(param1:Function):void;
}
}
