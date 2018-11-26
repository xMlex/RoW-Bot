package model.logic.misc.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class TrackNPPBankButtonClickCmd extends BaseCmd {


    private var userId:Number;

    public function TrackNPPBankButtonClickCmd(param1:Number) {
        super();
        this.userId = param1;
    }

    override public function execute():void {
        var dto:Object = UserRefreshCmd.makeRequestDto(this.userId);
        new JsonCallCmd("LogNPPBankButtonClick", dto, "POST").ifResult(function (param1:Object):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
