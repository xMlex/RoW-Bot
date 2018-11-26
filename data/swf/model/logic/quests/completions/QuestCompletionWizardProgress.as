package model.logic.quests.completions {
public class QuestCompletionWizardProgress {


    public var wizardQuestsCompleted:int;

    public var wizardQuestsTotal:int;

    public function QuestCompletionWizardProgress() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionWizardProgress {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionWizardProgress = new QuestCompletionWizardProgress();
        _loc2_.wizardQuestsCompleted = param1.c == null ? 0 : int(param1.c);
        _loc2_.wizardQuestsTotal = param1.t == null ? 0 : int(param1.t);
        return _loc2_;
    }
}
}
