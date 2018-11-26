package model.logic.misc.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public final class SendUserDetailsCmd extends BaseCmd {


    private var _dto;

    private var address:String;

    public function SendUserDetailsCmd(param1:Object, param2:String = "") {
        super();
        this._dto = param1;
        this.address = param2;
    }

    override public function execute():void {
        new JsonCallCmd("CustomCmd.SendResult", this._dto, "POST", this.address).ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
