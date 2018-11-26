package model.logic.blackMarketModel.validation {
import model.logic.ServerTimeManager;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.interfaces.temporary.ILimitedItem;

public class ItemDateValidator extends BlackMarketValidatorBase {


    public function ItemDateValidator() {
        super();
    }

    override public function validate(param1:BlackMarketItemBase):Boolean {
        var _loc2_:ILimitedItem = param1 as ILimitedItem;
        if (!_loc2_) {
            return true;
        }
        _loc2_.saleEndDate.refresh();
        if (!_loc2_.saleEndDate.value) {
            return true;
        }
        if (!isNaN(_loc2_.saleEndDate.value.date) && _loc2_.saleEndDate.value < ServerTimeManager.serverTimeNow) {
            return false;
        }
        return true;
    }
}
}
