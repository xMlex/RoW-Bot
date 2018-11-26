package model.logic.commands.clans {
import model.data.clans.ClanMember;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ClanInviteCmd extends BaseCmd {


    private var _invitedUserId:Number;

    private var requestDto;

    public function ClanInviteCmd(param1:Number) {
        super();
        this._invitedUserId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(param1);
    }

    override public function execute():void {
        new JsonCallCmd("Clan.Invite", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = new ClanMember();
                _loc2_.userId = _invitedUserId;
                _loc2_.state = ClanMember.State_Invited;
                UserManager.user.gameData.clanData.addMember(_loc2_);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
