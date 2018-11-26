package model.logic.quests.completions {
public class QuestCompletionByFarming {


    public var pointsRequired:Number;

    public var pointsGathered:Number;

    public function QuestCompletionByFarming() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByFarming {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByFarming = new QuestCompletionByFarming();
        _loc2_.pointsRequired = param1.n == null ? Number(0) : Number(param1.n);
        _loc2_.pointsGathered = param1.c == null ? Number(0) : Number(param1.c);
        return _loc2_;
    }
}
}
