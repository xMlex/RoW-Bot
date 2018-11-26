package model.logic.quests.completions {
import model.logic.quests.data.StepBonuses;

public class QuestCompletionPvP {


    public var pointsGathered:Number;

    public var bonuses:Array;

    public var userLeague:int;

    public function QuestCompletionPvP() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionPvP {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionPvP = new QuestCompletionPvP();
        _loc2_.pointsGathered = param1.g == null ? Number(0) : Number(param1.g);
        _loc2_.bonuses = param1.b == null ? null : StepBonuses.fromDtos(param1.b);
        _loc2_.userLeague = param1.l;
        return _loc2_;
    }

    public function getBonusesTotalPts():int {
        return this.bonuses[this.bonuses.length - 1].points;
    }
}
}
