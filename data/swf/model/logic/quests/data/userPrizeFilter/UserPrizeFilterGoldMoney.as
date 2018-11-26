package model.logic.quests.data.userPrizeFilter {
import model.data.Resources;

public class UserPrizeFilterGoldMoney implements IUserPrizeFilter {


    public function UserPrizeFilterGoldMoney() {
        super();
    }

    public function apply(param1:UserPrizeFilterContext):void {
        if (param1.outsideFilters.resources == null) {
            return;
        }
        var _loc2_:int = param1.outsideFilters.resources.goldMoney;
        if (_loc2_ != 0) {
            if (param1.insideFilter.resources == null) {
                param1.insideFilter.resources = new Resources();
            }
            param1.outsideFilters.resources.goldMoney = 0;
            param1.insideFilter.resources.goldMoney = _loc2_;
        }
    }
}
}
