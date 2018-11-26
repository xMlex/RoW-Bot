package model.logic.ratings {
import common.DateUtil;
import common.queries.util.query;

import configs.Global;

import flash.utils.Dictionary;

import model.data.Resources;
import model.data.UserPrize;
import model.data.quests.Scale;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.BuildingTypeId;
import model.data.scenes.types.info.SaleableLevelInfo;
import model.data.tournaments.TournamentStatistics;
import model.data.tournaments.TournamentStatisticsItem;
import model.data.users.buildings.Sector;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.quests.completions.QuestCompletion;
import model.logic.quests.completions.QuestCompletionTournament;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;
import model.logic.quests.data.TournamentStatisticsType;
import model.modules.dragonAbilities.data.Ability;
import model.modules.dragonAbilities.data.AbilityType;
import model.modules.dragonAbilities.data.AbilityTypeLevelInfo;

public class TournamentBonusManager {

    public static var userRatingBonusesByPrototypeId:Dictionary = new Dictionary();

    public static var allianceRatingBonusesByPrototypeId:Dictionary = new Dictionary();

    public static var userGroupsRatingBonusesByPrototypeId:Dictionary = new Dictionary();

    public static var superLeagueRatingBonusesByPrototypeId:Dictionary = new Dictionary();


    public function TournamentBonusManager() {
        super();
    }

    public static function initUserBonuses(param1:int, param2:Array):void {
        var _loc3_:Dictionary = null;
        var _loc4_:int = 0;
        var _loc5_:Dictionary = null;
        var _loc6_:Scale = null;
        var _loc7_:int = 0;
        var _loc8_:* = undefined;
        var _loc9_:UserPrize = null;
        var _loc10_:int = 0;
        if (param2 != null && param2.length > 0) {
            _loc3_ = new Dictionary();
            _loc4_ = 0;
            while (_loc4_ < param2.length) {
                _loc5_ = new Dictionary();
                _loc6_ = param2[_loc4_];
                _loc7_ = 0;
                for (_loc8_ in _loc6_.items) {
                    if (_loc8_ > _loc7_) {
                        _loc7_ = _loc8_;
                    }
                }
                _loc9_ = null;
                _loc10_ = _loc7_;
                while (_loc10_ >= 0) {
                    if (_loc6_.items[_loc10_] != null) {
                        _loc9_ = UserPrize.fromDto(_loc6_.items[_loc10_][0]);
                    }
                    _loc5_[_loc10_] = _loc9_;
                    _loc10_--;
                }
                _loc3_[_loc4_] = _loc5_;
                _loc4_++;
            }
        }
        userRatingBonusesByPrototypeId[param1] = _loc3_;
    }

    public static function initAllianceBonuses(param1:int, param2:Array):void {
        var _loc3_:Dictionary = null;
        var _loc4_:int = 0;
        var _loc5_:Dictionary = null;
        var _loc6_:Scale = null;
        var _loc7_:int = 0;
        var _loc8_:* = undefined;
        var _loc9_:UserPrize = null;
        var _loc10_:int = 0;
        if (param2 != null && param2.length > 0) {
            _loc3_ = new Dictionary();
            _loc4_ = 0;
            while (_loc4_ < param2.length) {
                _loc5_ = new Dictionary();
                _loc6_ = param2[_loc4_];
                _loc7_ = 0;
                for (_loc8_ in _loc6_.items) {
                    if (_loc8_ > _loc7_) {
                        _loc7_ = _loc8_;
                    }
                }
                _loc9_ = null;
                _loc10_ = _loc7_;
                while (_loc10_ >= 0) {
                    if (_loc6_.items[_loc10_] != null) {
                        _loc9_ = UserPrize.fromDto(_loc6_.items[_loc10_][0]);
                    }
                    _loc5_[_loc10_] = _loc9_;
                    _loc10_--;
                }
                _loc3_[_loc4_] = _loc5_;
                _loc4_++;
            }
        }
        allianceRatingBonusesByPrototypeId[param1] = _loc3_;
    }

    public static function initUserGroupBonuses(param1:int, param2:Array):void {
        userGroupsRatingBonusesByPrototypeId[param1] = param2;
    }

    public static function initSuperLeagueBonuses(param1:int, param2:Scale):void {
        superLeagueRatingBonusesByPrototypeId[param1] = param2;
    }

    public static function applyUserPointsDiff(param1:*):void {
        if (param1 == null) {
            return;
        }
        addTournamentsStatistics(TournamentStatistics.fromDtos(param1));
    }

    public static function addTournamentsStatistics(param1:Array):void {
        var tournamentStatistics:TournamentStatistics = null;
        var state:QuestState = null;
        var completion:QuestCompletionTournament = null;
        var statisticsItem:TournamentStatisticsItem = null;
        var statistics:Array = param1;
        if (statistics == null || statistics.length == 0) {
            return;
        }
        for each(tournamentStatistics in statistics) {
            state = query(UserManager.user.gameData.questData.openedStates).firstOrDefault(function (param1:QuestState):Boolean {
                return param1.prototypeId == tournamentStatistics.prototypeId && param1.questId == tournamentStatistics.questId;
            });
            if (state != null) {
                completion = (state.completions[0] as QuestCompletion).tournament;
                if (completion.gatheredUserPoints == null) {
                    completion.gatheredUserPoints = new Dictionary();
                }
                for each(statisticsItem in tournamentStatistics.statistics) {
                    if (completion.gatheredUserPoints[statisticsItem.statsType] == null) {
                        completion.gatheredUserPoints[statisticsItem.statsType] = statisticsItem.value;
                    }
                    else {
                        completion.gatheredUserPoints[statisticsItem.statsType] = completion.gatheredUserPoints[statisticsItem.statsType] + statisticsItem.value;
                    }
                }
            }
        }
    }

    public static function applyUserPointsDiffForSceneObject(param1:int, param2:GeoSceneObject):void {
        var _loc5_:QuestState = null;
        var _loc6_:int = 0;
        var _loc7_:QuestCompletionTournament = null;
        var _loc8_:Quest = null;
        var _loc9_:* = false;
        var _loc10_:Boolean = false;
        var _loc11_:Number = NaN;
        var _loc12_:TournamentStatisticsItem = null;
        var _loc13_:SaleableLevelInfo = null;
        var _loc14_:Number = NaN;
        var _loc3_:GeoSceneObjectType = StaticDataManager.getObjectType(param2.type.id);
        if (_loc3_ == null || _loc3_.buildingInfo == null && _loc3_.technologyInfo == null || _loc3_.saleableInfo == null || _loc3_.saleableInfo.levelInfos.length == 0 || _loc3_.id == BuildingTypeId.RobotBoostResources) {
            return;
        }
        var _loc4_:Sector = UserManager.user.gameData.sector;
        if (_loc3_.buildingInfo != null && _loc4_.buildingsDeletedByUserTypeIds != null) {
            for each(_loc6_ in _loc4_.buildingsDeletedByUserTypeIds) {
                if (_loc6_ == param2.type.id) {
                    return;
                }
            }
        }
        for each(_loc5_ in UserManager.user.gameData.questData.openedStates) {
            if (!(_loc5_.completions == null || _loc5_.completions.length == 0 || _loc5_.stateId == QuestState.StateId_Completed)) {
                _loc7_ = (_loc5_.completions[0] as QuestCompletion).tournament;
                if (_loc7_ != null) {
                    _loc8_ = UserManager.user.gameData.questData.questById[_loc5_.questId];
                    if (!(_loc8_ == null || _loc8_.tournamentStatisticsWeights == null)) {
                        _loc9_ = DateUtil.compare(_loc5_.timeDeadline, ServerTimeManager.serverTimeNow) == DateUtil.FIRST_BEFORE;
                        if (!_loc9_) {
                            _loc10_ = false;
                            _loc11_ = 0;
                            for each(_loc12_ in _loc8_.tournamentStatisticsWeights) {
                                if (_loc12_.statsType == param1) {
                                    _loc10_ = true;
                                    _loc11_ = _loc12_.value;
                                    break;
                                }
                            }
                            if (_loc10_) {
                                _loc13_ = _loc3_.saleableInfo.levelInfos[param2.getLevel() - 1];
                                _loc14_ = Math.round(Number(_loc13_.constructionSeconds) / 10 / 60 * _loc11_);
                                if (_loc7_.gatheredUserPoints.hasOwnProperty(String(param1))) {
                                    _loc7_.gatheredUserPoints[param1] = _loc7_.gatheredUserPoints[param1] + _loc14_;
                                }
                                else {
                                    _loc7_.gatheredUserPoints[param1] = _loc14_;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    public static function applyUserPointsDiffForDynamicMineResources(param1:Resources):Quest {
        var _loc3_:Quest = null;
        var _loc4_:QuestState = null;
        var _loc5_:QuestCompletionTournament = null;
        var _loc6_:Quest = null;
        var _loc7_:* = false;
        var _loc8_:Boolean = false;
        var _loc9_:Number = NaN;
        var _loc10_:int = 0;
        var _loc11_:TournamentStatisticsItem = null;
        var _loc12_:Number = NaN;
        var _loc2_:Resources = StaticDataManager.tournamentCollectedResourcesCoefs;
        for each(_loc4_ in UserManager.user.gameData.questData.openedStates) {
            if (!(_loc4_.completions == null || _loc4_.completions.length == 0 || _loc4_.stateId == QuestState.StateId_Completed)) {
                _loc5_ = (_loc4_.completions[0] as QuestCompletion).tournament;
                if (_loc5_ != null) {
                    _loc6_ = UserManager.user.gameData.questData.questById[_loc4_.questId];
                    if (!(_loc6_ == null || _loc6_.tournamentStatisticsWeights == null)) {
                        _loc7_ = DateUtil.compare(_loc4_.timeDeadline, ServerTimeManager.serverTimeNow) == DateUtil.FIRST_BEFORE;
                        if (!_loc7_) {
                            _loc8_ = false;
                            _loc9_ = 0;
                            _loc10_ = 0;
                            for each(_loc11_ in _loc6_.tournamentStatisticsWeights) {
                                if (_loc11_.statsType == TournamentStatisticsType.DynamicMineResourcesCollected || _loc11_.statsType == TournamentStatisticsType.DynamicMineResourcesCollectedAvp) {
                                    _loc8_ = true;
                                    _loc9_ = _loc11_.value;
                                    _loc10_ = _loc11_.statsType;
                                    break;
                                }
                            }
                            if (_loc8_) {
                                _loc12_ = 0;
                                if (_loc11_.statsType == TournamentStatisticsType.DynamicMineResourcesCollected) {
                                    if (param1.goldMoney > 0) {
                                        _loc12_ = _loc12_ + param1.goldMoney * _loc2_.goldMoney;
                                    }
                                    if (param1.avpMoney > 0) {
                                        _loc12_ = _loc12_ + param1.avpMoney * _loc2_.avpMoney;
                                    }
                                    if (param1.titanite > 0) {
                                        _loc12_ = _loc12_ + param1.titanite * _loc2_.titanite;
                                    }
                                    if (param1.uranium > 0) {
                                        _loc12_ = _loc12_ + param1.uranium * _loc2_.uranium;
                                    }
                                    if (param1.money > 0) {
                                        _loc12_ = _loc12_ + param1.money * _loc2_.money;
                                    }
                                    if (param1.biochips > 0) {
                                        _loc12_ = _loc12_ + param1.biochips * _loc2_.biochips;
                                    }
                                    if (param1.blackCrystals > 0) {
                                        _loc12_ = _loc12_ + param1.blackCrystals * _loc2_.blackCrystals;
                                    }
                                    _loc11_.value = _loc12_;
                                    if (_loc12_ >= 1) {
                                        _loc3_ = _loc6_;
                                    }
                                }
                                if (_loc11_.statsType == TournamentStatisticsType.DynamicMineResourcesCollectedAvp && _loc2_) {
                                    if (param1.avpMoney > 0) {
                                        _loc12_ = _loc12_ + param1.avpMoney * _loc2_.avpMoney;
                                        _loc11_.value = _loc12_;
                                        if (_loc12_ >= 1) {
                                            _loc3_ = _loc6_;
                                        }
                                    }
                                }
                                if (_loc5_.gatheredUserPoints.hasOwnProperty(String(_loc10_))) {
                                    _loc5_.gatheredUserPoints[_loc10_] = _loc5_.gatheredUserPoints[_loc10_] + _loc12_;
                                }
                                else {
                                    _loc5_.gatheredUserPoints[_loc10_] = _loc12_;
                                }
                            }
                        }
                    }
                }
            }
        }
        return _loc3_;
    }

    public static function applyUserPointsDiffForDragonAbility(param1:int, param2:Ability):void {
        var _loc4_:QuestState = null;
        var _loc5_:QuestCompletionTournament = null;
        var _loc6_:Quest = null;
        var _loc7_:* = false;
        var _loc8_:Boolean = false;
        var _loc9_:Number = NaN;
        var _loc10_:TournamentStatisticsItem = null;
        var _loc11_:AbilityTypeLevelInfo = null;
        var _loc12_:Number = NaN;
        var _loc13_:Number = NaN;
        if (param2 == null) {
            return;
        }
        var _loc3_:AbilityType = param2.abilityType;
        if (_loc3_ == null || _loc3_.levelInfos.length == 0) {
            return;
        }
        for each(_loc4_ in UserManager.user.gameData.questData.openedStates) {
            if (!(_loc4_.completions == null || _loc4_.completions.length == 0 || _loc4_.stateId == QuestState.StateId_Completed)) {
                _loc5_ = (_loc4_.completions[0] as QuestCompletion).tournament;
                if (_loc5_ != null) {
                    _loc6_ = UserManager.user.gameData.questData.questById[_loc4_.questId];
                    if (!(_loc6_ == null || _loc6_.tournamentStatisticsWeights == null)) {
                        _loc7_ = DateUtil.compare(_loc4_.timeDeadline, ServerTimeManager.serverTimeNow) == DateUtil.FIRST_BEFORE;
                        if (!_loc7_) {
                            _loc8_ = false;
                            _loc9_ = 0;
                            for each(_loc10_ in _loc6_.tournamentStatisticsWeights) {
                                if (_loc10_.statsType == param1) {
                                    _loc8_ = true;
                                    _loc9_ = _loc10_.value;
                                    break;
                                }
                            }
                            if (_loc8_) {
                                _loc11_ = param2.currentLevelInfo;
                                _loc12_ = !!_loc11_ ? Number(_loc11_.improvementSeconds) : Number(0);
                                _loc13_ = Math.round(_loc12_ / 6 / 60 * _loc9_);
                                if (_loc5_.gatheredUserPoints.hasOwnProperty(String(param1))) {
                                    _loc5_.gatheredUserPoints[param1] = _loc5_.gatheredUserPoints[param1] + _loc13_;
                                }
                                else {
                                    _loc5_.gatheredUserPoints[param1] = _loc13_;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    public static function applyUserPointsDiffForMonsterKill(param1:Number):void {
        var _loc2_:QuestState = null;
        var _loc3_:QuestCompletionTournament = null;
        var _loc4_:Quest = null;
        var _loc5_:* = false;
        var _loc6_:Boolean = false;
        var _loc7_:Number = NaN;
        var _loc8_:TournamentStatisticsItem = null;
        var _loc9_:Number = NaN;
        if (param1 <= 0) {
            return;
        }
        for each(_loc2_ in UserManager.user.gameData.questData.openedStates) {
            if (!(_loc2_.completions == null || _loc2_.completions.length == 0 || _loc2_.stateId == QuestState.StateId_Completed)) {
                _loc3_ = (_loc2_.completions[0] as QuestCompletion).tournament;
                if (_loc3_ != null) {
                    _loc4_ = UserManager.user.gameData.questData.questById[_loc2_.questId];
                    if (!(_loc4_ == null || _loc4_.tournamentStatisticsWeights == null)) {
                        _loc5_ = DateUtil.compare(_loc2_.timeDeadline, ServerTimeManager.serverTimeNow) == DateUtil.FIRST_BEFORE;
                        if (!_loc5_) {
                            _loc6_ = false;
                            _loc7_ = 0;
                            for each(_loc8_ in _loc4_.tournamentStatisticsWeights) {
                                if (_loc8_.statsType == TournamentStatisticsType.DragonMonsterKilled) {
                                    _loc6_ = true;
                                    _loc7_ = _loc8_.value;
                                    break;
                                }
                            }
                            if (_loc6_) {
                                _loc9_ = param1 * Global.DRAGON_POINT_TOURNAMENT_COEFFICIENT;
                                if (_loc3_.gatheredUserPoints.hasOwnProperty(String(TournamentStatisticsType.DragonMonsterKilled))) {
                                    _loc3_.gatheredUserPoints[TournamentStatisticsType.DragonMonsterKilled] = _loc3_.gatheredUserPoints[TournamentStatisticsType.DragonMonsterKilled] + _loc9_;
                                }
                                else {
                                    _loc3_.gatheredUserPoints[TournamentStatisticsType.DragonMonsterKilled] = _loc9_;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    public static function updateUserPointsForFlagCapture(param1:Number):void {
        var _loc2_:QuestState = null;
        var _loc3_:QuestCompletionTournament = null;
        var _loc4_:Quest = null;
        var _loc5_:* = false;
        var _loc6_:Boolean = false;
        var _loc7_:Number = NaN;
        var _loc8_:TournamentStatisticsItem = null;
        if (param1 <= 0) {
            return;
        }
        for each(_loc2_ in UserManager.user.gameData.questData.openedStates) {
            if (!(_loc2_.completions == null || _loc2_.completions.length == 0 || _loc2_.stateId == QuestState.StateId_Completed)) {
                _loc3_ = (_loc2_.completions[0] as QuestCompletion).tournament;
                if (_loc3_ != null) {
                    _loc4_ = UserManager.user.gameData.questData.questById[_loc2_.questId];
                    if (!(_loc4_ == null || _loc4_.tournamentStatisticsWeights == null)) {
                        _loc5_ = DateUtil.compare(_loc2_.timeDeadline, ServerTimeManager.serverTimeNow) == DateUtil.FIRST_BEFORE;
                        if (!_loc5_) {
                            _loc6_ = false;
                            _loc7_ = 0;
                            for each(_loc8_ in _loc4_.tournamentStatisticsWeights) {
                                if (_loc8_.statsType == TournamentStatisticsType.AllianceCityFlags) {
                                    _loc6_ = true;
                                    _loc7_ = _loc8_.value;
                                    break;
                                }
                            }
                            if (_loc6_) {
                                _loc3_.gatheredAlliancePoints = param1;
                            }
                        }
                    }
                }
            }
        }
    }
}
}
