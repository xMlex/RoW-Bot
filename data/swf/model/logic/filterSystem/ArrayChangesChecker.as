package model.logic.filterSystem {
import common.IEquatable;

import model.logic.filterSystem.interfaces.IArrayChangesChecker;

public class ArrayChangesChecker implements IArrayChangesChecker {


    public function ArrayChangesChecker() {
        super();
    }

    public function hasChanges(param1:Array, param2:Array):Boolean {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc5_:Boolean = false;
        if (param1 == null || param2 == null) {
            return true;
        }
        if (param1.length != param2.length) {
            return true;
        }
        var _loc6_:int = 0;
        while (_loc6_ < param1.length) {
            _loc3_ = param1[_loc6_];
            _loc4_ = param2[_loc6_];
            _loc5_ = _loc3_ is IEquatable ? Boolean(_loc3_.isEqual(_loc4_)) : _loc3_ == _loc4_;
            if (!_loc5_) {
                return true;
            }
            _loc6_++;
        }
        return false;
    }
}
}
