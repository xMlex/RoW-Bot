package model.logic.quests.data.userPrizeFilter {
import model.data.UserPrize;

public class UserPrizeFilterContext {


    private var _insideFilter:UserPrize;

    private var _outsideFilters:UserPrize;

    public function UserPrizeFilterContext(param1:UserPrize) {
        super();
        this._outsideFilters = param1;
        this._insideFilter = new UserPrize();
    }

    public function get insideFilter():UserPrize {
        return this._insideFilter;
    }

    public function get outsideFilters():UserPrize {
        return this._outsideFilters;
    }
}
}
