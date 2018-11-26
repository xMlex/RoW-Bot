package model.logic.blackMarketModel.temporaryCore {
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;

public class StubActionResult implements IActionResult {


    public function StubActionResult() {
        super();
    }

    public function onResult(param1:Function):IActionResult {
        return this;
    }

    public function onFault(param1:Function):IActionResult {
        return this;
    }

    public function invokeAction():void {
    }
}
}
