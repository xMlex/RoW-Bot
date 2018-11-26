package model.logic.quests.data.userPrizeFilter {
import model.data.temporarySkins.TemporarySkin;

public class UserPrizeFilterTemporarySkins implements IUserPrizeFilter {


    private var _conditions:Vector.<Function>;

    public function UserPrizeFilterTemporarySkins(...rest) {
        super();
        this._conditions = new Vector.<Function>();
        this.parseArguments(rest);
    }

    public function apply(param1:UserPrizeFilterContext):void {
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:TemporarySkin = null;
        var _loc2_:Array = param1.outsideFilters.temporarySkins;
        if (_loc2_ != null && _loc2_.length > 0) {
            _loc3_ = _loc2_.length;
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc5_ = _loc2_[_loc4_];
                if (_loc5_ != null && this.executeConditions()) {
                    if (param1.insideFilter.temporarySkins == null) {
                        param1.insideFilter.temporarySkins = [];
                    }
                    param1.insideFilter.temporarySkins.push(_loc5_);
                }
                _loc4_++;
            }
            _loc2_.splice(0, _loc3_);
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
            if (_loc3_ != null) {
                this._conditions.push(_loc3_);
            }
            _loc2_++;
        }
    }
}
}
