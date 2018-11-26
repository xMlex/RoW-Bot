package model.logic.commands.user {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class RecordBankOpenedCmd extends BaseCmd {


    private var _dto;

    public function RecordBankOpenedCmd(param1:int) {
        super();
        this._dto = {"c": param1};
    }

    override public function execute():void {
        new JsonCallCmd("RecordBankOpened", this._dto, "POST").ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
