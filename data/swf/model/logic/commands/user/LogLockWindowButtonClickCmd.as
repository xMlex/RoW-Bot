package model.logic.commands.user {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class LogLockWindowButtonClickCmd extends BaseCmd {


    private var userId:Number;

    public function LogLockWindowButtonClickCmd(param1:Number) {
        super();
        this.userId = param1;
    }

    override public function execute():void {
        var dto:Object = UserRefreshCmd.makeRequestDto(this.userId);
        new JsonCallCmd("LogLockWindowButtonClick", dto, "POST").ifResult(function (param1:Object):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
