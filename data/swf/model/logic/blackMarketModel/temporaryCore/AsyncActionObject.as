package model.logic.blackMarketModel.temporaryCore {
import model.logic.blackMarketModel.interfaces.temporary.IDelayActionInvoker;

public class AsyncActionObject implements IDelayActionInvoker {


    private var _resultCallback:Function;

    private var _faultCallback:Function;

    public function AsyncActionObject() {
        super();
    }

    protected function dispatchResult():void {
        if (this._resultCallback != null) {
            this._resultCallback();
        }
    }

    protected function dispatchFault():void {
        if (this._faultCallback != null) {
            this._faultCallback();
        }
    }

    public function registerResult(param1:Function):void {
        this._resultCallback = param1;
    }

    public function registerFault(param1:Function):void {
        this._faultCallback = param1;
    }

    public function invoke():void {
    }
}
}
