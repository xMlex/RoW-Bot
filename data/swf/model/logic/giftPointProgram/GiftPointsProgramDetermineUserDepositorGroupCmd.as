package model.logic.giftPointProgram {
import cleanData.events.RemoveFormsEvent;

import model.data.giftPoints.UserGiftPointsProgramData;
import model.logic.UserManager;
import model.logic.chats.notification.NotificationHelper;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class GiftPointsProgramDetermineUserDepositorGroupCmd extends BaseCmd {


    private var _requestDto;

    public function GiftPointsProgramDetermineUserDepositorGroupCmd() {
        super();
        this._requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("GiftPointsProgram.DetermineUserDepositorGroup", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                if (param1.o != null) {
                    _loc2_ = new UserGiftPointsProgramData();
                    _loc2_.depositorGroup = param1.o;
                    UserManager.user.gameData.giftPointsProgramData.update(_loc2_);
                    UserManager.user.gameData.giftPointsProgramData.refreshOldPoints();
                }
            }
            NotificationHelper.events.dispatchEvent(new RemoveFormsEvent(RemoveFormsEvent.REMOVE_FORMS, [257, 258]));
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
