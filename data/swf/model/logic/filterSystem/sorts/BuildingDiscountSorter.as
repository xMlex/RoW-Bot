package model.logic.filterSystem.sorts {
import model.logic.discountOffers.UserDiscountOfferManager;
import model.logic.filterSystem.contexts.blackMarket.BuildingSortContext;
import model.logic.filterSystem.dataProviders.IIDProvider;
import model.logic.filterSystem.filters.DataFilterBase;

public class BuildingDiscountSorter extends DataFilterBase {


    public function BuildingDiscountSorter() {
        super();
        _context = new BuildingSortContext();
    }

    override protected function filter_impl(param1:Array):Array {
        var _loc2_:BuildingSortContext = _context as BuildingSortContext;
        if (!_loc2_.doFilter) {
            return param1;
        }
        return param1.sort(this._sortFnc);
    }

    private function _sortFnc(param1:IIDProvider, param2:IIDProvider):int {
        var _loc3_:Number = UserDiscountOfferManager.discountBuildings(param1.id).discount;
        var _loc4_:Number = UserDiscountOfferManager.discountBuildings(param2.id).discount;
        return this.comparator(_loc3_, _loc4_);
    }

    private function comparator(param1:Number, param2:Number):int {
        if (param1 > param2) {
            return -1;
        }
        if (param1 < param2) {
            return 1;
        }
        return 0;
    }
}
}
