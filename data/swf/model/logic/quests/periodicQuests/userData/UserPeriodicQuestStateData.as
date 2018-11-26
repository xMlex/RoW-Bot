package model.logic.quests.periodicQuests.userData {
import model.logic.UserManager;
import model.logic.quests.data.QuestState;
import model.logic.quests.periodicQuests.PeriodicQuestData;

public class UserPeriodicQuestStateData {


    public var groupId:int;

    public var questStateId:int;

    public var questId:int;

    public var timeDeadline:Date;

    public var questStaticData:PeriodicQuestData;

    public var isReceivedBonus:Boolean;

    private var _questState:QuestState;

    public function UserPeriodicQuestStateData() {
        super();
    }

    public static function fromDto(param1:*):UserPeriodicQuestStateData {
        var _loc2_:UserPeriodicQuestStateData = new UserPeriodicQuestStateData();
        _loc2_.groupId = param1.g;
        _loc2_.questStateId = param1.s;
        _loc2_.questId = param1.q;
        _loc2_.timeDeadline = new Date(param1.d);
        _loc2_._questState = param1.qs == null ? null : QuestState.fromDto(param1.qs);
        _loc2_.questStaticData = param1.sd == null ? null : PeriodicQuestData.fromDto(param1.sd);
        _loc2_.isReceivedBonus = param1.r;
        return _loc2_;
    }

    public function get questState():QuestState {
        var _loc1_:QuestState = null;
        if (this._questState == null) {
            _loc1_ = UserManager.user.gameData.questData.getQuestStateByQuestId(this.questId);
        }
        else {
            _loc1_ = this._questState;
        }
        return _loc1_;
    }
}
}
