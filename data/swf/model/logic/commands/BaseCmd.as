package model.logic.commands {
public class BaseCmd {


    protected var _onResult:Function;

    protected var _onFault:Function;

    protected var _onIoFault:Function;

    protected var _onFinally:Function;

    public function BaseCmd() {
        super();
    }

    public function ifResult(param1:Function):BaseCmd {
        this._onResult = param1;
        return this;
    }

    public function ifFault(param1:Function):BaseCmd {
        this._onFault = param1;
        return this;
    }

    public function ifIoFault(param1:Function):BaseCmd {
        this._onIoFault = param1;
        return this;
    }

    public function doFinally(param1:Function):BaseCmd {
        this._onFinally = param1;
        return this;
    }

    public function execute():void {
    }
}
}
