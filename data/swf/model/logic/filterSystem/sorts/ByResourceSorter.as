package model.logic.filterSystem.sorts {
import model.data.ResourceTypeId;
import model.logic.filterSystem.contexts.blackMarket.ResourceSortContext;
import model.logic.filterSystem.dataProviders.IResourcesProvider;
import model.logic.filterSystem.filters.DataFilterBase;

public class ByResourceSorter extends DataFilterBase {


    public function ByResourceSorter() {
        super();
        _context = new ResourceSortContext();
    }

    override protected function filter_impl(param1:Array):Array {
        var _loc2_:ResourceSortContext = _context as ResourceSortContext;
        var _loc3_:int = 0;
        while (_loc3_ < param1.length) {
            switch (_loc2_.resourceType) {
                case ResourceTypeId.URANIUM:
                    return this.sortUranium(param1);
                case ResourceTypeId.MONEY:
                    return this.sortTitanite(param1);
                case ResourceTypeId.TITANITE:
                    return this.sortMoney(param1);
                default:
                    _loc3_++;
                    continue;
            }
        }
        return param1;
    }

    private function sortUranium(param1:Array):Array {
        var _loc8_:IResourcesProvider = null;
        var _loc9_:Number = NaN;
        var _loc2_:IResourcesProvider = param1[Math.round(param1.length / 2)] as IResourcesProvider;
        if (!_loc2_) {
            return param1;
        }
        var _loc3_:Number = _loc2_.resources.uranium;
        var _loc4_:Array = [];
        var _loc5_:Array = [];
        var _loc6_:Array = [];
        var _loc7_:int = 0;
        while (_loc7_ < param1.length) {
            _loc8_ = param1[_loc7_] as IResourcesProvider;
            _loc9_ = _loc8_.resources.uranium;
            if (_loc9_ < _loc3_) {
                _loc4_.push(_loc8_);
            }
            if (_loc9_ == _loc3_) {
                _loc5_.push(_loc8_);
            }
            if (_loc9_ > _loc3_) {
                _loc6_.push(_loc8_);
            }
            _loc7_++;
        }
        return this.sortUranium(_loc4_).concat(_loc5_).concat(this.sortUranium(_loc6_));
    }

    private function sortTitanite(param1:Array):Array {
        var _loc8_:IResourcesProvider = null;
        var _loc9_:Number = NaN;
        var _loc2_:IResourcesProvider = param1[Math.round(param1.length / 2)] as IResourcesProvider;
        if (!_loc2_) {
            return param1;
        }
        var _loc3_:Number = _loc2_.resources.titanite;
        var _loc4_:Array = [];
        var _loc5_:Array = [];
        var _loc6_:Array = [];
        var _loc7_:int = 0;
        while (_loc7_ < param1.length) {
            _loc8_ = param1[_loc7_] as IResourcesProvider;
            _loc9_ = _loc8_.resources.titanite;
            if (_loc9_ < _loc3_) {
                _loc4_.push(_loc8_);
            }
            if (_loc9_ == _loc3_) {
                _loc5_.push(_loc8_);
            }
            if (_loc9_ > _loc3_) {
                _loc6_.push(_loc8_);
            }
            _loc7_++;
        }
        return this.sortTitanite(_loc4_).concat(_loc5_).concat(this.sortTitanite(_loc6_));
    }

    private function sortMoney(param1:Array):Array {
        var _loc8_:IResourcesProvider = null;
        var _loc9_:Number = NaN;
        var _loc2_:IResourcesProvider = param1[Math.round(param1.length / 2)] as IResourcesProvider;
        if (!_loc2_) {
            return param1;
        }
        var _loc3_:Number = _loc2_.resources.money;
        var _loc4_:Array = [];
        var _loc5_:Array = [];
        var _loc6_:Array = [];
        var _loc7_:int = 0;
        while (_loc7_ < param1.length) {
            _loc8_ = param1[_loc7_] as IResourcesProvider;
            _loc9_ = _loc8_.resources.money;
            if (_loc9_ < _loc3_) {
                _loc4_.push(_loc8_);
            }
            if (_loc9_ == _loc3_) {
                _loc5_.push(_loc8_);
            }
            if (_loc9_ > _loc3_) {
                _loc6_.push(_loc8_);
            }
            _loc7_++;
        }
        return this.sortMoney(_loc4_).concat(_loc5_).concat(this.sortMoney(_loc6_));
    }
}
}
