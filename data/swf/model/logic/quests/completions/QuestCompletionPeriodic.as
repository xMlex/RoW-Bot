package model.logic.quests.completions {
import Events.EventWithTargetObject;

import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.quests.commands.TryCompleteQuestCmd;
import model.logic.quests.data.QuestState;
import model.logic.quests.data.UserQuestData;
import model.logic.quests.periodicQuests.ComplexSource;
import model.logic.quests.periodicQuests.PeriodicQuestData;
import model.logic.quests.periodicQuests.PeriodicQuestFilterManager;

public class QuestCompletionPeriodic extends CompletionCompleter {


    public var questData:PeriodicQuestData;

    public var currentPoints:Number;

    public function QuestCompletionPeriodic() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionPeriodic {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionPeriodic = new QuestCompletionPeriodic();
        _loc2_.questData = PeriodicQuestData.fromDto(param1.q);
        _loc2_.currentPoints = param1.b;
        return _loc2_;
    }

    public static function tryComplete(param1:ComplexSource, param2:Array):void {
        var questData:UserQuestData = null;
        var questState:QuestState = null;
        var completion:QuestCompletion = null;
        var questCompletion:QuestCompletionPeriodic = null;
        var pointsFilter:Function = null;
        var points:Number = NaN;
        var completedQuestState:QuestState = null;
        var source:ComplexSource = param1;
        var prototypeIds:Array = param2;
        questData = UserManager.user.gameData.questData;
        var questStates:Array = questData.openedStates;
        if (questStates == null) {
            return;
        }
        var completedQuests:Array = [];
        for each(questState in questStates) {
            if (questState.completion != null && questState.completion.periodic != null && questState.stateId == QuestState.StateId_InProgress && (questState.timeDeadline == null || questState.timeDeadline != null && ServerTimeManager.serverTimeNow.time < questState.timeDeadline.time)) {
                for each(completion in questState.completions) {
                    if (completion.stateId == QuestCompletion.State_InProgress) {
                        questCompletion = completion.periodic;
                        if (!(questCompletion == null || prototypeIds.indexOf(questCompletion.questData.prototypeId) == -1)) {
                            pointsFilter = PeriodicQuestFilterManager.pointsFiltersByPrototypeId[questCompletion.questData.prototypeId];
                            if (pointsFilter != null) {
                                points = pointsFilter(source, questCompletion);
                                if (!isNaN(points) && points > 0) {
                                    questCompletion.incrementPoints(points);
                                    questData.dirtyPeriodicQuest = true;
                                    questData.dispatchEvents();
                                    if (questCompletion.isCompleted()) {
                                        completedQuests.push(questState.questId);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if (completedQuests.length > 0) {
            completedQuestState = UserManager.user.gameData.questData.getQuestStateByQuestId(completedQuests[0]);
            new TryCompleteQuestCmd(QuestCompletionByClient.Code_None, 0).ifResult(function ():void {
                var _loc1_:* = undefined;
                if (completedQuestState != null) {
                    _loc1_ = new EventWithTargetObject(UserQuestData.PERIODIC_QUEST_COMPLETED);
                    _loc1_.targetObject = completedQuestState;
                    questData.events.dispatchEvent(_loc1_);
                }
            }).execute();
        }
    }

    public function isCompleted():Boolean {
        return this.currentPoints >= this.questData.needCollectPoints;
    }

    public function incrementPoints(param1:Number = 1):void {
        this.currentPoints = this.currentPoints + param1;
    }

    public function equal(param1:QuestCompletionPeriodic):Boolean {
        if (!param1) {
            return false;
        }
        if (param1.currentPoints != this.currentPoints) {
            return false;
        }
        if (param1.questData.prototypeId != param1.questData.prototypeId) {
            return false;
        }
        return true;
    }
}
}
