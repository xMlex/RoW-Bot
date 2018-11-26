package model.logic.quests.completions {
public class QuestCompletionMiniGame {


    public var level:int;

    public function QuestCompletionMiniGame() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionMiniGame {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionMiniGame = new QuestCompletionMiniGame();
        _loc2_.level = param1.l == null ? 0 : int(param1.l);
        return _loc2_;
    }
}
}
