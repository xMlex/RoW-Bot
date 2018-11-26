package model.logic.quests.periodicQuests {
import model.data.UserPrize;

public class PeriodicQuestData {


    public var prototypeId:int;

    public var needCollectPoints:int;

    public var prize:UserPrize;

    public var filter:PeriodicQuestFilter;

    public function PeriodicQuestData() {
        super();
    }

    public static function fromDto(param1:*):PeriodicQuestData {
        var _loc2_:PeriodicQuestData = new PeriodicQuestData();
        _loc2_.prototypeId = param1.p;
        _loc2_.needCollectPoints = param1.c;
        _loc2_.prize = UserPrize.fromDto(param1.pz);
        _loc2_.filter = PeriodicQuestFilter.fromDto(param1.f);
        return _loc2_;
    }
}
}
