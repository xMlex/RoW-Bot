package model.logic.blackMarketItems {
public class BlackMarketItemsNode {


    public var freeCount:int;

    public var paidCount:int;

    public var concreteItems:Vector.<BlackMarketItemExpirationData>;

    public function BlackMarketItemsNode() {
        super();
        this.freeCount = 0;
        this.paidCount = 0;
        this.concreteItems = new Vector.<BlackMarketItemExpirationData>();
    }

    public function totalCount():int {
        return this.freeCount + this.paidCount;
    }

    public function isEmpty():Boolean {
        return this.totalCount() == 0;
    }

    public function activeCount():int {
        var _loc2_:BlackMarketItemExpirationData = null;
        var _loc1_:int = 0;
        for each(_loc2_ in this.concreteItems) {
            if (!_loc2_.isExpired()) {
                _loc1_++;
            }
        }
        return _loc1_;
    }

    public function expiredCount():int {
        var _loc2_:BlackMarketItemExpirationData = null;
        var _loc1_:int = 0;
        for each(_loc2_ in this.concreteItems) {
            if (_loc2_.isExpired()) {
                _loc1_++;
            }
        }
        return _loc1_;
    }
}
}
