package model.logic.quests.data.userPrizeFilter {
public class UserPrizeFilterWorkers implements IUserPrizeFilter {


    private var _conditions:Vector.<Function>;

    public function UserPrizeFilterWorkers(...rest) {
        super();
        this._conditions = new Vector.<Function>();
        this.parseArguments(rest);
    }

    public function apply(param1:UserPrizeFilterContext):void {
        var _loc2_:int = param1.outsideFilters.constructionWorkers;
        if (_loc2_ != 0 && this.executeConditions()) {
            param1.insideFilter.constructionWorkers = _loc2_;
            param1.outsideFilters.constructionWorkers = 0;
        }
    }

    private function executeConditions():Boolean {
        var _loc4_:Function = null;
        var _loc1_:int = this._conditions.length;
        var _loc2_:* = _loc1_ == 0;
        var _loc3_:int = 0;
        while (_loc3_ < _loc1_) {
            _loc4_ = this._conditions[_loc3_];
            _loc2_ = Boolean(_loc4_.call(null));
            if (_loc2_) {
                break;
            }
            _loc3_++;
        }
        return _loc2_;
    }

    private function parseArguments(param1:Array):void {
        var _loc3_:Function = null;
        var _loc2_:int = 0;
        while (_loc2_ < param1.length) {
            _loc3_ = param1[_loc2_] as Function;
            this._conditions.push(_loc3_);
            _loc2_++;
        }
    }
}
}
