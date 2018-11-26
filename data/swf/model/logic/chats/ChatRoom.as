package model.logic.chats {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class ChatRoom {


    public var id:String;

    public var messages:ArrayCustom;

    public var roomDataMessageId:Number;

    public var roomData:Dictionary;

    public var newMessages:int = 0;

    public function ChatRoom() {
        super();
    }

    public static function fromDto(param1:*):ChatRoom {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return null;
        }
        var _loc2_:ChatRoom = new ChatRoom();
        _loc2_.id = param1.r;
        _loc2_.messages = ChatMessage.fromDtos(param1.m);
        _loc2_.roomDataMessageId = param1.k == null ? Number(0) : Number(param1.k);
        if (param1.d != null) {
            _loc2_.roomData = new Dictionary();
            for (_loc3_ in param1.d) {
                _loc2_.roomData[_loc3_] = param1.d[_loc3_];
            }
        }
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
