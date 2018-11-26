package model.logic.commands.messages {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class MessagesBlackListAddCmd extends BaseCmd {


    private var _userId:Number;

    private var requestDto;

    public function MessagesBlackListAddCmd(param1:Number) {
        super();
        this._userId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._userId);
    }

    override public function execute():void {
        new JsonCallCmd("Messages.BlackListAdd", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                if (isNaN(_userId)) {
                    return;
                }
                _loc2_ = UserManager.user.gameData.messageData.blackList;
                _loc3_ = _loc2_.getItemIndex(_userId);
                if (_loc3_ == -1) {
                    _loc2_.addItem(_userId);
                }
            }
            UserManager.user.gameData.messageData.blackListChanged = true;
            UserManager.user.gameData.messageData.dispatchEvents();
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
