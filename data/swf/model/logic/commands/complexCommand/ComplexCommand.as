package model.logic.commands.complexCommand {
import model.logic.commands.complexCommand.abstract.IOrderHandler;

public class ComplexCommand {


    private var _firstHandler:IOrderHandler;

    private var _lastHandler:IOrderHandler;

    private var _finallyCallback:Function;

    private var _rest:Array;

    public function ComplexCommand(param1:Function = null, ...rest) {
        super();
        this._finallyCallback = param1;
        this._rest = rest;
    }

    public function execute():void {
        if (this._firstHandler != null) {
            this._firstHandler.handlerRequest();
        }
    }

    public function addNextIOHandler(param1:IOrderHandler):void {
        if (this._firstHandler == null) {
            this._firstHandler = param1;
            this._firstHandler.finallyCallback = this.callback;
        }
        if (this._lastHandler == null) {
            this._lastHandler = param1;
            this._lastHandler.finallyCallback = this.callback;
        }
        else {
            this._lastHandler.nextWrapper = param1;
            this._lastHandler = param1;
            this._lastHandler.finallyCallback = this.callback;
        }
    }

    private function callback():void {
        if (this._finallyCallback != null) {
            this._finallyCallback(this._rest);
        }
    }
}
}
