package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.refreshableBehaviours.dates.ExpirableDate;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;
import model.logic.filterSystem.dataProviders.IIDProvider;

public class ExpirableClanItemCount extends DynamicStateObject implements IDynamicInteger {


    private var _data:Array;

    private var _value:int;

    public function ExpirableClanItemCount(param1:Array) {
        super();
        this._data = param1;
    }

    public function get value():int {
        return this._value;
    }

    public function refresh():void {
        var _loc3_:IIDProvider = null;
        var _loc4_:BlackMarketItemsNode = null;
        var _loc5_:IDynamicDate = null;
        var _loc6_:int = 0;
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this._data.length) {
            _loc3_ = this._data[_loc2_] as IIDProvider;
            _loc4_ = UserManager.user.gameData.blackMarketData.boughtItems[_loc3_.id];
            if (_loc4_ != null && _loc4_.concreteItems != null) {
                _loc5_ = new ExpirableDate();
                _loc6_ = 0;
                while (_loc6_ < _loc4_.concreteItems.length) {
                    _loc5_.value = _loc4_.concreteItems[_loc6_].expireDate;
                    _loc5_.refresh();
                    if (_loc5_.isExpired) {
                        _loc1_++;
                    }
                    _loc6_++;
                }
            }
            _loc2_++;
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
