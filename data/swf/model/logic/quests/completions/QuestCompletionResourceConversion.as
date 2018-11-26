package model.logic.quests.completions {
public class QuestCompletionResourceConversion extends CompletionCompleter {


    public var resourceTypeId:int;

    public function QuestCompletionResourceConversion() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionResourceConversion {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionResourceConversion = new QuestCompletionResourceConversion();
        _loc2_.resourceTypeId = param1.r;
        return _loc2_;
    }

    public static function tryComplete(param1:int):void {
        var resTypeId:int = param1;
        tryCompleteQuestCompletions(function (param1:QuestCompletion):Boolean {
            var _loc2_:QuestCompletionResourceConversion = param1.resourceConversion;
            if (_loc2_ == null || _loc2_.resourceTypeId < 0 || resTypeId != _loc2_.resourceTypeId) {
                return false;
            }
            return true;
        });
    }
}
}
