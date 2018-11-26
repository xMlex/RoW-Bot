package model.data.users.globalmessages {
public class GlobalMessageUserData {


    public var lastKnownMessageId:int;

    public var unreadMessageIds:Array;

    public function GlobalMessageUserData() {
        super();
    }

    public static function fromDto(param1:*):GlobalMessageUserData {
        var _loc2_:GlobalMessageUserData = new GlobalMessageUserData();
        _loc2_.lastKnownMessageId = param1.l;
        _loc2_.unreadMessageIds = param1.u;
        return _loc2_;
    }
}
}
