package model.data.users.misc {
import common.ArrayCustom;
import common.queries.util.query;

import configs.Global;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.data.users.blackMarket.UserBmiData;
import model.logic.BlackMarketTroopsType;
import model.logic.StaticBlackMarketData;
import model.logic.StaticDataManager;
import model.logic.blackMarketItems.BlackMarketItemExpirationData;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.blackMarketItems.BlackMarketVipActivatorData;

public class UserBlackMarketData extends ObservableObject implements INormalizable {

    private static const ALLIANCE_MISSION_CHESTS:Array = [BlackMarketItemsTypeId.StaticBonusPackAllianceMissionStep1, BlackMarketItemsTypeId.StaticBonusPackAllianceMissionStep2, BlackMarketItemsTypeId.StaticBonusPackAllianceMissionStep3, BlackMarketItemsTypeId.StaticBonusPackAllianceMissionStep4, BlackMarketItemsTypeId.StaticBonusPackAllianceMissionStep5];

    private static const GACHA_CHESTS:Array = [BlackMarketItemsTypeId.GachaChestBronze, BlackMarketItemsTypeId.GachaChestGold, BlackMarketItemsTypeId.GachaChestPlatinum, BlackMarketItemsTypeId.GachaChestSilver, BlackMarketItemsTypeId.GachaChestStone];

    public static const CLASS_NAME:String = "UserBlackMarketData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";

    public static const CHESTS_DATA_CHANGED:String = CLASS_NAME + "ChestsChanged";


    public var dirty:Boolean;

    public var chestsDirty:Boolean;

    public var strategyTroopsPurchasesCount:int;

    public var troopsPurchasesCount:int;

    public var drawingsPurchasesCount:int;

    public var buildingsPurchasesCount:int;

    public var boughtCountBySceneObjectTypeId:Dictionary;

    public var boughtCountByItemPackId:Dictionary;

    private var _boughtItems:Dictionary;

    private var _boughtSeparatedItems:Dictionary;

    public var boughtActivatorsByTime:Dictionary;

    public var purchaseCountById:Dictionary;

    private var _lastNormalizationDate:Date;

    private var _lastDate:Date;

    public function UserBlackMarketData() {
        super();
        this.boughtCountBySceneObjectTypeId = new Dictionary();
        this.boughtItems = new Dictionary();
        this.boughtActivatorsByTime = new Dictionary();
    }

    public static function fromDto(param1:*):UserBlackMarketData {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc5_:* = undefined;
        var _loc2_:UserBlackMarketData = new UserBlackMarketData();
        _loc2_.strategyTroopsPurchasesCount = param1.sc;
        _loc2_.troopsPurchasesCount = param1.tc;
        _loc2_.drawingsPurchasesCount = param1.dc;
        _loc2_.buildingsPurchasesCount = param1.bc;
        _loc2_.boughtCountBySceneObjectTypeId = new Dictionary();
        if (param1.a != null) {
            for (_loc3_ in param1.a) {
                _loc2_.boughtCountBySceneObjectTypeId[_loc3_] = param1.a[_loc3_];
            }
        }
        _loc2_.boughtCountByItemPackId = new Dictionary();
        if (param1.pt != null) {
            for (_loc4_ in param1.pt) {
                _loc2_.boughtCountByItemPackId[_loc4_] = param1.pt[_loc4_];
            }
        }
        _loc2_.purchaseCountById = new Dictionary();
        if (param1.c != null) {
            for (_loc5_ in param1.c) {
                _loc2_.purchaseCountById[_loc5_] = true;
            }
        }
        if (param1.bmi != null) {
            _loc2_.boughtItems = _loc2_.parseBoughItemsNew(param1.bmi);
        }
        _loc2_.updateActivators();
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function getStrategyTroops():ArrayCustom {
        var _loc2_:GeoSceneObjectType = null;
        var _loc3_:BlackMarketTroopsType = null;
        var _loc1_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in StaticDataManager.blackMarketData.troopTypes) {
            _loc2_ = StaticDataManager.getObjectType(_loc3_.troopsTypeId);
            if (_loc2_ != null) {
                if (_loc2_.isStrategyUnit) {
                    _loc1_.addItem(_loc3_);
                }
            }
        }
        return _loc1_;
    }

    public function updateActivators():void {
        var _loc2_:* = undefined;
        var _loc3_:BlackMarketItemRaw = null;
        var _loc4_:BlackMarketVipActivatorData = null;
        var _loc5_:Number = NaN;
        var _loc6_:int = 0;
        var _loc1_:int = 0;
        this.boughtActivatorsByTime = new Dictionary();
        for (_loc2_ in this.boughtItems) {
            _loc3_ = StaticDataManager.blackMarketData.itemsById[_loc2_];
            _loc4_ = !!_loc3_ ? _loc3_.vipActivatorData : null;
            if (_loc4_) {
                _loc5_ = _loc4_.durationSeconds;
                if (this.boughtActivatorsByTime[_loc5_] == undefined) {
                    this.boughtActivatorsByTime[_loc5_] = new ArrayCustom();
                }
                _loc1_ = this.boughtItems[_loc2_] != undefined ? int(this.boughtItems[_loc2_].freeCount + this.boughtItems[_loc2_].paidCount) : 0;
                _loc6_ = 0;
                while (_loc6_ < _loc1_) {
                    this.boughtActivatorsByTime[_loc5_].push(_loc3_);
                    _loc6_++;
                }
                continue;
            }
        }
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(DATA_CHANGED);
        }
        if (this.chestsDirty) {
            this.chestsDirty = false;
            dispatchEvent(CHESTS_DATA_CHANGED);
        }
    }

    public function get boughtItems():Dictionary {
        return this._boughtSeparatedItems;
    }

    public function set boughtItems(param1:Dictionary):void {
        this._boughtSeparatedItems = param1;
        this.updateActivators();
    }

    public function set boughtItemsForRefresh(param1:Dictionary):void {
        this._boughtSeparatedItems = this.refreshBonusItems(param1);
        this.updateActivators();
    }

    public function parseBoughItemsNew(param1:Object):Dictionary {
        var _loc4_:String = null;
        var _loc5_:* = null;
        var _loc6_:* = undefined;
        var _loc7_:BlackMarketItemsNode = null;
        var _loc8_:int = 0;
        var _loc9_:int = 0;
        var _loc10_:BlackMarketItemRaw = null;
        var _loc11_:Date = null;
        var _loc12_:Date = null;
        var _loc13_:BlackMarketItemExpirationData = null;
        var _loc2_:Dictionary = new Dictionary();
        var _loc3_:StaticBlackMarketData = StaticDataManager.blackMarketData;
        for (_loc5_ in param1) {
            _loc6_ = param1[_loc5_];
            _loc7_ = new BlackMarketItemsNode();
            _loc7_.paidCount = _loc6_.c;
            if (_loc6_.e != null) {
                _loc8_ = _loc6_.e.length;
                _loc9_ = 0;
                while (_loc9_ < _loc8_) {
                    _loc10_ = _loc3_.itemsById[_loc5_];
                    if (_loc10_ == null) {
                        throw new Error("Item with id=" + _loc5_ + " is missing in static data");
                    }
                    if (_loc10_ != null && _loc10_.lifeTime != null) {
                        _loc11_ = new Date(_loc6_.e[_loc9_]);
                        _loc12_ = new Date(_loc6_.e[_loc9_]);
                        _loc12_.time = _loc12_.time - _loc10_.lifeTime.time;
                        _loc13_ = new BlackMarketItemExpirationData(-1, _loc12_);
                        _loc13_.expireDate = _loc11_;
                        _loc7_.concreteItems.push(_loc13_);
                    }
                    _loc9_++;
                }
            }
            _loc2_[_loc4_] = _loc7_;
        }
        return _loc2_;
    }

    public function refreshBonusItems(param1:Dictionary):Dictionary {
        var _loc3_:* = undefined;
        var _loc2_:Dictionary = this.boughtItems;
        if (param1 != null) {
            for (_loc3_ in param1) {
                if (_loc2_[_loc3_] == undefined) {
                    _loc2_[_loc3_] = new BlackMarketItemsNode();
                }
                _loc2_[_loc3_].freeCount = _loc2_[_loc3_].freeCount + param1[_loc3_];
            }
        }
        return _loc2_;
    }

    public function deleteAllActiveAllianceMissionChests():void {
        var _loc2_:int = 0;
        var _loc3_:BlackMarketItemsNode = null;
        var _loc4_:int = 0;
        var _loc5_:BlackMarketItemExpirationData = null;
        var _loc1_:int = 0;
        while (_loc1_ < ALLIANCE_MISSION_CHESTS.length) {
            _loc2_ = ALLIANCE_MISSION_CHESTS[_loc1_];
            _loc3_ = this.boughtItems[_loc2_];
            if (!(_loc3_ == null || _loc3_.concreteItems == null)) {
                _loc4_ = _loc3_.concreteItems.length - 1;
                while (_loc4_ >= 0) {
                    _loc5_ = _loc3_.concreteItems[_loc4_];
                    if (!_loc5_.isExpired()) {
                        _loc3_.concreteItems.splice(_loc4_, 1);
                        _loc3_.paidCount--;
                    }
                    _loc4_--;
                }
            }
            _loc1_++;
        }
        this.dirty = true;
    }

    public function updateExpiredItemsWithRemoved(param1:Array):void {
        var _loc2_:UserBmiData = null;
        var _loc3_:BlackMarketItemsNode = null;
        var _loc5_:int = 0;
        if (param1 == null || param1.length == 0) {
            return;
        }
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc2_ = param1[_loc4_];
            if (_loc2_.expireDate != null) {
                _loc3_ = this.boughtItems[_loc2_.typeId];
                _loc5_ = _loc3_.concreteItems.length - 1;
                while (_loc5_ >= 0) {
                    if (_loc3_.concreteItems[_loc5_].expireDate != null && _loc3_.concreteItems[_loc5_].expireDate.time == _loc2_.expireDate.time) {
                        _loc3_.concreteItems.splice(_loc5_, 1);
                        _loc3_.paidCount--;
                        break;
                    }
                    _loc5_--;
                }
                if (_loc3_.totalCount() <= 0) {
                    delete this.boughtItems[_loc2_.typeId];
                }
            }
            _loc4_++;
        }
        this.chestsDirty = true;
    }

    public function activeChestCount():int {
        var _loc1_:Array = GACHA_CHESTS.concat(ALLIANCE_MISSION_CHESTS);
        return query(_loc1_).select(this.nodeById).where(this.notEmptyNode).select(this.activeChestInNode).sum();
    }

    public function allianceChestCount():int {
        var _loc1_:Array = GACHA_CHESTS.concat(ALLIANCE_MISSION_CHESTS);
        return query(_loc1_).select(this.nodeById).where(this.notEmptyNode).sum(this.itemsInNode);
    }

    public function hasExpiredGachaChests():Boolean {
        if (!Global.GACHA_CHESTS_ENABLED) {
            return false;
        }
        return query(GACHA_CHESTS).select(this.nodeById).where(this.notEmptyNode).any(this.hasExpiredItemsInNode);
    }

    private function nodeById(param1:int):BlackMarketItemsNode {
        return this.boughtItems[param1];
    }

    private function notEmptyNode(param1:BlackMarketItemsNode):Boolean {
        return param1 != null && !param1.isEmpty();
    }

    private function activeChestInNode(param1:BlackMarketItemsNode):int {
        return param1.activeCount();
    }

    private function itemsInNode(param1:BlackMarketItemsNode):int {
        return param1.totalCount();
    }

    private function hasExpiredItemsInNode(param1:BlackMarketItemsNode):Boolean {
        return param1.expiredCount() > 0;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        if (!Global.GACHA_CHESTS_ENABLED || this.boughtItems == null) {
            return null;
        }
        var _loc3_:Date = this.nextDateToExpireFromIds(GACHA_CHESTS);
        var _loc4_:Date = this.nextDateToExpireFromIds(ALLIANCE_MISSION_CHESTS);
        if (_loc3_ == null && _loc4_ == null) {
            return null;
        }
        if (_loc3_ > _loc4_) {
            return new NEventGachaChestExpired(_loc3_);
        }
        return new NEventBMIExpired(_loc4_);
    }

    private function nextDateToExpireFromIds(param1:Array):Date {
        var _loc2_:BlackMarketItemsNode = null;
        var _loc4_:int = 0;
        var _loc5_:Vector.<BlackMarketItemExpirationData> = null;
        var _loc6_:Date = null;
        var _loc7_:BlackMarketItemExpirationData = null;
        var _loc3_:Date = null;
        for each(_loc4_ in param1) {
            _loc2_ = this.boughtItems[_loc4_];
            if (!(_loc2_ == null || _loc2_.concreteItems == null || _loc2_.concreteItems.length == 0 || _loc2_.isEmpty())) {
                _loc5_ = _loc2_.concreteItems;
                for each(_loc7_ in _loc5_) {
                    _loc6_ = _loc7_.expireDate;
                    if (_loc6_ != null) {
                        if ((this._lastDate == null || _loc6_.time > this._lastDate.time) && _loc7_.isExpired() && (_loc3_ == null || _loc6_.time < _loc3_.time)) {
                            this._lastDate = _loc6_;
                            _loc3_ = _loc6_;
                        }
                    }
                }
            }
        }
        return _loc3_;
    }
}
}
