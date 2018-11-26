package model.logic.chats {
public class BanRoomInfo {


    public var userBanned:Boolean;

    public var reason:String;

    public var bannedUntil:Date;

    public function BanRoomInfo() {
        super();
    }

    public static function fromDto(param1:*):BanRoomInfo {
        var _loc2_:BanRoomInfo = new BanRoomInfo();
        _loc2_.userBanned = param1.b == 1 ? true : false;
        _loc2_.reason = !!param1.r ? param1.r : "";
        _loc2_.bannedUntil = param1.u == null ? null : new Date(param1.u);
        return _loc2_;
    }
}
}
