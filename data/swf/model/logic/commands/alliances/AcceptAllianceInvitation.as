package model.logic.commands.alliances {
import model.data.alliances.AllianceMemberRankId;
import model.data.users.alliances.UserAllianceInvitation;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class AcceptAllianceInvitation extends BaseCmd {


    private var _invitation:UserAllianceInvitation;

    private var requestDto;

    public function AcceptAllianceInvitation(param1:UserAllianceInvitation) {
        super();
        this._invitation = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._invitation.allianceId);
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.AcceptInvitation", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user.gameData.allianceData;
                _loc2_.allianceId = _invitation.allianceId;
                _loc2_.rankId = AllianceMemberRankId.INVITED;
                _loc2_.invitations.removeItemAt(_loc2_.invitations.getItemIndex(_invitation));
                _loc2_.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
