package model.logic.filterSystem.filters {
import model.logic.blackMarketModel.interfaces.temporary.ILimitedItem;
import model.logic.filterSystem.interfaces.IDataFilter;

public class LimitedItemFilter implements IDataFilter {


    public function LimitedItemFilter() {
        super();
    }

    public function filter(param1:Array):Array {
        var _loc4_:ILimitedItem = null;
        var _loc2_:Array = [];
        var _loc3_:int = 0;
        while (_loc3_ < param1.length) {
            _loc4_ = param1[_loc3_] as ILimitedItem;
            if (!_loc4_) {
                throw new Error("В ResourcePackFilter попал массив с неправильными предметами.");
            }
            _loc4_.saleEndDate.refresh();
            _loc4_.saleStartDate.refresh();
            if (isNaN(_loc4_.saleStartDate.value.time)) {
                if (!_loc4_.saleEndDate.isExpired) {
                    _loc2_.push(_loc4_);
                }
            }
            else if (!_loc4_.saleEndDate.isExpired && _loc4_.saleStartDate.isExpired) {
                _loc2_.push(_loc4_);
            }
            _loc3_++;
        }
        return _loc2_;
    }
}
}
