package model.data.users.messages {
import flash.utils.Dictionary;

public class GroupMessages {


    public var groupId:int = 0;

    public var count:int = 0;

    public var unreadCount:int = 0;

    public function GroupMessages() {
        super();
    }

    public static function fromDto(param1:*):GroupMessages {
        var _loc2_:GroupMessages = new GroupMessages();
        _loc2_.groupId = param1.g;
        _loc2_.count = param1.c;
        _loc2_.unreadCount = param1.u;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Dictionary {
        var _loc3_:* = undefined;
        var _loc2_:Dictionary = new Dictionary();
        for each(_loc3_ in param1) {
            _loc2_[_loc3_.g] = fromDto(_loc3_);
        }
        return _loc2_;
    }

    public static function toDtos(param1:Dictionary):Array {
        var _loc3_:GroupMessages = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "g": this.groupId,
            "c": this.count,
            "u": this.unreadCount
        };
        return _loc1_;
    }
}
}
