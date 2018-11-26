package model.logic.quests.completions {
public class QuestCompletionByFirstDeposit extends CompletionCompleter {


    public var showOnLogin:Boolean;

    public function QuestCompletionByFirstDeposit() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByFirstDeposit {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByFirstDeposit = new QuestCompletionByFirstDeposit();
        _loc2_.showOnLogin = param1.s;
        return _loc2_;
    }
}
}
