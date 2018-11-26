package model.logic.quests.completions {
public class QuestCompletionByDraw extends CompletionCompleter {


    public var sotId:int;

    public var partId:int;

    public function QuestCompletionByDraw() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByDraw {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByDraw = new QuestCompletionByDraw();
        _loc2_.sotId = param1.i;
        _loc2_.partId = param1.l;
        return _loc2_;
    }

    public static function tryComplete(param1:int, param2:int):void {
        var sotId:int = param1;
        var level:int = param2;
        tryCompleteQuestCompletions(function (param1:QuestCompletion):Boolean {
            var _loc2_:QuestCompletionByDraw = param1.byDraw;
            if (_loc2_ == null) {
                return false;
            }
            return true;
        });
    }

    public function equal(param1:QuestCompletionByDraw):Boolean {
        if (!param1) {
            return false;
        }
        if (param1.sotId != this.sotId) {
            return false;
        }
        if (param1.partId != this.partId) {
            return false;
        }
        return true;
    }
}
}
