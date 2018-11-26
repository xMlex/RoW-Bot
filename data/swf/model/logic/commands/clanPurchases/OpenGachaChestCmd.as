package model.logic.commands.clanPurchases {
import flash.utils.Dictionary;

import model.data.clanPurchases.GachaChestItem;
import model.data.users.blackMarket.UserBmiData;
import model.data.users.misc.UserBlackMarketData;
import model.logic.UserManager;
import model.logic.blackMarketItems.ActivateItemResponse;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class OpenGachaChestCmd extends BaseCmd {


    private var _requestDto;

    private var _expirationDate:Date;

    private var _isOpenAll:Boolean;

    public function OpenGachaChestCmd(param1:UserBmiData, param2:Boolean) {
        super();
        this.fillRequestDto(param1, param2);
    }

    public function fillRequestDto(param1:UserBmiData = null, param2:Boolean = false):void {
        var _loc3_:Object = {};
        this._isOpenAll = param2;
        if (param1 != null) {
            this._expirationDate = param1.expireDate;
            _loc3_.b = param1.toDto();
        }
        if (param2) {
            _loc3_.a = param2;
            this._expirationDate = null;
        }
        this._requestDto = UserRefreshCmd.makeRequestDto(_loc3_);
    }

    override public function execute():void {
        new JsonCallCmd("GachaChest.Open", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = param1.o == null ? null : ActivateItemResponse.fromDto(param1.o);
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                if (_loc2_ != null && _loc2_.gachaChestActivationResult != null) {
                    updateGachaChests(_loc2_.gachaChestActivationResult.openedChests);
                }
            }
            if (_onResult != null) {
                _onResult(param1, _loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }

    private function updateGachaChests(param1:Array):void {
        var _loc3_:GachaChestItem = null;
        if (param1 == null) {
            return;
        }
        var _loc2_:int = 0;
        while (_loc2_ < param1.length) {
            _loc3_ = param1[_loc2_];
            if (_loc3_.reward != null) {
                _loc3_.reward.givePrizeToUser();
            }
            this.removeChestFromBMData(_loc3_, this._expirationDate);
            _loc2_++;
        }
    }

    private function removeChestFromBMData(param1:GachaChestItem, param2:Date):void {
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        var _loc3_:UserBlackMarketData = UserManager.user.gameData.blackMarketData;
        var _loc4_:Dictionary = _loc3_.boughtItems;
        var _loc5_:BlackMarketItemsNode = _loc4_[param1.gachaChestId];
        if (_loc5_ == null) {
            return;
        }
        if (_loc5_.concreteItems != null) {
            if (this._isOpenAll) {
                _loc6_ = _loc5_.concreteItems.length;
                if (_loc5_.freeCount > 0) {
                    _loc5_.freeCount = _loc5_.freeCount - _loc6_;
                }
                else {
                    _loc5_.paidCount = _loc5_.paidCount - _loc6_;
                }
                _loc5_.concreteItems = _loc5_.concreteItems.splice(0, _loc6_);
            }
            else if (param2 != null) {
                _loc7_ = _loc5_.concreteItems.length - 1;
                while (_loc7_ >= 0) {
                    if (_loc5_.concreteItems[_loc7_].expireDate != null && _loc5_.concreteItems[_loc7_].expireDate.time == param2.time) {
                        _loc5_.concreteItems.splice(_loc7_, 1);
                        if (_loc5_.freeCount > 0) {
                            _loc5_.freeCount--;
                        }
                        else {
                            _loc5_.paidCount--;
                        }
                        break;
                    }
                    _loc7_--;
                }
            }
        }
        if (_loc5_.totalCount() <= 0) {
            delete _loc4_[param1.gachaChestId];
        }
        _loc3_.chestsDirty = true;
    }
}
}
