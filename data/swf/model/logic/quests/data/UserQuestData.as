package model.logic.quests.data {
import common.queries.util.query;

import configs.Global;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.data.quests.QuestPrototypeId;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.quests.completions.QuestCompletion;
import model.logic.quests.completions.QuestCompletionCollectibleThemedItemsEvent;
import model.logic.quests.data.themedEvent.BlackMarketThemedEventBonusCreator;
import model.logic.quests.data.themedEvent.BuildingThemedEventBonusCreator;
import model.logic.quests.data.themedEvent.TechnologyThemedEventBonusCreator;
import model.logic.quests.data.themedEvent.ThemedBonusCreator;
import model.logic.quests.periodicQuests.userData.UserPeriodicQuestData;

public class UserQuestData extends ObservableObject {

    public static const CLASS_NAME:String = "UserQuestData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";

    public static const TOURNAMENTS_DATA_CHANGED:String = CLASS_NAME + "TournamentsChanged";

    public static const COLLECTIBLE_THEMED_ITEMS_EVENT_DATA_CHANGED:String = CLASS_NAME + "CollectibleThemedItemsEvent";

    public static const MINES_DATA_CHANGED:String = CLASS_NAME + "MinesChanged";

    public static const DYNAMIC_MINES_DATA_CHANGED:String = CLASS_NAME + "DynamicMinesChanged";

    public static const ROBBERY_DATA_CHANGED:String = CLASS_NAME + "RobberyChanged";

    public static const QUEST_COMPLETE:String = CLASS_NAME + "Complete";

    public static const LOTTERY_DATA_CHANGED:String = CLASS_NAME + "Complete";

    public static const PERIODIC_DATA_CHANGED:String = CLASS_NAME + "PeriodicChanged";

    public static const PERIODIC_QUEST_COMPLETED:String = CLASS_NAME + "PeriodicQuestCompleted";


    public var openedStates:Array;

    public var periodicData:UserPeriodicQuestData;

    public var discountData:UserQuestDataDiscount;

    public var dataRobbery:UserQuestDataRobbery;

    public var dailyData:UserQuestDataDaily;

    public var fluentData:UserQuestDataFluent;

    public var wizardData:UserQuestDataWizard;

    public var wizardCompletedPrototypeIds:Array;

    public var questsForAutoRefresh:Array;

    public var hasCompletedMineQuest:Boolean;

    public var dirty:Boolean;

    public var dirtyTournaments:Boolean;

    public var dirtyCollectibleThemedItemsEvent:Boolean;

    public var dirtyPeriodicQuest:Boolean;

    public var dirtyRobberyQuest:Boolean;

    public var dirtyMinesQuest:Boolean;

    public var dirtyLotteryQuest:Boolean;

    public var dirtyStoragesQuest:Boolean;

    public var activeThemedEvent:QuestState;

    private var _questById:Dictionary;

    public function UserQuestData() {
        this._questById = new Dictionary();
        super();
    }

    public static function fromDto(param1:*):UserQuestData {
        if (param1 == null) {
            return new UserQuestData();
        }
        var _loc2_:UserQuestData = new UserQuestData();
        _loc2_.openedStates = QuestState.fromDtos(param1.q);
        _loc2_.activeThemedEvent = _loc2_.findActiveThemedEvent();
        _loc2_.discountData = param1.e == null ? null : UserQuestDataDiscount.fromDto(param1.e);
        _loc2_.wizardCompletedPrototypeIds = param1.c;
        _loc2_.hasCompletedMineQuest = param1.f != null;
        _loc2_.dataRobbery = param1.b == null ? null : UserQuestDataRobbery.fromDto(param1.b);
        _loc2_.dailyData = param1.a == null ? null : UserQuestDataDaily.fromDto(param1.a);
        _loc2_.questsForAutoRefresh = [];
        _loc2_.questsForAutoRefresh = _loc2_.questsForAutoRefresh.concat(_loc2_.openedStates);
        _loc2_.fluentData = param1.l == null ? null : UserQuestDataFluent.fromDto(param1.l);
        _loc2_.wizardData = param1.k == null ? null : UserQuestDataWizard.fromDto(param1.k);
        _loc2_.periodicData = param1.p == null ? null : UserPeriodicQuestData.fromDto(param1.p);
        return _loc2_;
    }

    public function setQuestById(param1:Array):void {
        var _loc2_:Quest = null;
        for each(_loc2_ in param1) {
            this._questById[_loc2_.id] = _loc2_;
        }
    }

    public function get questById():Dictionary {
        return this._questById;
    }

    public function getQuestById(param1:int):Quest {
        return this._questById[param1];
    }

    public function getQuestStateByPrototypeID(param1:int):QuestState {
        var _loc2_:int = 0;
        while (_loc2_ < this.openedStates.length) {
            if (this.openedStates[_loc2_].prototypeId == param1) {
                return this.openedStates[_loc2_];
            }
            _loc2_++;
        }
        return null;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(DATA_CHANGED);
        }
        if (this.dirtyTournaments) {
            this.dirtyTournaments = false;
            dispatchEvent(TOURNAMENTS_DATA_CHANGED);
        }
        if (this.dirtyCollectibleThemedItemsEvent) {
            this.dirtyCollectibleThemedItemsEvent = false;
            dispatchEvent(COLLECTIBLE_THEMED_ITEMS_EVENT_DATA_CHANGED);
        }
        if (this.dirtyRobberyQuest) {
            this.dirtyRobberyQuest = false;
            dispatchEvent(ROBBERY_DATA_CHANGED);
        }
        if (this.dirtyMinesQuest) {
            this.dirtyMinesQuest = false;
            dispatchEvent(MINES_DATA_CHANGED);
        }
        if (this.dirtyStoragesQuest) {
            this.dirtyStoragesQuest = false;
            dispatchEvent(DYNAMIC_MINES_DATA_CHANGED);
        }
        if (this.dirtyLotteryQuest) {
            this.dirtyLotteryQuest = false;
            dispatchEvent(LOTTERY_DATA_CHANGED);
        }
        if (this.dirtyPeriodicQuest) {
            this.dirtyPeriodicQuest = false;
            dispatchEvent(PERIODIC_DATA_CHANGED);
        }
    }

    public function hasOpenedQuest(param1:int):Boolean {
        var _loc2_:QuestState = null;
        if (!this.openedStates) {
            return false;
        }
        for each(_loc2_ in this.openedStates) {
            if (_loc2_.prototypeId == param1) {
                return true;
            }
        }
        return false;
    }

    public function getClosedGlobalMissions():int {
        var _loc2_:QuestState = null;
        var _loc1_:int = 0;
        for each(_loc2_ in this.openedStates) {
            if (!(!_loc2_ || !_loc2_.completions || _loc2_.completions.length == 0)) {
                if ((_loc2_.completions[0] as QuestCompletion).globalMission && _loc2_.stateId == QuestState.StateId_Completed) {
                    _loc1_++;
                }
            }
        }
        return _loc1_;
    }

    public function getQuestStateByQuestId(param1:int):QuestState {
        var _loc2_:QuestState = null;
        for each(_loc2_ in this.openedStates) {
            if (_loc2_.questId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function readQuest(param1:QuestState):void {
        if (!param1 || param1.isRead) {
            return;
        }
        param1.isRead = true;
        UserRefreshCmd.readQuest(param1.questId);
        this.dirty = true;
    }

    public function addCollectibleItemsFromBMI(param1:Number):void {
        this.addCollectibleItems(param1, BlackMarketThemedEventBonusCreator);
    }

    public function addCollectibleItemsFromBuilding(param1:Number):void {
        this.addCollectibleItems(param1, BuildingThemedEventBonusCreator);
    }

    public function addCollectibleItemsFromTechnology(param1:Number):void {
        this.addCollectibleItems(param1, TechnologyThemedEventBonusCreator);
    }

    private function findActiveThemedEvent():QuestState {
        return query(this.openedStates).firstOrDefault(function (param1:QuestState):Boolean {
            return param1.prototypeId >= QuestPrototypeId.CollectibleThemedItemsMin && param1.prototypeId <= QuestPrototypeId.CollectibleThemedItemsMax && param1.isActual();
        });
    }

    private function addCollectibleItems(param1:Number, param2:Class):void {
        if (this.activeThemedEvent == null || !Global.COLLECTIBLE_THEMED_ITEMS_EVENT_ENABLED) {
            return;
        }
        var _loc3_:ThemedBonusCreator = new param2();
        var _loc4_:Array = _loc3_.bonus();
        var _loc5_:QuestCompletionCollectibleThemedItemsEvent = this.activeThemedEvent.completion.collectibleThemedItemsEvent;
        _loc5_.collectItems(_loc4_, param1);
    }
}
}
