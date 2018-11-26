package model.logic.chats {
import flash.utils.Dictionary;

import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class ChatSetRoomKeysCmd extends BaseCmd {


    private var _dto;

    public function ChatSetRoomKeysCmd(param1:String, param2:Dictionary) {
        super();
        this._dto = {
            "i": param1,
            "d": param2
        };
    }

    override public function execute():void {
        new JsonCallCmd("ChatSetRoomKeys", this._dto).ifResult(_onResult).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
