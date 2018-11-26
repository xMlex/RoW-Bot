package model.data.alliances.chat {
import flash.utils.Dictionary;

public class AllianceChatRoomData {


    public var name:String;

    public var allowedRanks:Array;

    public var allowedRanksDictionary:Dictionary;

    public var bannedMembers:Array;

    public function AllianceChatRoomData() {
        super();
    }

    public static function fromDto(param1:*):AllianceChatRoomData {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc2_:AllianceChatRoomData = new AllianceChatRoomData();
        _loc2_.name = param1.n;
        if (param1.k != null) {
            _loc2_.allowedRanks = [];
            _loc2_.allowedRanksDictionary = new Dictionary();
            for each(_loc3_ in param1.k) {
                _loc2_.allowedRanks.push(_loc3_);
                _loc2_.allowedRanksDictionary[_loc3_] = true;
            }
        }
        if (param1.b != null) {
            _loc2_.bannedMembers = [];
            for (_loc4_ in param1.b) {
                if (param1.b[_loc4_] != null) {
                    _loc2_.bannedMembers[_loc2_.bannedMembers.length] = AllianceChatBannedMember.fromDto(param1.b[_loc4_]);
                }
            }
        }
        return _loc2_;
    }

    public function toDto():* {
        return {
            "n": this.name,
            "k": this.allowedRanks
        };
    }
}
}
