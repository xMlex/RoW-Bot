package model.logic.chats {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class ChatSendMessageCmd extends BaseCmd {


    private var _dto;

    public function ChatSendMessageCmd(param1:String, param2:String) {
        super();
        this._dto = {
            "r": param1,
            "m": param2
        };
    }

    override public function execute():void {
        new JsonCallCmd("ChatSendMessage", this._dto).ifResult(_onResult).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
