package model.logic.commands.user {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class TrackerBankOpenedCmd extends BaseCmd {


    public function TrackerBankOpenedCmd() {
        super();
        new JsonCallCmd("ClickedOpeningWindowBank", "", "POST").ifResult(function (param1:*):void {
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
