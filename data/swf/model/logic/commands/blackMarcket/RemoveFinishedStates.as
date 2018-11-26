package model.logic.commands.blackMarcket {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RemoveFinishedStates extends BaseCmd {


    private var _requestDto;

    public function RemoveFinishedStates() {
        super();
        this._requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("EffectManager.RemoveFinishedStates", this._requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                UserManager.user.gameData.effectData.removeFinishedState();
                UserManager.user.gameData.effectData.dirty = true;
            }
            if (_onResult != null) {
                _onResult(param1.o);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
