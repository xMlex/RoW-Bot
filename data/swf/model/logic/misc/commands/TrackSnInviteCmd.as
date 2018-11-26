package model.logic.misc.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class TrackSnInviteCmd extends BaseCmd {


    private var receivers:Array;

    public function TrackSnInviteCmd(param1:Array) {
        super();
        this.receivers = param1;
    }

    override public function execute():void {
        var dto:Object = UserRefreshCmd.makeRequestDto(this.receivers);
        new JsonCallCmd("LogFriendInvitation", dto, "POST").ifResult(function (param1:Object):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
