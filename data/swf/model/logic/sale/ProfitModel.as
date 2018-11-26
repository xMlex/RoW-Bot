package model.logic.sale {
import common.ArrayCustom;
import common.GameType;

import flash.utils.Dictionary;

import integration.SocialNetworkIdentifier;

import model.data.Resources;
import model.data.ResourcesKit;
import model.data.UserPrize;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.data.scenes.types.info.TroopsTypeId;
import model.data.temporarySkins.TemporarySkin;
import model.logic.BlackMarketTroopsType;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;
import model.modules.dragonAbilities.data.resources.DragonResources;

public class ProfitModel {

    private static var blackMarketItemsWithoutPrice:Dictionary = new Dictionary();

    private static var troopsWithoutPrice:Dictionary = new Dictionary();

    private static const blackCrystalPrice:int = 25;

    private static const dragonResourcesPrice:int = 500;

    {
        blackMarketItemsWithoutPrice[BlackMarketItemsTypeId.Vip_Activator_30m] = 15;
        blackMarketItemsWithoutPrice[BlackMarketItemsTypeId.Vip_Activator_60m] = 25;
        blackMarketItemsWithoutPrice[BlackMarketItemsTypeId.Vip_Points_5] = 80;
        troopsWithoutPrice[TroopsTypeId.EarlyIncubatorUnit3] = 25;
        troopsWithoutPrice[TroopsTypeId.RedUnit1] = 25;
        troopsWithoutPrice[TroopsTypeId.RedUnit2] = 50;
        troopsWithoutPrice[TroopsTypeId.RedUnit3] = 60;
        troopsWithoutPrice[TroopsTypeId.RedUnit4] = 120;
        troopsWithoutPrice[TroopsTypeId.RedUnit5] = 80;
        troopsWithoutPrice[TroopsTypeId.RedUnit6] = 170;
        troopsWithoutPrice[TroopsTypeId.RedUnit7] = 10;
        troopsWithoutPrice[TroopsTypeId.RedUnit8] = 10;
    }

    private var _currentQuestState:QuestState;

    private var _quest:Quest;

    private var _profit:Number;

    private var _totalCost:Number;

    public function ProfitModel(param1:int, param2:QuestState, param3:Quest, param4:int) {
        super();
        this._currentQuestState = param2;
        this._quest = param3;
        var _loc5_:UserPrize = this._currentQuestState.bonuses;
        if (this._quest != null && this._quest.bonuses != null) {
            _loc5_ = this._quest.bonuses;
        }
        if (GameType.isNords && SocialNetworkIdentifier.isFB) {
            this._profit = param3.bonusPercents;
            this._totalCost = param3.bonusPercents * param1 / 100;
        }
        else {
            this._totalCost = calculateSaleTotalCost(_loc5_);
            this._profit = this._totalCost / (param1 + param4) * 100;
        }
    }

    public static function calculateSaleTotalCost(param1:UserPrize):int {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc5_:Resources = null;
        var _loc6_:TemporarySkin = null;
        var _loc7_:DragonResources = null;
        var _loc2_:int = 0;
        if (param1.blackMarketItems) {
            for (_loc3_ in param1.blackMarketItems) {
                _loc2_ = _loc2_ + returnBlackMarketItemPrice(_loc3_, param1);
            }
        }
        if (param1.troops) {
            for (_loc4_ in param1.troops.countByType) {
                _loc2_ = _loc2_ + returnUnitPrice(_loc4_) * param1.troops.countByType[_loc4_];
            }
        }
        if (param1.constructionWorkers) {
            _loc5_ = StaticDataManager.constructionData.getNextWorkerPrice(UserManager.user.gameData.constructionData.constructionWorkersCount);
            if (_loc5_) {
                _loc2_ = _loc2_ + param1.constructionWorkers * _loc5_.goldMoney;
            }
        }
        if (param1.resources) {
            if (param1.resources.money > 0) {
                _loc2_ = _loc2_ + returnMoneyPrice(param1.resources.money);
            }
            if (param1.resources.uranium > 0) {
                _loc2_ = _loc2_ + returnUraniumPrice(param1.resources.uranium);
            }
            if (param1.resources.titanite > 0) {
                _loc2_ = _loc2_ + returnTitanitePrice(param1.resources.titanite);
            }
            if (param1.resources.blackCrystals > 0) {
                _loc2_ = _loc2_ + returnBlackCrystalsPrice(param1.resources.blackCrystals);
            }
        }
        if (param1.temporarySkins != null) {
            for each(_loc6_ in param1.temporarySkins) {
                _loc2_ = _loc2_ + (_loc6_.price != null ? _loc6_.price.goldMoney : 0);
            }
        }
        if (param1.dragonResources != null) {
            _loc7_ = DragonResources(param1.dragonResources);
            if (_loc7_.jade > 0) {
                _loc2_ = _loc2_ + _loc7_.jade * dragonResourcesPrice;
            }
            if (_loc7_.opal > 0) {
                _loc2_ = _loc2_ + _loc7_.opal * dragonResourcesPrice;
            }
            if (_loc7_.ruby > 0) {
                _loc2_ = _loc2_ + _loc7_.ruby * dragonResourcesPrice;
            }
        }
        return _loc2_;
    }

    private static function returnBlackMarketItemPrice(param1:int, param2:Object):int {
        var _loc3_:int = 0;
        var _loc4_:BlackMarketItemRaw = StaticDataManager.blackMarketData.itemsById[param1];
        if (_loc4_ && _loc4_.price) {
            _loc3_ = _loc4_.price.goldMoney * param2.blackMarketItems[param1];
        }
        return _loc3_;
    }

    private static function returnMoneyPrice(param1:int):int {
        var _loc3_:ResourcesKit = null;
        var _loc2_:int = 0;
        while (_loc2_ < StaticDataManager.resourcesKits.length) {
            _loc3_ = StaticDataManager.resourcesKits[_loc2_];
            if (!(!_loc3_ || !_loc3_.resources || !_loc3_.price)) {
                if (_loc3_.resources.money > 0) {
                    return _loc3_.price.goldMoney / _loc3_.resources.money * param1;
                }
            }
            _loc2_++;
        }
        return 0;
    }

    private static function returnUraniumPrice(param1:int):int {
        var _loc3_:ResourcesKit = null;
        var _loc2_:int = 0;
        while (_loc2_ < StaticDataManager.resourcesKits.length) {
            _loc3_ = StaticDataManager.resourcesKits[_loc2_];
            if (!(!_loc3_ || !_loc3_.resources || !_loc3_.price)) {
                if (_loc3_.resources.uranium > 0) {
                    return _loc3_.price.goldMoney / _loc3_.resources.uranium * param1;
                }
            }
            _loc2_++;
        }
        return 0;
    }

    private static function returnBlackCrystalsPrice(param1:int):int {
        return param1 * blackCrystalPrice;
    }

    private static function returnTitanitePrice(param1:int):int {
        var _loc3_:ResourcesKit = null;
        var _loc2_:int = 0;
        while (_loc2_ < StaticDataManager.resourcesKits.length) {
            _loc3_ = StaticDataManager.resourcesKits[_loc2_];
            if (!(!_loc3_ || !_loc3_.resources || !_loc3_.price)) {
                if (_loc3_.resources.titanite > 0) {
                    return _loc3_.price.goldMoney / _loc3_.resources.titanite * param1;
                }
            }
            _loc2_++;
        }
        return 0;
    }

    private static function returnUnitPrice(param1:int):int {
        var _loc4_:BlackMarketTroopsType = null;
        var _loc2_:ArrayCustom = StaticDataManager.blackMarketData.troopTypes;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length) {
            _loc4_ = _loc2_[_loc3_] as BlackMarketTroopsType;
            if (param1 == _loc4_.troopsTypeId) {
                return !!_loc4_.price ? int(_loc4_.price.goldMoney) : 0;
            }
            _loc3_++;
        }
        if (troopsWithoutPrice[param1]) {
            return troopsWithoutPrice[param1];
        }
        return 0;
    }

    public function get profit():Number {
        return this._profit;
    }

    public function get totalCost():Number {
        return this._totalCost;
    }
}
}
