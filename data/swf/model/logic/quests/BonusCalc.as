package model.logic.quests {
public class BonusCalc {


    private var yMin:int;

    private var yMax:int;

    private var xMin:int;

    private var xMax:int;

    private var yStep:int;

    private var yFloor:int;

    public function BonusCalc(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) {
        super();
        this.yMin = param2;
        this.yMax = param3;
        this.xMin = param4;
        this.xMax = param5;
        this.yStep = param6;
        this.yFloor = param1;
    }

    public function getNextItems(param1:int):int {
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        var _loc2_:int = (this.yMax - this.yMin) / this.yStep;
        var _loc3_:Number = Number(this.yStep) / (this.yMax - this.yMin);
        var _loc4_:Number = (this.xMax - this.xMin) * _loc3_;
        var _loc5_:Number = this.xMin + _loc2_ * _loc4_;
        if (param1 == 0) {
            if (this.yFloor > 0) {
                _loc6_ = 1;
            }
            else if (this.xMin == 0) {
                _loc6_ = _loc4_;
            }
            else {
                _loc6_ = this.xMin;
            }
        }
        else if (param1 < this.xMin) {
            if (this.yFloor != this.yMin) {
                _loc6_ = this.xMin;
            }
            else {
                _loc6_ = this.xMin + _loc4_;
            }
        }
        else {
            _loc7_ = (param1 - this.xMin) / _loc4_ + 1;
            _loc6_ = this.xMin + _loc4_ * _loc7_;
        }
        if (param1 > _loc5_ || param1 >= this.xMax) {
            return this.xMax;
        }
        return _loc6_ == param1 ? int(_loc6_ + _loc4_) : int(_loc6_);
    }

    public function getPlusBonus(param1:int):int {
        var _loc2_:int = 0;
        if (param1 == 0) {
            if (this.yFloor > 0) {
                _loc2_ = this.yFloor;
            }
            else {
                _loc2_ = this.yMin;
            }
        }
        else if (param1 >= this.xMax) {
            _loc2_ = 0;
        }
        else if (param1 < this.xMin) {
            if (this.yMin > 0 && this.yMin != this.yFloor) {
                _loc2_ = this.yMin - this.yFloor;
            }
            else {
                _loc2_ = this.yStep;
            }
        }
        else {
            _loc2_ = this.yStep;
        }
        return _loc2_;
    }

    public function getCurrentBonus(param1:int):int {
        if (param1 == 0) {
            return 0;
        }
        if (param1 < this.xMin) {
            return this.yFloor;
        }
        if (param1 >= this.xMax) {
            return this.yMax;
        }
        var _loc2_:Number = (this.yMax - this.yMin) / (this.xMax - this.xMin);
        var _loc3_:int = (param1 - this.xMin) * _loc2_ + this.yMin;
        if (this.yStep > 0) {
            _loc3_ = int(_loc3_ / this.yStep) * this.yStep;
        }
        if (_loc3_ < this.yFloor) {
            _loc3_ = this.yFloor;
        }
        return _loc3_;
    }
}
}
