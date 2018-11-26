package model.logic.inviteFriend {
import common.ArrayCustom;

import model.data.UserInvitationData;
import model.data.users.achievements.Achievement;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SendSocialInvitationCmd extends BaseCmd {


    private var requestDto:Object;

    public function SendSocialInvitationCmd(param1:ArrayCustom) {
        var _loc3_:* = undefined;
        super();
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        this.requestDto = UserRefreshCmd.makeRequestDto(_loc2_);
    }

    override public function execute():void {
        new JsonCallCmd("SendSocialInvitation", this.requestDto, "POST").ifResult(function (param1:Object):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                if (param1.o) {
                    _loc2_ = UserInvitationData.fromDto(param1.o.i);
                    if (_loc2_) {
                        UserManager.user.gameData.invitationData.clone(UserManager.user.gameData.invitationData, _loc2_);
                    }
                    _loc3_ = Achievement.fromDtos(param1.o.a);
                    if (_loc3_) {
                        UserManager.user.gameData.statsData.achievements = _loc3_;
                    }
                }
            }
            UserManager.user.gameData.invitationData.dirty = true;
            UserManager.user.gameData.statsData.achievementsDirty = true;
            UserManager.user.gameData.dispatchEvents();
            if (_onResult != null) {
                _onResult(param1.o);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
