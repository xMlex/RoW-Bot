package model.logic.commands.drawings {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ClickOnUserStationCmd extends BaseCmd {


    private var requestDto;

    private var _friendId:int;

    public function ClickOnUserStationCmd(param1:int) {
        super();
        this._friendId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._friendId);
    }

    override public function execute():void {
        new JsonCallCmd("DrawingManager.ClickOnStation", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user.gameData.drawingArchive;
                _loc2_.clicksForUserIds.addItem(_friendId);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
