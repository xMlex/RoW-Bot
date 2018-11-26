package model.logic.blackMarketModel.refreshableBehaviours.dates {
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;

public class BlackMarketExpirableDate implements IDynamicDate {


    private var _itemId:int;

    private var _item:IDynamicDate;

    public function BlackMarketExpirableDate(param1:int, param2:IDynamicDate) {
        super();
        this._itemId = param1;
        this._item = param2;
    }

    public function get isExpired():Boolean {
        return this._item.isExpired;
    }

    public function get value():Date {
        return this._item.value;
    }

    public function set value(param1:Date):void {
    }

    public function refresh():void {
        this.resetDate();
        this._item.refresh();
    }

    private function resetDate():void {
        var _loc6_:Date = null;
        var _loc1_:BlackMarketItemsNode = UserManager.user.gameData.blackMarketData.boughtItems[this._itemId];
        var _loc2_:BlackMarketItemRaw = StaticDataManager.blackMarketData.itemsById[this._itemId];
        if (_loc1_ == null || _loc1_.concreteItems == null || _loc2_ == null || _loc2_.lifeTime == null) {
            return;
        }
        var _loc3_:Date = null;
        var _loc4_:IDynamicDate = new ExpirableDate();
        var _loc5_:int = 0;
        while (_loc5_ < _loc1_.concreteItems.length) {
            _loc6_ = new Date(_loc1_.concreteItems[_loc5_].timeAdded.time);
            _loc6_.time = _loc6_.time + _loc2_.lifeTime.time;
            _loc4_.value = _loc6_;
            _loc4_.refresh();
            if (!_loc4_.isExpired) {
                if (_loc3_ == null) {
                    _loc3_ = _loc4_.value;
                }
                else if (_loc4_.value < _loc3_) {
                    _loc3_ = _loc4_.value;
                }
            }
            _loc5_++;
        }
        this._item.value = _loc3_;
    }
}
}
