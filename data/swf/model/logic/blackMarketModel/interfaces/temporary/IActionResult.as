package model.logic.blackMarketModel.interfaces.temporary {
public interface IActionResult {


    function onResult(param1:Function):IActionResult;

    function onFault(param1:Function):IActionResult;

    function invokeAction():void;
}
}
