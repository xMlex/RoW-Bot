package model.logic.commands.clans {
import model.data.clans.UserClanData;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ClanCancelCmd extends BaseCmd {


    private var _userId:Number;

    private var requestDto;

    public function ClanCancelCmd(param1:Number) {
        super();
        this._userId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(param1);
    }

    override public function execute():void {
        new JsonCallCmd("Clan.Cancel", this.requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserManager.user.gameData.clanData.removeInvitation(_userId);
                UserManager.user.gameData.clanData.removeMember(_userId);
                UserClanData.refreshFriendIds(UserManager.user);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
