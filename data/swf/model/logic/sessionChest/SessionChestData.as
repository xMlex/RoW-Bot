package model.logic.sessionChest {
import gameObjects.observableObject.ObservableObject;

import model.data.UserPrize;

public class SessionChestData extends ObservableObject {

    public static const FINISH_TIME_CHANGED:String = "finish_time_changed_session_chest_data";

    public static const CLASS_NAME:String = "SessionChestData";

    public static const CHANGED:String = CLASS_NAME + "Changed";

    public static const REWARD_CALCULATED:String = CLASS_NAME + "RewardCalculated";

    public static const REWARD_START_TAKING:String = CLASS_NAME + "RewardStartTaking";


    public var dirty:Boolean;

    public var completedChestCount:int;

    public var nextChestFinishTime:Date;

    public var lastCompletedChestTime:Date;

    public var lastCompletedChestId:int;

    public var completedChestCountToday:int;

    public var completedInitialSequence:Boolean;

    public var availableChestReward:UserPrize;

    public function SessionChestData(param1:*) {
        super();
        this.completedChestCount = param1.c;
        this.setNextChestFinishTime = new Date(param1.t);
        this.lastCompletedChestTime = new Date(param1.l);
        this.lastCompletedChestId = param1.i;
        this.completedChestCountToday = param1.d;
        this.completedInitialSequence = param1.o;
        this.availableChestReward = !!param1.p ? UserPrize.fromDto(param1.p) : null;
    }

    public static function fromDto(param1:*):SessionChestData {
        var _loc2_:SessionChestData = null;
        if (param1) {
            _loc2_ = new SessionChestData(param1);
        }
        return _loc2_;
    }

    public function set setNextChestFinishTime(param1:Date):void {
        this.nextChestFinishTime = param1;
        dispatchEvent(FINISH_TIME_CHANGED);
    }

    public function update(param1:SessionChestData):void {
        this.completedChestCount = param1.completedChestCount;
        this.setNextChestFinishTime = param1.nextChestFinishTime;
        this.lastCompletedChestTime = param1.lastCompletedChestTime;
        this.lastCompletedChestId = param1.lastCompletedChestId;
        this.completedChestCountToday = param1.completedChestCountToday;
        this.completedInitialSequence = param1.completedInitialSequence;
        this.availableChestReward = param1.availableChestReward;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(CHANGED);
        }
    }

    public function rewardStartTakingEvent():void {
        dispatchEvent(REWARD_START_TAKING);
    }

    public function equals(param1:SessionChestData):Boolean {
        if (this.completedChestCount != param1.completedChestCount || this.nextChestFinishTime != param1.nextChestFinishTime || this.lastCompletedChestTime != param1.lastCompletedChestTime || this.lastCompletedChestId != param1.lastCompletedChestId || this.completedChestCountToday != param1.completedChestCountToday || this.completedInitialSequence != param1.completedInitialSequence || this.availableChestReward != param1.availableChestReward) {
            return false;
        }
        return true;
    }
}
}
