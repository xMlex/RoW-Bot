package model.logic.jscommands {
import flash.external.ExternalInterface;

public class JSCallCmd {


    private var _methodName:String;

    private var _methodParams;

    protected var _onResult:Function;

    protected var _onFault:Function;

    public function JSCallCmd(param1:String, param2:*) {
        super();
        this._methodName = param1;
        this._methodParams = param2;
    }

    public function ifResult(param1:Function):JSCallCmd {
        this._onResult = param1;
        return this;
    }

    public function ifFault(param1:Function):JSCallCmd {
        this._onFault = param1;
        return this;
    }

    public function call():JSCallCmd {
        var answer:* = undefined;
        if (!ExternalInterface.available) {
            return this;
        }
        if (this._methodParams is Function) {
            try {
                ExternalInterface.addCallback(this._methodName, this._methodParams);
            }
            catch (error:Error) {
                _onFault();
            }
        }
        else {
            this._methodParams.unshift(this._methodName);
            try {
                ExternalInterface.call(this._methodName);
                if (this._onResult != null) {
                    this._onResult();
                }
            }
            catch (error:Error) {
                if (_onFault != null) {
                    _onFault();
                }
            }
        }
        return this;
    }
}
}
