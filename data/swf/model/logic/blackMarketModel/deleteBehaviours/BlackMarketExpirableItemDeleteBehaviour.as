package model.logic.blackMarketModel.deleteBehaviours {
import flash.utils.Dictionary;

import model.data.UserPrize;
import model.data.users.blackMarket.UserBmiData;
import model.data.users.blackMarket.UserBmiDataRequestDto;
import model.logic.StaticDataManager;
import model.logic.blackMarketModel.deleteBehaviours.contexts.DeleteContext;
import model.logic.commands.BaseCmd;
import model.logic.commands.blackMarcket.RemoveAllExpiredItemsCmd;
import model.logic.commands.blackMarcket.RemoveSelectedExpiredItemsCmd;

public class BlackMarketExpirableItemDeleteBehaviour extends DeleteBehaviourBase {


    private var _commandCache:BaseCmd;

    private var _itemId:int;

    private var _itemIds:Array;

    public function BlackMarketExpirableItemDeleteBehaviour() {
        super();
    }

    override public function prepareDelete(param1:int, param2:DeleteContext):void {
        var _loc3_:Array = null;
        var _loc4_:UserBmiDataRequestDto = null;
        var _loc5_:UserBmiData = null;
        this._itemIds = null;
        if (param2.expirationDate != null) {
            _loc4_ = new UserBmiDataRequestDto();
            _loc5_ = new UserBmiData();
            _loc5_.typeId = param1;
            _loc5_.expireDate = param2.expirationDate;
            _loc4_.count = 1;
            _loc4_.value = _loc5_;
            _loc3_ = [_loc4_.toDto()];
            this._commandCache = new RemoveSelectedExpiredItemsCmd(_loc3_);
        }
        else if (param2.itemIds != null && param2.itemIds.length > 0) {
            this._itemIds = param2.itemIds;
            this._commandCache = new RemoveAllExpiredItemsCmd();
        }
        this._itemId = param1;
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler(param1:* = null):void {
        var _loc4_:Dictionary = null;
        var _loc5_:int = 0;
        var _loc2_:UserPrize = new UserPrize();
        var _loc3_:int = 0;
        if (this._itemIds != null && this._itemIds.length > 0) {
            _loc4_ = StaticDataManager.blackMarketData.prizeInStaticBonusPack;
            for each(_loc5_ in this._itemIds) {
                if (_loc4_[_loc5_] != undefined) {
                    _loc2_.sourceMerge(StaticDataManager.blackMarketData.prizeInStaticBonusPack[_loc5_]);
                    _loc3_++;
                }
            }
        }
        if (param1 == null) {
            param1 = {};
        }
        param1.prizes = _loc2_;
        param1.count = _loc3_;
        dispatchResult(param1);
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }
}
}
