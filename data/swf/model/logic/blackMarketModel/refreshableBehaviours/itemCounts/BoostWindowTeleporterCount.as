package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import flash.utils.Dictionary;

import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;

public class BoostWindowTeleporterCount extends DynamicStateObject implements IDynamicInteger {


    private var _itemId:int;

    private var _value:int;

    private var _simpleCount:IDynamicInteger;

    private var _boostRation:Number;

    public function BoostWindowTeleporterCount(param1:int, param2:Number) {
        super();
        this._itemId = param1;
        this._simpleCount = new BlackMarketItemCount(param1);
        this._boostRation = param2;
    }

    public function get value():int {
        return this._value;
    }

    public function refresh():void {
        var _loc2_:IDynamicInteger = null;
        var _loc4_:* = null;
        var _loc5_:int = 0;
        var _loc6_:BlackMarketItemRaw = null;
        this._simpleCount.refresh();
        var _loc1_:int = this._simpleCount.value;
        var _loc3_:Dictionary = UserManager.user.gameData.blackMarketData.boughtItems;
        for (_loc4_ in _loc3_) {
            _loc5_ = int(_loc4_);
            if (_loc5_ != this._itemId) {
                _loc6_ = StaticDataManager.blackMarketData.itemsById[_loc5_];
                if (_loc6_ != null) {
                    if (_loc6_.boostData != null) {
                        if (_loc6_.boostData.speedUpCoefficient == this._boostRation) {
                            _loc2_ = new BlackMarketItemCount(_loc6_.id);
                            _loc2_.refresh();
                            _loc1_ = _loc1_ + _loc2_.value;
                            trace("Added " + _loc2_ + " for booster with duration: " + (1 - this._boostRation) * 100);
                        }
                    }
                }
            }
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
