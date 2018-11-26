package model.logic.filterSystem.filters {
import model.logic.filterSystem.contexts.blackMarket.TechFilterContext;
import model.logic.filterSystem.dataProviders.ILevelProvider;

public class TechLevelFilter extends DataFilterBase {


    public function TechLevelFilter() {
        super();
        _context = new TechFilterContext();
    }

    override protected function filter_impl(param1:Array):Array {
        var _loc5_:ILevelProvider = null;
        var _loc2_:TechFilterContext = _context as TechFilterContext;
        var _loc3_:Array = [];
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc5_ = param1[_loc4_] as ILevelProvider;
            if (!_loc5_) {
                throw new Error("В TechLevelFilter попал массив с неправильными предметами.");
            }
            if (_loc5_.level == _loc2_.techLevel) {
                _loc3_.push(_loc5_);
            }
            _loc4_++;
        }
        return _loc3_;
    }
}
}
