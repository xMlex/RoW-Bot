package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import common.ArrayCustom;

import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;

public class VipActivatorItemCount extends DynamicStateObject implements IDynamicInteger {


    private var _itemId:int;

    private var _value:int;

    public function VipActivatorItemCount(param1:int) {
        super();
        this._itemId = param1;
    }

    public function get value():int {
        return this._value;
    }

    public function refresh():void {
        var _loc6_:int = 0;
        var _loc1_:int = 0;
        var _loc2_:BlackMarketItemRaw = StaticDataManager.blackMarketData.itemsById[this._itemId];
        var _loc3_:ArrayCustom = UserManager.user.gameData.blackMarketData.boughtActivatorsByTime[_loc2_.vipActivatorData.durationSeconds];
        var _loc4_:BlackMarketItemsNode = UserManager.user.gameData.blackMarketData.boughtItems[this._itemId];
        var _loc5_:int = !!_loc4_ ? int(_loc4_.freeCount + _loc4_.paidCount) : 0;
        if (!_loc3_) {
            _loc1_ = _loc5_;
        }
        else {
            _loc6_ = !!_loc3_ ? int(_loc3_.length) : 0;
            _loc1_ = _loc5_ > _loc6_ ? int(_loc5_) : int(_loc6_);
        }
        this.checkAndDispatch(_loc1_);
    }

    private function checkAndDispatch(param1:int):void {
        if (this._value == param1) {
            return;
        }
        this._value = param1;
        dispatchChange();
    }
}
}
