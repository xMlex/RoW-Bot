package model.data.map {
import configs.Global;

public class Distance {


    private var _from:MapPos;

    private var _to:MapPos;

    public function Distance(param1:MapPos, param2:MapPos) {
        super();
        this._from = param1;
        this._to = param2;
    }

    public function calculate(param1:Boolean = true):Number {
        if (this._from == null || this._to == null) {
            return 0;
        }
        var _loc2_:Number = this._from.distance(this._to);
        if (param1) {
            _loc2_ = _loc2_ * Global.DISTANCE_COEFFICIENT;
        }
        return _loc2_;
    }
}
}
