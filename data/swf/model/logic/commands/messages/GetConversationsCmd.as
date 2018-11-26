package model.logic.commands.messages {
import model.data.users.messages.Message;
import model.logic.MessageManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetConversationsCmd extends BaseCmd {


    private var requestDto;

    public function GetConversationsCmd() {
        super();
        this.requestDto = {};
        MessageManager.populateWithMessageIdsShort(this.requestDto);
    }

    override public function execute():void {
        new JsonCallCmd("Messages.GetConversations", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = Message.fromDtos(param1);
            MessageManager.refreshUnknownData(_loc2_);
            if (_onResult != null) {
                _onResult(_loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
