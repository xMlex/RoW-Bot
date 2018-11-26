package model.logic.quests.data.userPrizeFilter {
import flash.utils.Dictionary;

public class UserPrizeFilterBMItem implements IUserPrizeFilter {


    private var _bmiId:int;

    private var _conditions:Vector.<Function>;

    public function UserPrizeFilterBMItem(param1:int, ...rest) {
        super();
        this._bmiId = param1;
        this._conditions = new Vector.<Function>();
        this.parseArguments(rest);
    }

    public function apply(param1:UserPrizeFilterContext):void {
        var _loc2_:Dictionary = param1.outsideFilters.blackMarketItems;
        if (_loc2_ != null) {
            if (_loc2_[this._bmiId] != null && this.executeConditions()) {
                if (param1.insideFilter.blackMarketItems == null) {
                    param1.insideFilter.blackMarketItems = new Dictionary();
                }
                param1.insideFilter.blackMarketItems[this._bmiId] = _loc2_[this._bmiId];
                delete _loc2_[this._bmiId];
            }
        }
    }

    private function executeConditions():Boolean {
        var _loc4_:Function = null;
        var _loc1_:int = this._conditions.length;
        var _loc2_:* = _loc1_ == 0;
        var _loc3_:int = 0;
        while (_loc3_ < _loc1_) {
            _loc4_ = this._conditions[_loc3_];
            _loc2_ = Boolean(_loc4_.call(null, this._bmiId));
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
