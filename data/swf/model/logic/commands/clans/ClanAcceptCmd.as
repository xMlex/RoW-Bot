package model.logic.commands.clans {
import model.data.clans.ClanMember;
import model.data.clans.UserClanData;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ClanAcceptCmd extends BaseCmd {


    private var _inviterUserId:Number;

    private var requestDto;

    public function ClanAcceptCmd(param1:Number) {
        super();
        this._inviterUserId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(param1);
    }

    override public function execute():void {
        new JsonCallCmd("Clan.Accept", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserManager.user.gameData.clanData.removeInvitation(_inviterUserId);
                _loc2_ = new ClanMember();
                _loc2_.userId = _inviterUserId;
                _loc2_.state = ClanMember.State_Normal;
                UserManager.user.gameData.clanData.addMember(_loc2_);
                UserClanData.refreshFriendIds(UserManager.user);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
