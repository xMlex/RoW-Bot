package model.logic.quests.completions {
public class QuestCompletionByStats extends CompletionCompleter {


    public var statsTypeId:int;

    public var valueRequired:Number;

    public var level:int;

    public var maxLevel:int;

    public function QuestCompletionByStats() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByStats {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByStats = new QuestCompletionByStats();
        _loc2_.statsTypeId = param1.t;
        _loc2_.valueRequired = param1.v;
        _loc2_.level = param1.l;
        _loc2_.maxLevel = param1.m;
        return _loc2_;
    }
}
}
