package model.logic.quests.completions {
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.quests.commands.TryCompleteQuestCmd;
import model.logic.quests.data.QuestState;

public class CompletionCompleter {


    public function CompletionCompleter() {
        super();
    }

    public static function tryCompleteQuestCompletions(param1:Function):void {
        var _loc3_:QuestState = null;
        var _loc4_:QuestCompletion = null;
        var _loc5_:QuestCompletionByClient = null;
        var _loc6_:TryCompleteQuestCmd = null;
        if (UserManager.user.gameData.questData == null) {
            return;
        }
        var _loc2_:Array = UserManager.user.gameData.questData.openedStates;
        if (_loc2_ == null) {
            return;
        }
        for each(_loc3_ in _loc2_) {
            if (_loc3_.completions != null && _loc3_.stateId == QuestState.StateId_InProgress && (!_loc3_.timeDeadline || _loc3_.timeDeadline && ServerTimeManager.serverTimeNow.time < _loc3_.timeDeadline.time)) {
                for each(_loc4_ in _loc3_.completions) {
                    if (_loc4_.stateId == QuestCompletion.State_InProgress) {
                        if (param1(_loc4_)) {
                            _loc5_ = _loc4_.byClient;
                            _loc6_ = _loc5_ == null ? new TryCompleteQuestCmd(QuestCompletionByClient.Code_None, 0) : new TryCompleteQuestCmd(_loc5_.code, _loc5_.param);
                            _loc6_.execute();
                            return;
                        }
                    }
                }
            }
        }
    }
}
}
