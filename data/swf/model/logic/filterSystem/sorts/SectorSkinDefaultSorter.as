package model.logic.filterSystem.sorts {
import model.logic.discountOffers.UserDiscountOfferManager;
import model.logic.filterSystem.dataProviders.ISectorSkinDataProvider;
import model.logic.filterSystem.interfaces.IDataFilter;

public class SectorSkinDefaultSorter implements IDataFilter {


    public function SectorSkinDefaultSorter() {
        super();
    }

    public function filter(param1:Array):Array {
        return param1.sort(this.sortingMethod);
    }

    private function sortingMethod(param1:ISectorSkinDataProvider, param2:ISectorSkinDataProvider):int {
        if (param1.skinState.isNew && !param2.skinState.isNew) {
            return -1;
        }
        if (!param1.skinState.isNew && param2.skinState.isNew) {
            return 1;
        }
        var _loc3_:Number = UserDiscountOfferManager.getDiscountCoefficient(param1.id);
        var _loc4_:Number = UserDiscountOfferManager.getDiscountCoefficient(param2.id);
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
