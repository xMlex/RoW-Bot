package model.logic.filterSystem.filters {
import model.logic.filterSystem.dataProviders.IDynamicIntegerProvider;
import model.logic.filterSystem.interfaces.IDataFilter;

public class CountItemFilter implements IDataFilter {


    public function CountItemFilter() {
        super();
    }

    public function filter(param1:Array):Array {
        var _loc4_:IDynamicIntegerProvider = null;
        var _loc2_:Array = [];
        var _loc3_:int = 0;
        while (_loc3_ < param1.length) {
            if (!param1[_loc3_].hasOwnProperty("clear")) {
                _loc4_ = param1[_loc3_] as IDynamicIntegerProvider;
                _loc4_.value.refresh();
                if (_loc4_.value.value > 0) {
                    _loc2_.push(_loc4_);
                }
            }
            _loc3_++;
        }
        return _loc2_;
    }
}
}
