package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import flash.utils.Dictionary;

import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;

public class ActiveAndExpiredItemCount extends DynamicStateObject implements IDynamicInteger {


    private var _itemId:int;

    private var _value:int;

    public function ActiveAndExpiredItemCount(param1:int) {
        super();
        this._itemId = param1;
    }

    public function get value():int {
        return this._value;
    }

    public function get itemId():int {
        return this._itemId;
    }

    public function refresh():void {
        var _loc1_:int = this.boughtItemsById(this._itemId);
        this.checkAndDispatch(_loc1_);
    }

    protected function boughtItemsById(param1:int):int {
        var _loc4_:BlackMarketItemsNode = null;
        var _loc2_:int = 0;
        var _loc3_:Dictionary = UserManager.user.gameData.blackMarketData.boughtItems;
        if (_loc3_ == null || _loc3_[param1] == undefined) {
            _loc2_ = 0;
        }
        else {
            _loc4_ = _loc3_[param1] as BlackMarketItemsNode;
            _loc2_ = _loc4_.totalCount();
        }
        return _loc2_;
    }

    protected function checkAndDispatch(param1:int):void {
        if (this._value == param1) {
            return;
        }
        this._value = param1;
        dispatchChange();
    }
}
}
