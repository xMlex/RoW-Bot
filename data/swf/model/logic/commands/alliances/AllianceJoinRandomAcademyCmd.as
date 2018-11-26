package model.logic.commands.alliances {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class AllianceJoinRandomAcademyCmd extends BaseCmd {


    private var _dto;

    public function AllianceJoinRandomAcademyCmd() {
        super();
        this._dto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.JoinRandomAcademy", this._dto, "POST").ifResult(function (param1:*):void {
            UserRefreshCmd.updateUserByResultDto(param1, _dto);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
