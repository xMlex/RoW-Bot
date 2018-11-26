package model.logic.commands.complexCommand {
import model.logic.commands.BaseCmd;
import model.logic.commands.complexCommand.abstract.IOrderHandler;

public class BaseCmdWrapper implements IOrderHandler {


    private var _baseCmd:BaseCmd;

    private var _finallyCallback:Function;

    private var _needSendCmd:Boolean;

    private var _nextWrapper:IOrderHandler;

    public function BaseCmdWrapper(param1:BaseCmd, param2:Boolean) {
        super();
        this._baseCmd = param1;
        this._needSendCmd = param2;
    }

    public function set finallyCallback(param1:Function):void {
        this._finallyCallback = param1;
    }

    public function get finallyCallback():Function {
        return this._finallyCallback;
    }

    public function get nextWrapper():IOrderHandler {
        return this._nextWrapper;
    }

    public function set nextWrapper(param1:IOrderHandler):void {
        this._nextWrapper = param1;
    }

    public function handlerRequest():void {
        if (this._needSendCmd) {
            this._baseCmd.ifResult(this.ifResult).execute();
        }
        else {
            this.ifResult();
        }
    }

    private function ifResult():void {
        if (this._nextWrapper != null) {
            this._nextWrapper.handlerRequest();
        }
        else {
            this._finallyCallback();
        }
    }
}
}
