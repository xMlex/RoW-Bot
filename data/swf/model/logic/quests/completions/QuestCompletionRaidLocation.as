package model.logic.quests.completions {
public class QuestCompletionRaidLocation {


    public var storyId:int;

    public var stepId:int;

    public var raidLocationLevel:int;

    public var raidLocationKindId:int;

    public var maxLocationsCount:int;

    public var locationsCountLeft:int;

    public var locationLevel:int;

    public function QuestCompletionRaidLocation() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionRaidLocation {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionRaidLocation = new QuestCompletionRaidLocation();
        _loc2_.storyId = param1.y == null ? 0 : int(param1.y);
        _loc2_.stepId = param1.p == null ? 0 : int(param1.p);
        _loc2_.raidLocationLevel = param1.l == null ? 0 : int(param1.l);
        _loc2_.maxLocationsCount = param1.c == null ? 0 : int(param1.c);
        _loc2_.locationsCountLeft = param1.s == null ? 0 : int(param1.s);
        _loc2_.raidLocationKindId = param1.o == null ? 0 : int(param1.o);
        _loc2_.locationLevel = param1.n == null ? 0 : int(param1.n);
        return _loc2_;
    }
}
}
