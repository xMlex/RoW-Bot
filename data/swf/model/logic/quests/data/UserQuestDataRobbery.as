package model.logic.quests.data {
public class UserQuestDataRobbery {


    public var firstTodayRobberyTime:Date;

    public var robberyCompletedTimes:int;

    public var hadQuestRobberySuperPrize:Boolean;

    public function UserQuestDataRobbery() {
        super();
    }

    public static function fromDto(param1:*):UserQuestDataRobbery {
        var _loc2_:UserQuestDataRobbery = new UserQuestDataRobbery();
        _loc2_.firstTodayRobberyTime = !!null ? null : new Date(param1.r);
        _loc2_.robberyCompletedTimes = param1.c;
        _loc2_.hadQuestRobberySuperPrize = param1.s;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return new Array();
        }
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
