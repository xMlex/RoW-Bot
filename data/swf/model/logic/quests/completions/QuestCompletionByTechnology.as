package model.logic.quests.completions {
import model.logic.UserManager;

public class QuestCompletionByTechnology extends CompletionCompleter {


    public var sotId:int;

    public var level:int;

    public function QuestCompletionByTechnology() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByTechnology {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByTechnology = new QuestCompletionByTechnology();
        _loc2_.sotId = param1.i;
        _loc2_.level = param1.l;
        return _loc2_;
    }

    public static function tryComplete(param1:int, param2:int):void {
        var sotId:int = param1;
        var level:int = param2;
        tryCompleteQuestCompletions(function (param1:QuestCompletion):Boolean {
            var _loc2_:QuestCompletionByTechnology = param1.byTechnology;
            if (_loc2_ == null || _loc2_.sotId != sotId || _loc2_.level > level) {
                return false;
            }
            return UserManager.user.gameData.technologyCenter.hasActiveTechnology(sotId, level);
        });
    }

    public function equal(param1:QuestCompletionByTechnology):Boolean {
        if (!param1) {
            return false;
        }
        if (param1.sotId != this.sotId) {
            return false;
        }
        if (param1.level != this.level) {
            return false;
        }
        return true;
    }
}
}
