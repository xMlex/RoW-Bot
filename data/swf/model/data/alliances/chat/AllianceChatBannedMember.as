package model.data.alliances.chat {
public class AllianceChatBannedMember {


    public var userId:int;

    public var bannedUntil:Date;

    public function AllianceChatBannedMember() {
        super();
    }

    public static function fromDto(param1:*):AllianceChatBannedMember {
        var _loc2_:AllianceChatBannedMember = new AllianceChatBannedMember();
        _loc2_.userId = param1.i;
        _loc2_.bannedUntil = param1.k == null ? new Date() : new Date(param1.k);
        return _loc2_;
    }
}
}
