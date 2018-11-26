package model.data.ratings {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class RatingWinners {


    public var ratingDate:Date;

    public var tops:Dictionary;

    public function RatingWinners() {
        super();
    }

    public static function fromDto(param1:*):RatingWinners {
        var _loc3_:* = undefined;
        var _loc4_:Array = null;
        var _loc2_:RatingWinners = new RatingWinners();
        _loc2_.ratingDate = param1.d == null ? null : new Date(param1.d);
        _loc2_.tops = new Dictionary();
        for (_loc3_ in param1.t) {
            _loc4_ = param1.t[_loc3_];
            _loc2_.tops[_loc3_] = _loc4_;
        }
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
