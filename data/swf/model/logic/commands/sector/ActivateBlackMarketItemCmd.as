package model.logic.commands.sector {
import common.ArrayCustom;
import common.DateUtil;

import model.data.User;
import model.data.acceleration.types.BoostTypeId;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.data.users.blackMarket.UserBmiData;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.UserNoteManager;
import model.logic.blackMarketItems.ActivateItemResponse;
import model.logic.blackMarketItems.BlackMarketItemExpirationData;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.blackMarketItems.BlackMarketVipActivatorData;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;
import model.logic.blackMarketModel.refreshableBehaviours.dates.ExpirableDate;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.quests.completions.QuestCompletionPeriodic;
import model.logic.quests.periodicQuests.enums.PeriodicQuestPrototypeId;
import model.logic.robberyLimitData.RobberyCounterUtility;
import model.logic.vip.VipManager;
import model.logic.vip.VipState;

public class ActivateBlackMarketItemCmd extends BaseCmd {


    private var requestDto;

    public var itemId:int;

    public var autoBuying:Boolean;

    private var _activatedCount:int;

    private var _activateAll:Boolean;

    private var _autoRenew:Object;

    private var _expirationDate:Date;

    public function ActivateBlackMarketItemCmd(param1:int, param2:Boolean = false, param3:Boolean = false, param4:Object = null, param5:int = 1, param6:UserBmiData = null) {
        super();
        this.itemId = param1;
        this.autoBuying = param2;
        this._activateAll = param3;
        this._autoRenew = param4;
        this._activatedCount = param5;
        var _loc7_:Object = {
            "i": param1,
            "a": param4,
            "l": param3,
            "c": param5
        };
        if (param6 != null) {
            _loc7_.b = param6.toDto();
            this._expirationDate = param6.expireDate;
        }
        else {
            this._expirationDate = null;
        }
        this.requestDto = UserRefreshCmd.makeRequestDto(_loc7_);
    }

    private function updateUserLevel(param1:BlackMarketItemRaw):void {
        var _loc2_:User = UserManager.user;
        var _loc3_:VipState = new VipState();
        _loc3_.activatorId = param1.id;
        _loc3_.startTime = !!_loc2_.gameData.vipData.activeState ? _loc2_.gameData.vipData.activeState.startTime : ServerTimeManager.serverTimeNow;
        var _loc4_:Number = !!_loc2_.gameData.vipData.activeState ? Number(_loc2_.gameData.vipData.activeState.endTime.time) : Number(_loc3_.startTime.time);
        _loc4_ = _loc4_ + param1.vipActivatorData.durationSeconds * 1000;
        var _loc5_:Date = new Date(_loc4_);
        _loc3_.endTime = _loc5_;
        _loc2_.gameData.vipData.activeState = _loc3_;
        QuestCompletionPeriodic.tryComplete(null, [PeriodicQuestPrototypeId.ActivateVipStatus]);
        UserNoteManager.getById(_loc2_.id).activeVipLevel = UserManager.user.gameData.vipData.vipLevel;
        RobberyCounterUtility.updateNextAvailableRobberyDate(_loc3_.startTime);
        UserManager.user.gameData.blackMarketData.updateActivators();
    }

    override public function execute():void {
        new JsonCallCmd("BlackMarket.ActivateItem", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc7_:* = undefined;
            var _loc8_:* = undefined;
            var _loc9_:* = undefined;
            var _loc10_:* = undefined;
            var _loc11_:* = undefined;
            var _loc12_:* = undefined;
            var _loc13_:* = undefined;
            var _loc14_:* = undefined;
            var _loc15_:* = undefined;
            var _loc16_:* = undefined;
            var _loc17_:* = undefined;
            var _loc2_:* = UserManager.user;
            var _loc3_:* = StaticDataManager.blackMarketData.itemsById[itemId] as BlackMarketItemRaw;
            if (_loc3_ && _loc3_.resourcesBoostData && _autoRenew) {
                switch (_loc3_.id) {
                    case BlackMarketItemsTypeId.BOOST_RESOURCES_URAN:
                        UserManager.user.gameData.constructionData.resourceMiningBoostAutoRenewalUranium = _autoRenew;
                        break;
                    case BlackMarketItemsTypeId.BOOST_RESOURCES_TITAN:
                        UserManager.user.gameData.constructionData.resourceMiningBoostAutoRenewalTitanite = _autoRenew;
                        break;
                    case BlackMarketItemsTypeId.BOOST_RESOURCES_MONEY:
                        UserManager.user.gameData.constructionData.resourceMiningBoostAutoRenewalMoney = _autoRenew;
                }
            }
            var _loc4_:* = param1.o == null ? null : ActivateItemResponse.fromDto(param1.o);
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc5_ = _loc2_.gameData.blackMarketData.boughtItems;
                _loc6_ = _loc5_[itemId];
                _loc7_ = _activatedCount;
                if (_loc6_) {
                    if (_loc6_.freeCount + _loc6_.paidCount == 1 || _activateAll) {
                        delete _loc5_[itemId];
                    }
                    else if (param1.s) {
                        _loc6_.paidCount = _loc6_.paidCount - _loc7_;
                    }
                    else {
                        _loc6_.freeCount = _loc6_.freeCount - _loc7_;
                    }
                }
                if (_loc3_) {
                    if (_loc3_.vipActivatorData) {
                        updateUserLevel(_loc3_);
                        UserManager.user.gameData.vipData.dirtyVipState = true;
                    }
                    else if (_loc3_.vipPointsData) {
                        UserManager.user.gameData.vipData.vipPoints = UserManager.user.gameData.vipData.vipPoints + _loc3_.vipPointsData.points * _loc7_;
                        _loc8_ = UserManager.user.gameData.vipData.vipLevel;
                        _loc9_ = StaticDataManager.vipData.vipLevelInfoById[_loc8_];
                        _loc10_ = StaticDataManager.vipData.getVipLevelInfoByPoints(UserManager.user.gameData.vipData.vipPoints);
                        if (_loc10_ && _loc9_.level != _loc10_.level) {
                            UserManager.user.gameData.vipData.vipLevel = _loc10_.level;
                            UserManager.user.gameData.vipData.dirtyVipLevel = true;
                            _loc11_ = new BlackMarketItemRaw();
                            _loc11_.id = BlackMarketItemsTypeId.Vip_Activator_1d_bonus;
                            _loc11_.vipActivatorData = new BlackMarketVipActivatorData();
                            _loc11_.vipActivatorData.durationSeconds = 60 * 60 * 24;
                            if (_loc5_[_loc11_.id] == undefined) {
                                _loc5_[_loc11_.id] = new BlackMarketItemsNode();
                            }
                            _loc12_ = _loc5_[_loc11_.id].freeCount;
                            _loc13_ = VipManager.getActiveState() != null;
                            _loc5_[_loc11_.id].freeCount = _loc12_ + (!!_loc13_ ? _loc10_.level - _loc9_.level : _loc10_.level - _loc9_.level - 1);
                            if (!_loc13_) {
                                updateUserLevel(_loc11_);
                            }
                        }
                    }
                    else if (_loc3_.chestData != null) {
                        if (_loc4_ != null) {
                            _loc14_ = _loc4_.chestActivationResult.gems;
                            if (UserManager.user.gameData.gemData.gems == null) {
                                UserManager.user.gameData.gemData.gems = new ArrayCustom();
                            }
                            UserManager.user.gameData.gemData.gems.addAll(_loc14_);
                        }
                        _loc2_.gameData.gemData.dirty = true;
                    }
                    else if (_loc3_.resourcesData != null) {
                        if (_loc3_.resourcesData.resources.uranium) {
                            UserManager.user.gameData.account.resources.uranium = UserManager.user.gameData.account.resources.uranium + _loc7_ * _loc3_.resourcesData.resources.uranium;
                        }
                        else if (_loc3_.resourcesData.resources.titanite) {
                            UserManager.user.gameData.account.resources.titanite = UserManager.user.gameData.account.resources.titanite + _loc7_ * _loc3_.resourcesData.resources.titanite;
                        }
                        else if (_loc3_.resourcesData.resources.money) {
                            UserManager.user.gameData.account.resources.money = UserManager.user.gameData.account.resources.money + _loc7_ * _loc3_.resourcesData.resources.money;
                        }
                        else if (_loc3_.resourcesData.resources.goldMoney) {
                            UserManager.user.gameData.account.resources.goldMoney = UserManager.user.gameData.account.resources.goldMoney + _loc7_ * _loc3_.resourcesData.resources.goldMoney;
                        }
                        else if (_loc3_.resourcesData.resources.biochips) {
                            UserManager.user.gameData.account.resources.biochips = UserManager.user.gameData.account.resources.biochips + _loc7_ * _loc3_.resourcesData.resources.biochips;
                        }
                        else if (_loc3_.resourcesData.resources.avpMoney) {
                            UserManager.user.gameData.account.resources.avpMoney = UserManager.user.gameData.account.resources.avpMoney + _loc3_.resourcesData.resources.avpMoney;
                        }
                        else if (_loc3_.resourcesData.resources.constructionItems) {
                            UserManager.user.gameData.account.resources.constructionItems = UserManager.user.gameData.account.resources.constructionItems + _loc3_.resourcesData.resources.constructionItems;
                        }
                    }
                    else if (_loc3_.resourcesBoostData != null) {
                        if (_loc3_.resourcesBoostData.resources.titanite != 0) {
                            _loc16_ = StaticDataManager.getResourceMiningBoostType(BoostTypeId.RESOURCES_TITANITE, _loc3_.resourcesBoostData.resources.titanite);
                            _loc2_.gameData.constructionData.addOrProlongResourceMiningBoost(_loc3_.resourcesBoostData.durationSeconds * 1000, _loc16_, _loc3_.resourcesBoostData.resources.titanite);
                        }
                        if (_loc3_.resourcesBoostData.resources.uranium != 0) {
                            _loc16_ = StaticDataManager.getResourceMiningBoostType(BoostTypeId.RESOURCES_URANIUM, _loc3_.resourcesBoostData.resources.uranium);
                            _loc2_.gameData.constructionData.addOrProlongResourceMiningBoost(_loc3_.resourcesBoostData.durationSeconds * 1000, _loc16_, _loc3_.resourcesBoostData.resources.uranium);
                        }
                        if (_loc3_.resourcesBoostData.resources.money != 0) {
                            _loc16_ = StaticDataManager.getResourceMiningBoostType(BoostTypeId.RESOURCES_MONEY, _loc3_.resourcesBoostData.resources.money);
                            _loc2_.gameData.constructionData.addOrProlongResourceMiningBoost(_loc3_.resourcesBoostData.durationSeconds * 1000, _loc16_, _loc3_.resourcesBoostData.resources.money);
                        }
                        _loc2_.gameData.constructionData.resourcesBoostChanged = true;
                    }
                    else if (_loc3_.staticBonusPackData != null) {
                        if (_loc4_ != null && _loc4_.staticBonusPackActivationResult != null) {
                            _loc4_.staticBonusPackActivationResult.givePrizeToUser();
                            if (_expirationDate != null) {
                                removeItemByExpirationDate(_loc6_, _expirationDate);
                            }
                            else {
                                removeNearestItem(_loc6_);
                            }
                        }
                    }
                    else if (_loc3_.constructionWorkerData) {
                        if (!UserManager.user.gameData.constructionData.additionalWorkersExpireDateTimes) {
                            UserManager.user.gameData.constructionData.additionalWorkersExpireDateTimes = new ArrayCustom();
                        }
                        _loc17_ = StaticDataManager.blackMarketData.itemsById[BlackMarketItemsTypeId.AdditionalConstructionWorker] as BlackMarketItemRaw;
                        if (_loc17_) {
                            _loc2_.gameData.constructionData.additionalWorkersExpireDateTimes.push(new Date(ServerTimeManager.serverTimeNow.time + _loc17_.constructionWorkerData.duration.milliseconds));
                        }
                        else {
                            _loc2_.gameData.constructionData.additionalWorkersExpireDateTimes.push(new Date(ServerTimeManager.serverTimeNow.time + DateUtil.MILLISECONDS_PER_DAY * 3));
                        }
                        _loc2_.gameData.constructionData.availableWorkersChanged = true;
                    }
                    else if (_loc3_.inventoryItemDestroyerData) {
                        if (!_loc2_.gameData.constructionData.additionalInventoryDestroyerExpireDateTimes) {
                            _loc2_.gameData.constructionData.additionalInventoryDestroyerExpireDateTimes = new ArrayCustom();
                        }
                        if (_loc3_.inventoryItemDestroyerData.duration) {
                            _loc2_.gameData.constructionData.additionalInventoryDestroyerExpireDateTimes.push(new Date(ServerTimeManager.serverTimeNow.time + _loc3_.inventoryItemDestroyerData.duration.milliseconds));
                        }
                        _loc2_.gameData.constructionData.additionalInventoryDestroyerChanged = true;
                    }
                    else if (_loc3_.researcherData) {
                        if (!_loc2_.gameData.constructionData.additionalResearchersExpireDateTimes) {
                            _loc2_.gameData.constructionData.additionalResearchersExpireDateTimes = new ArrayCustom();
                        }
                        if (_loc3_.researcherData.duration) {
                            _loc2_.gameData.constructionData.additionalResearchersExpireDateTimes.push(new Date(ServerTimeManager.serverTimeNow.time + _loc3_.researcherData.duration.milliseconds));
                        }
                        _loc2_.gameData.constructionData.additionalResearcherChanged = true;
                    }
                    else if (_loc3_.resourceConsumptionData) {
                        _loc2_.gameData.constructionData.addOrProlongBoostMoneyConsumption(_loc3_.resourceConsumptionData.durationSeconds * 1000, _loc3_.resourceConsumptionData.resources.money);
                    }
                    else if (_loc3_.resetDailyData) {
                        _loc2_.gameData.questData.dailyData.usedBlackMarketItemResetDailyCount++;
                    }
                    else if (_loc3_.blueLightBonusData) {
                        _loc3_.blueLightBonusData.prize.givePrizeToUser();
                    }
                    else if (_loc3_.additionalRaidLocationsData) {
                        if (_loc2_.gameData.raidData) {
                            _loc2_.gameData.raidData.todayBonusRefreshesCount++;
                        }
                    }
                    else if (_loc3_.levelUpPointsData != null) {
                        _loc2_.gameData.account.levelUpPoints = _loc2_.gameData.account.levelUpPoints + _loc3_.levelUpPointsData.levelUpPoints;
                    }
                    _loc2_.gameData.blackMarketData.dirty = true;
                    _loc2_.gameData.updateObjectsBuyStatus(true);
                    _loc2_.gameData.dispatchEvents();
                }
            }
            if (_onResult != null) {
                _onResult(param1, _loc4_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }

    private function removeNearestItem(param1:BlackMarketItemsNode):void {
        var _loc3_:BlackMarketItemExpirationData = null;
        var _loc4_:BlackMarketItemExpirationData = null;
        if (param1 == null || param1.concreteItems == null) {
            return;
        }
        var _loc2_:Vector.<BlackMarketItemExpirationData> = param1.concreteItems;
        var _loc5_:int = -1;
        var _loc6_:IDynamicDate = new ExpirableDate();
        var _loc7_:int = _loc2_.length - 1;
        while (_loc7_ >= 0) {
            _loc4_ = _loc2_[_loc7_];
            _loc6_.value = _loc4_.expireDate;
            _loc6_.refresh();
            if (!_loc6_.isExpired) {
                if (_loc3_ == null || _loc4_.timeAdded < _loc3_.timeAdded) {
                    _loc3_ = _loc4_;
                    _loc5_ = _loc7_;
                }
            }
            _loc7_--;
        }
        if (_loc3_ != null && _loc5_ != -1) {
            _loc2_.splice(_loc5_, 1);
        }
    }

    private function removeItemByExpirationDate(param1:BlackMarketItemsNode, param2:Date):void {
        if (param1 == null || param1.concreteItems == null) {
            return;
        }
        var _loc3_:int = param1.concreteItems.length - 1;
        while (_loc3_ >= 0) {
            if (param1.concreteItems[_loc3_].expireDate != null && param1.concreteItems[_loc3_].expireDate.time == param2.time) {
                param1.concreteItems.splice(_loc3_, 1);
                break;
            }
            _loc3_--;
        }
    }
}
}
