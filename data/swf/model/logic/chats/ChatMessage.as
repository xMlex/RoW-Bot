package model.logic.chats {
import common.ArrayCustom;

public class ChatMessage {


    public var id:Number;

    public var time:Date;

    public var userId:Number;

    public var userSegmentId:int;

    public var userName:String;

    public var text:String;

    public var clearRoom:Boolean;

    public var administrativeMessage:AdministrativeChatMessage;

    public var firstName:String;

    public var secondName:String;

    public function ChatMessage() {
        super();
    }

    public static function fromDto(param1:*):ChatMessage {
        var _loc3_:int = 0;
        var _loc4_:String = null;
        if (param1 == null) {
            return null;
        }
        var _loc2_:ChatMessage = new ChatMessage();
        _loc2_.id = param1.i;
        _loc2_.time = new Date(param1.t);
        _loc2_.userId = param1.u;
        _loc2_.userSegmentId = param1.s;
        _loc2_.userName = param1.n;
        _loc2_.text = param1.m;
        _loc2_.clearRoom = param1.c;
        _loc2_.administrativeMessage = AdministrativeChatMessage.fromDto(param1.d);
        if (_loc2_.userName) {
            _loc3_ = _loc2_.userName.indexOf(" ");
            if (_loc3_ > -1) {
                _loc2_.firstName = _loc2_.userName.substr(0, 1) + ".";
                _loc2_.secondName = _loc2_.userName.substr(_loc3_ + 1, _loc2_.userName.length - _loc3_ - 1);
            }
        }
        if (_loc2_.administrativeMessage) {
            _loc2_.userName = _loc2_.administrativeMessage.name;
            _loc4_ = _loc2_.administrativeMessage.text;
            if (_loc4_) {
                _loc2_.text = _loc4_;
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
