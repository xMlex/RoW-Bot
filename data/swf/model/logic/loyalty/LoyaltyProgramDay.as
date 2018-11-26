package model.logic.loyalty {
import common.ArrayCustom;

import model.data.UserPrize;

public class LoyaltyProgramDay {


    public var day:int;

    public var prize:UserPrize;

    public var isSpecialDay:Boolean;

    public function LoyaltyProgramDay() {
        super();
    }

    public static function fromDto(param1:*):LoyaltyProgramDay {
        var _loc2_:LoyaltyProgramDay = new LoyaltyProgramDay();
        _loc2_.day = param1.d;
        _loc2_.prize = param1.p == null ? null : UserPrize.fromDto(param1.p);
        _loc2_.isSpecialDay = param1.s;
        return _loc2_;
    }

    public static function fromDtos(param1:*, param2:int = -1):ArrayCustom {
        var _loc4_:* = undefined;
        var _loc5_:int = 0;
        var _loc6_:LoyaltyProgramDay = null;
        var _loc3_:ArrayCustom = new ArrayCustom();
        if (param1 == null) {
            return _loc3_;
        }
        if (param2 != -1) {
            _loc5_ = 0;
            while (_loc5_ < param2) {
                _loc3_.addItem(new LoyaltyProgramDay());
                _loc5_++;
            }
            for each(_loc4_ in param1) {
                _loc6_ = fromDto(_loc4_);
                _loc3_[_loc6_.day - 1] = _loc6_;
            }
        }
        else {
            for each(_loc4_ in param1) {
                _loc3_.addItem(fromDto(_loc4_));
            }
        }
        return _loc3_;
    }
}
}
