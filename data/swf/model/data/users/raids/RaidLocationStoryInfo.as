package model.data.users.raids {
public class RaidLocationStoryInfo {


    public var storyId:int;

    public var stepId:int;

    public function RaidLocationStoryInfo() {
        super();
    }

    public static function fromDto(param1:*):RaidLocationStoryInfo {
        var _loc2_:RaidLocationStoryInfo = new RaidLocationStoryInfo();
        _loc2_.storyId = param1.i;
        _loc2_.stepId = param1.s;
        return _loc2_;
    }
}
}
