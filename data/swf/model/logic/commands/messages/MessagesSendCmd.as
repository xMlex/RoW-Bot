package model.logic.commands.messages {
import configs.Global;

import model.data.users.messages.Message;
import model.logic.MessageManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class MessagesSendCmd extends BaseCmd {


    private var _message:Message;

    private var requestDto;

    public function MessagesSendCmd(param1:Message) {
        super();
        this._message = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._message.toDto());
    }

    override public function execute():void {
        new JsonCallCmd("Messages.Send", this.requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _message.id = param1.o;
                if (!Global.EXTERNAL_MASSAGES_ENABLED) {
                    MessageManager.add(UserManager.user, _message);
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
