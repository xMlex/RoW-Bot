package model.logic.commands.sector {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.data.Resources;
import model.data.User;
import model.data.UserGameData;
import model.data.acceleration.types.BoostTypeId;
import model.data.stats.GoldMoneySourceType;
import model.data.temporarySkins.TemporarySectorSkinData;
import model.data.temporarySkins.TemporarySkin;
import model.data.users.misc.UserSectorSkinData;
import model.logic.PaymentManager;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.blackMarketItems.BuyBlackMarketItemResponse;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.discountOffers.UserDiscountOfferManager;
import model.logic.inventory.InventoryManager;

public class BuyBlackMarketItemCmd extends BaseCmd {


    private var requestDto;

    private var _itemId:int;

    private var _count:int;

    private var _activate:Boolean;

    private var _autoRenewBoost:Object = null;

    public function BuyBlackMarketItemCmd(param1:int, param2:int = 1, param3:Boolean = false, param4:Object = null) {
        super();
        this._itemId = param1;
        this._count = param2;
        this._activate = param3;
        this._autoRenewBoost = param4;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "i": this._itemId,
            "c": this._count,
            "b": this._activate,
            "a": this._autoRenewBoost
        });
    }

    public static function getPrice(param1:int):Number {
        var _loc2_:BlackMarketItemRaw = StaticDataManager.blackMarketData.itemsById[param1];
        var _loc3_:Resources = _loc2_.price;
        if (_loc3_ != null) {
            return _loc3_.goldMoney;
        }
        return 0;
    }

    public function set itemId(param1:int):void {
        this._itemId = param1;
    }

    public function set count(param1:int):void {
        this._count = param1;
    }

    public function set activate(param1:Boolean):void {
        this._activate = param1;
    }

    public function set autoRenewBoost(param1:Boolean):void {
        this._autoRenewBoost = param1;
    }

    override public function execute():void {
        new JsonCallCmd("BlackMarket.BuyItem", this.requestDto, "POST").ifResult(function (param1:*):void {
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
            var _loc18_:* = undefined;
            var _loc2_:* = UserManager.user;
            var _loc3_:* = StaticDataManager.blackMarketData.itemsById[_itemId];
            var _loc4_:* = param1.o != null ? BuyBlackMarketItemResponse.fromDto(param1.o) : new BuyBlackMarketItemResponse();
            var _loc5_:* = _loc4_ != null ? _loc4_.price : _loc3_.price;
            if (_loc4_ && _loc4_.activationResult) {
                _loc6_ = _loc4_.activationResult;
            }
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc7_ = _loc2_.gameData.blackMarketData;
                if (_loc7_.boughtItems[_itemId] == undefined) {
                    _loc7_.boughtItems[_itemId] = new BlackMarketItemsNode();
                    _loc7_.boughtItems[_itemId].paidCount = _count;
                }
                else {
                    _loc7_.boughtItems[_itemId].paidCount = _loc7_.boughtItems[_itemId].paidCount + _count;
                }
                _loc2_.gameData.account.resources.substract(_loc5_);
                _loc2_.gameData.blackMarketData.dirty = true;
                _loc2_.gameData.updateObjectsBuyStatus(true);
                if (_loc3_ != null && (_loc3_.resourcesBoostData != null || _loc3_.resourcesData != null || _loc3_.levelUpPointsData != null) && _activate) {
                    _loc7_.boughtItems[_itemId].paidCount--;
                }
            }
            if (_loc3_ != null && _loc3_.resourcesData != null && _loc3_.resourcesData.resources != null) {
                if (_loc3_.resourcesData.resources.money == 0 && _loc3_.resourcesData.resources.constructionItems == 0) {
                    _loc8_ = UserManager.user.gameData.commonData.boughtResourceKitIds;
                    if (_loc8_ == null) {
                        _loc8_ = new ArrayCustom();
                    }
                    _loc8_.addItem(_loc3_.id);
                }
                if (_activate && _loc3_.resourcesData.resources.constructionItems > 0) {
                    _loc2_.gameData.account.resources.add(_loc3_.resourcesData.resources);
                }
            }
            if (_loc3_ != null && _loc3_.resourcesBoostData != null && _activate) {
                if (_loc3_.resourcesBoostData.resources.titanite != 0) {
                    _loc10_ = BoostTypeId.RESOURCES_TITANITE;
                    _loc9_ = _loc3_.resourcesBoostData.resources.titanite;
                    if (_autoRenewBoost) {
                        UserManager.user.gameData.constructionData.resourceMiningBoostAutoRenewalTitanite = _autoRenewBoost;
                    }
                    _loc11_ = StaticDataManager.getResourceMiningBoostType(_loc10_, _loc9_);
                    _loc2_.gameData.constructionData.addOrProlongResourceMiningBoost(_loc6_.boostActivationResult.until - ServerTimeManager.serverTimeNow.time, _loc11_, _loc9_);
                }
                if (_loc3_.resourcesBoostData.resources.uranium != 0) {
                    _loc10_ = BoostTypeId.RESOURCES_URANIUM;
                    _loc9_ = _loc3_.resourcesBoostData.resources.uranium;
                    if (_autoRenewBoost) {
                        UserManager.user.gameData.constructionData.resourceMiningBoostAutoRenewalUranium = _autoRenewBoost;
                    }
                    _loc11_ = StaticDataManager.getResourceMiningBoostType(_loc10_, _loc9_);
                    _loc2_.gameData.constructionData.addOrProlongResourceMiningBoost(_loc6_.boostActivationResult.until - ServerTimeManager.serverTimeNow.time, _loc11_, _loc9_);
                }
                if (_loc3_.resourcesBoostData.resources.money != 0) {
                    _loc10_ = BoostTypeId.RESOURCES_MONEY;
                    _loc9_ = _loc3_.resourcesBoostData.resources.money;
                    if (_autoRenewBoost) {
                        UserManager.user.gameData.constructionData.resourceMiningBoostAutoRenewalMoney = _autoRenewBoost;
                    }
                    _loc11_ = StaticDataManager.getResourceMiningBoostType(_loc10_, _loc9_);
                    _loc2_.gameData.constructionData.addOrProlongResourceMiningBoost(_loc6_.boostActivationResult.until - ServerTimeManager.serverTimeNow.time, _loc11_, _loc9_);
                }
                _loc12_ = new Dictionary();
                _loc12_[_itemId] = 1;
                _loc13_ = _loc3_.price.clone();
                _loc14_ = 0;
                if (!_loc13_.isMUT) {
                    _loc14_ = UserDiscountOfferManager.discountBoost(_loc10_);
                }
                _loc13_.goldMoney = _loc13_.goldMoney * (1 - _loc14_);
                PaymentManager.addPayment(_loc13_.goldMoney, int(UserManager.user.gameData.account.resources.goldMoney), ServerTimeManager.serverTimeNow, GoldMoneySourceType.BlackMarketData, _loc12_);
            }
            if (_loc3_ != null && _loc3_.packData != null) {
                if (_loc2_.gameData.blackMarketData.boughtCountByItemPackId[_loc3_.packData.packType]) {
                    _loc2_.gameData.blackMarketData.boughtCountByItemPackId[_loc3_.packData.packType] = _loc2_.gameData.blackMarketData.boughtCountByItemPackId[_loc3_.packData.packType] + _loc3_.packData.itemCount;
                }
                else {
                    _loc2_.gameData.blackMarketData.boughtCountByItemPackId[_loc3_.packData.packType] = _loc3_.packData.itemCount;
                }
            }
            if (_loc3_ != null && _loc3_.inventoryItemData != null && _loc3_.inventoryKeyData != null) {
                _loc2_.gameData.blackMarketData.purchaseCountById[_loc3_.id] = true;
                _loc16_ = StaticDataManager.blackMarketData.items as Array;
                _loc17_ = 0;
                while (_loc17_ < _loc16_.length) {
                    if (_loc16_[_loc17_].inventoryKeyData) {
                        if (_loc16_[_loc17_].inventoryKeyData.rareness == _loc3_.inventoryKeyData.rareness && _loc16_[_loc17_].inventoryKeyData.requiredTechnologyId == _loc3_.inventoryKeyData.requiredTechnologyId) {
                            _loc15_ = _loc16_[_loc17_];
                            break;
                        }
                    }
                    _loc17_++;
                }
                if (_loc2_.gameData.blackMarketData.boughtItems[_loc15_.id]) {
                    _loc2_.gameData.blackMarketData.boughtItems[_loc15_.id].paidCount = _loc2_.gameData.blackMarketData.boughtItems[_loc15_.id].paidCount + _loc3_.inventoryKeyData.count;
                }
                else {
                    _loc18_ = new BlackMarketItemsNode();
                    _loc18_.paidCount = _loc3_.inventoryKeyData.count;
                    _loc2_.gameData.blackMarketData.boughtItems[_loc15_.id] = _loc18_;
                }
                InventoryManager.addElementsInInventory(_loc3_.inventoryItemData);
            }
            if (_activate && _loc3_ != null && _loc3_.levelUpPointsData != null && _loc3_.levelUpPointsData.levelUpPoints > 0) {
                _loc2_.gameData.account.levelUpPoints = _loc2_.gameData.account.levelUpPoints + _loc3_.levelUpPointsData.levelUpPoints;
            }
            _loc2_.gameData.questData.addCollectibleItemsFromBMI(_loc5_.goldMoney);
            if (_loc3_ != null && _loc3_.temporarySkinData != null) {
                addTemporarySkinToUser(_loc2_, _loc3_.temporarySkinData);
            }
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }

    private function addTemporarySkinToUser(param1:User, param2:TemporarySkin):void {
        var _loc3_:UserGameData = param1.gameData;
        if (_loc3_.sectorSkinsData == null) {
            _loc3_.sectorSkinsData = new UserSectorSkinData();
        }
        if (_loc3_.sectorSkinsData.temporarySectorSkinData == null) {
            _loc3_.sectorSkinsData.temporarySectorSkinData = new TemporarySectorSkinData();
        }
        _loc3_.sectorSkinsData.temporarySectorSkinData.addSkinToUser(param2);
        _loc3_.sectorSkinsData.dirty = true;
    }
}
}
