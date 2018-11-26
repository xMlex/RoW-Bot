package model.logic.filterSystem.filters {
import model.logic.filterSystem.contexts.blackMarket.ResourceFilterContext;
import model.logic.filterSystem.dataProviders.IResourceTypeProvider;

public class ResourceFilter extends DataFilterBase {


    public function ResourceFilter() {
        super();
        _context = new ResourceFilterContext();
    }

    override protected function filter_impl(param1:Array):Array {
        var _loc5_:IResourceTypeProvider = null;
        var _loc2_:ResourceFilterContext = _context as ResourceFilterContext;
        var _loc3_:Array = [];
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc5_ = param1[_loc4_] as IResourceTypeProvider;
            if (!_loc5_) {
                throw new Error("В ResourceFilter попал массив с неправильными предметами.");
            }
            if (_loc2_.resourceType == -666) {
                _loc3_.push(_loc5_);
            }
            else if (_loc5_.resourceType == _loc2_.resourceType) {
                _loc3_.push(_loc5_);
            }
            _loc4_++;
        }
        return _loc3_;
    }
}
}
