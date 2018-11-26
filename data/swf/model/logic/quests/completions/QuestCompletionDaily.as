package model.logic.quests.completions {
public class QuestCompletionDaily {


    public var duration:Date;

    public function QuestCompletionDaily() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionDaily {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionDaily = new QuestCompletionDaily();
        if (param1.d != null) {
            _loc2_.duration = new Date(param1.d * 60 * 1000);
        }
        return _loc2_;
    }
}
}
