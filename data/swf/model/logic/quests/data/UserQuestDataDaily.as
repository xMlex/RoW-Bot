package model.logic.quests.data {
public class UserQuestDataDaily {


    public var firstRefreshTime:Date;

    public var lastRefreshTime:Date;

    public var refreshesNumber:int;

    public var usedBlackMarketItemResetDailyCount:int;

    public function UserQuestDataDaily() {
        super();
    }

    public static function fromDto(param1:*):UserQuestDataDaily {
        var _loc2_:UserQuestDataDaily = new UserQuestDataDaily();
        _loc2_.firstRefreshTime = param1.f == null ? null : new Date(param1.f);
        _loc2_.lastRefreshTime = param1.r == null ? null : new Date(param1.r);
        _loc2_.refreshesNumber = param1.n;
        _loc2_.usedBlackMarketItemResetDailyCount = param1.z;
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

    public function get isFirstRefresh():Boolean {
        return this.firstRefreshTime.time == this.lastRefreshTime.time;
    }
}
}
