package model.logic.blackMarketModel.temporaryCore {
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;
import model.logic.blackMarketModel.interfaces.temporary.IDelayActionInvoker;

public class ActionResult implements IActionResult {


    private var _actionInvoker:IDelayActionInvoker;

    public function ActionResult(param1:IDelayActionInvoker) {
        super();
        this._actionInvoker = param1;
    }

    public function onResult(param1:Function):IActionResult {
        this._actionInvoker.registerResult(param1);
        return this;
    }

    public function onFault(param1:Function):IActionResult {
        this._actionInvoker.registerFault(param1);
        return this;
    }

    public function invokeAction():void {
        this._actionInvoker.invoke();
    }
}
}
