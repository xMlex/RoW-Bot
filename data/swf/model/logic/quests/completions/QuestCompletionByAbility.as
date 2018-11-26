package model.logic.quests.completions {
import model.logic.UserManager;

public class QuestCompletionByAbility extends CompletionCompleter {


    public var abilityId:int;

    public var level:int;

    public function QuestCompletionByAbility() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByAbility {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByAbility = new QuestCompletionByAbility();
        _loc2_.abilityId = param1.i;
        _loc2_.level = param1.l;
        return _loc2_;
    }

    public static function tryComplete(param1:int, param2:int):void {
        var id:int = param1;
        var level:int = param2;
        tryCompleteQuestCompletions(function (param1:QuestCompletion):Boolean {
            var _loc2_:QuestCompletionByAbility = param1.byAbility;
            if (_loc2_ == null || _loc2_.abilityId != id || _loc2_.level > level) {
                return false;
            }
            return UserManager.user.gameData.dragonData.hasActiveAbility(id, level);
        });
    }

    public function equal(param1:QuestCompletionByTechnology):Boolean {
        if (!param1) {
            return false;
        }
        if (param1.sotId != this.abilityId) {
            return false;
        }
        if (param1.level != this.level) {
            return false;
        }
        return true;
    }
}
}
