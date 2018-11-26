package model.logic.ratings.commands {
import model.data.raids.GlobalMissionManager;
import model.logic.ServerTimeManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class UserGlobalMissionRatingGetCmd extends BaseCmd {


    public function UserGlobalMissionRatingGetCmd() {
        super();
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetUserGlobalMissionRating", null, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = param1;
            if (_loc2_) {
                GlobalMissionManager.myPosition = _loc2_.p < 0 ? 0 : int(_loc2_.p + 1);
                GlobalMissionManager.callTime = ServerTimeManager.serverTimeNow;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
