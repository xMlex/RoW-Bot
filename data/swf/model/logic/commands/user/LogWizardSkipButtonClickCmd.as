package model.logic.commands.user {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class LogWizardSkipButtonClickCmd extends BaseCmd {


    private var dto;

    public function LogWizardSkipButtonClickCmd(param1:Number) {
        super();
        this.dto = UserRefreshCmd.makeRequestDto(param1);
    }

    override public function execute():void {
        new JsonCallCmd("LogWizardSkipButtonClick", this.dto).ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
