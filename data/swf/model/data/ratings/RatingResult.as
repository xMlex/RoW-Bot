package model.data.ratings {
import flash.utils.Dictionary;

import model.logic.ratings.RatingType;

public class RatingResult {


    public var pointsDict:Dictionary;

    public var length:int;

    public function RatingResult() {
        super();
    }

    public static function fromDto(param1:*):RatingResult {
        var _loc2_:RatingResult = new RatingResult();
        _loc2_.pointsDict = new Dictionary();
        _loc2_.pointsDict[RatingType.UserAttacker] = _loc2_.checkIfNull(param1.ra);
        _loc2_.pointsDict[RatingType.UserDefender] = _loc2_.checkIfNull(param1.rd);
        _loc2_.pointsDict[RatingType.UserRobber] = _loc2_.checkIfNull(param1.rr);
        _loc2_.pointsDict[RatingType.UserOccupant] = _loc2_.checkIfNull(param1.ro);
        _loc2_.pointsDict[RatingType.UserRaids] = _loc2_.checkIfNull(param1.rl);
        return _loc2_;
    }

    private function checkIfNull(param1:Number):Number {
        if (param1) {
            this.length++;
            return param1;
        }
        return 0;
    }

    public function isIncreaseRating():Boolean {
        var _loc2_:* = undefined;
        var _loc1_:Boolean = false;
        for each(_loc2_ in this.pointsDict) {
            if (_loc2_ != 0) {
                _loc1_ = true;
                break;
            }
        }
        return _loc1_;
    }
}
}
