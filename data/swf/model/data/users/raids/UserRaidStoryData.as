package model.data.users.raids {
import flash.utils.Dictionary;

public class UserRaidStoryData {


    public var storyInfoById:Dictionary;

    public function UserRaidStoryData() {
        super();
    }

    public static function fromDto(param1:*):UserRaidStoryData {
        var _loc3_:* = undefined;
        var _loc4_:UserStoryInfo = null;
        var _loc2_:UserRaidStoryData = new UserRaidStoryData();
        _loc2_.storyInfoById = new Dictionary();
        for (_loc3_ in param1.s) {
            _loc4_ = UserStoryInfo.fromDto(param1.s[_loc3_]);
            _loc2_.storyInfoById[_loc3_] = _loc4_;
        }
        return _loc2_;
    }
}
}
