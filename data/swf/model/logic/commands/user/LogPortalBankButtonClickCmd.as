package model.logic.commands.user {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class LogPortalBankButtonClickCmd extends BaseCmd {


    private var dto;

    public function LogPortalBankButtonClickCmd(param1:Object) {
        super();
        this.dto = param1;
    }

    override public function execute():void {
        new JsonCallCmd("LogPortalBankButtonClick", this.dto, "POST").ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(function ():void {
        }).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
