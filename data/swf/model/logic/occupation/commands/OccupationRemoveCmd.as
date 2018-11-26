package model.logic.occupation.commands {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class OccupationRemoveCmd extends BaseCmd {


    private var _userId:Number;

    private var requestDto;

    public function OccupationRemoveCmd(param1:Number) {
        super();
        this._userId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto({"u": this._userId});
    }

    override public function execute():void {
        new JsonCallCmd("Occupation.Remove", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user.gameData.occupationData;
                _loc2_.removeUserInfo(_userId);
                _loc2_.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
