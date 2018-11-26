package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import flash.utils.Dictionary;

import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.refreshableBehaviours.dates.ExpirableDate;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;

public class BlackMarketItemCount extends DynamicStateObject implements IDynamicInteger {


    private var _itemId:int;

    private var _value:int;

    public function BlackMarketItemCount(param1:int) {
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
        var _loc5_:BlackMarketItemRaw = null;
        var _loc6_:int = 0;
        var _loc7_:IDynamicDate = null;
        var _loc8_:int = 0;
        var _loc9_:Date = null;
        var _loc2_:int = 0;
        var _loc3_:Dictionary = UserManager.user.gameData.blackMarketData.boughtItems;
        if (_loc3_ == null || _loc3_[param1] == undefined) {
            _loc2_ = 0;
        }
        else {
            _loc2_ = _loc3_[param1].freeCount + _loc3_[param1].paidCount;
            _loc4_ = _loc3_[param1] as BlackMarketItemsNode;
            if (_loc4_.concreteItems != null) {
                _loc5_ = StaticDataManager.blackMarketData.itemsById[param1] as BlackMarketItemRaw;
                _loc6_ = 0;
                _loc7_ = new ExpirableDate();
                _loc8_ = 0;
                while (_loc8_ < _loc4_.concreteItems.length) {
                    _loc9_ = new Date(_loc4_.concreteItems[_loc8_].timeAdded.time);
                    _loc9_.time = _loc9_.time + _loc5_.lifeTime.time;
                    _loc7_.value = _loc9_;
                    _loc7_.refresh();
                    if (_loc7_.isExpired) {
                        _loc6_++;
                    }
                    _loc8_++;
                }
            }
            _loc2_ = _loc2_ - _loc6_;
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
