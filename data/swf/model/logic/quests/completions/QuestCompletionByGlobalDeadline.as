package model.logic.quests.completions {
public class QuestCompletionByGlobalDeadline {


    public var deadline:Date;

    public function QuestCompletionByGlobalDeadline() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByGlobalDeadline {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByGlobalDeadline = new QuestCompletionByGlobalDeadline();
        _loc2_.deadline = new Date(param1.d);
        return _loc2_;
    }
}
}
