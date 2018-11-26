package model.logic.googleAnalytics {
import com.google.analytics.GATracker;

import model.logic.googleAnalytics.conditions.IConditionGA;

class GATrackerBase implements ITrack {


    private var _conditions:Vector.<IConditionGA>;

    protected var gaTracker:GATracker;

    function GATrackerBase() {
        super();
    }

    public function condition(param1:IConditionGA):GATrackerBase {
        if (this._conditions == null) {
            this._conditions = new Vector.<IConditionGA>();
        }
        this._conditions.push(param1);
        return this;
    }

    protected function get checkConditions():Boolean {
        var _loc1_:Boolean = true;
        if (this._conditions == null || this._conditions.length == 0) {
            return _loc1_;
        }
        var _loc2_:int = 0;
        while (_loc2_ < this._conditions.length) {
            if (this._conditions[_loc2_].check == false) {
                _loc1_ = false;
                break;
            }
            _loc2_++;
        }
        return _loc1_;
    }

    public function track():void {
        throw new Error("Abstract class must be overriden");
    }
}
}
