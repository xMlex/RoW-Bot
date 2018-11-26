package model.logic.commands.alliances {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class AllianceBonusesWindowShownCmd extends BaseCmd {


    private var _dto;

    public function AllianceBonusesWindowShownCmd() {
        super();
        this._dto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.AllianceBonusesWindowShown", this._dto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                UserManager.user.gameData.constructionData.allianceBonusWindowShownToday = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
