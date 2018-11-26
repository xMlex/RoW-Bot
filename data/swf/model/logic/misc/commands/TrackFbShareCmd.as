package model.logic.misc.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public final class TrackFbShareCmd extends BaseCmd {


    private var _dto:Object;

    public function TrackFbShareCmd(param1:int, param2:int, param3:Boolean) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({
            "t": param2,
            "p": param3,
            "f": param1
        });
    }

    override public function execute():void {
        new JsonCallCmd("LogFbShare", this._dto, "POST").ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
