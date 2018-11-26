package model.logic.quests.data {
import Events.EventWithTargetObject;

import common.ArrayCustom;

import model.data.UserPrize;
import model.data.quests.QuestPrototypeId;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.quests.completions.QuestCompletion;

public class QuestState {

    public static const StateId_New:int = 0;

    public static const StateId_InProgress:int = 5;

    public static const StateId_Completed:int = 9;


    public var questId:int;

    public var prototypeId:int;

    public var stateId:int;

    public var timeAdded:Date;

    public var timeDeadline:Date;

    public var timeStarted:Date;

    public var completions:Array;

    public var discountItems:ArrayCustom;

    public var bonuses:UserPrize;

    public var selectableBonuses:Array;

    public var isWindowOpened:int;

    public var isRead:Boolean;

    public var colorIndex:int;

    public var periodicQuestGroupId:int;

    public var timeToRemind:Date;

    public function QuestState() {
        super();
    }

    public static function fromDto(param1:*):QuestState {
        var _loc2_:QuestState = new QuestState();
        _loc2_.questId = param1.l;
        _loc2_.prototypeId = param1.i;
        _loc2_.stateId = param1.s;
        _loc2_.isWindowOpened = param1.w == null ? -1 : int(int(param1.w));
        _loc2_.timeAdded = new Date(param1.a);
        _loc2_.timeDeadline = param1.d == null ? null : new Date(param1.d);
        _loc2_.timeStarted = param1.t == null ? null : new Date(param1.t);
        _loc2_.completions = QuestCompletion.fromDtos(param1.c);
        _loc2_.discountItems = param1.di == null ? null : QuestDepositDiscount.fromDtos(param1.di);
        _loc2_.bonuses = param1.b == null ? null : UserPrize.fromDto(param1.b);
        _loc2_.selectableBonuses = param1.sb == null ? null : SelectableBonusSlot.fromDtos(param1.sb);
        _loc2_.isRead = param1.r == null ? false : Boolean(Boolean(param1.r));
        _loc2_.colorIndex = param1.ci;
        _loc2_.periodicQuestGroupId = param1.pg;
        _loc2_.timeToRemind = param1.m == null ? null : new Date(param1.m);
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return [];
        }
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function get completion():QuestCompletion {
        var _loc1_:QuestCompletion = null;
        if (this.completions != null && this.completions.length > 0) {
            _loc1_ = this.completions[0];
        }
        return _loc1_;
    }

    public function setCompletionState():void {
        this.stateId = QuestState.StateId_Completed;
        UserManager.user.gameData.questData.events.dispatchEvent(new EventWithTargetObject(UserQuestData.QUEST_COMPLETE, this.questId));
    }

    public function isDirectDeposit():Boolean {
        return this.prototypeId >= QuestPrototypeId.MinDirectDeposit && this.prototypeId <= QuestPrototypeId.MaxDirectDeposit;
    }

    public function isActual():Boolean {
        return this.stateId != StateId_Completed && this.timeDeadline.time > ServerTimeManager.serverTimeNow.time;
    }

    public function isActiveOnDate(param1:Date):Boolean {
        return param1.time > this.timeStarted.time && param1.time < this.timeDeadline.time;
    }
}
}
