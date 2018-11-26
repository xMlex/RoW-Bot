package model.data.users.raids {
public class UserStoryInfo {


    public var completedStep:int;

    public function UserStoryInfo() {
        super();
    }

    public static function fromDto(param1:*):UserStoryInfo {
        var _loc2_:UserStoryInfo = new UserStoryInfo();
        _loc2_.completedStep = param1.s;
        return _loc2_;
    }
}
}
