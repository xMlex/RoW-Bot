package model.logic.conditions {
public class ConditionQueue {


    private var _conditions:Vector.<Condition>;

    private var _resultHandlers:Vector.<Function>;

    private var _faultHandlers:Vector.<Function>;

    private var _conditionIndex:int;

    public function ConditionQueue() {
        super();
    }

    public function condition(param1:Condition):ConditionQueue {
        if (this._conditions == null) {
            this._conditions = new Vector.<Condition>();
        }
        this._conditions.push(param1);
        return this;
    }

    public function ifResult(...rest):ConditionQueue {
        if (this._resultHandlers == null) {
            this._resultHandlers = new Vector.<Function>();
        }
        var _loc2_:int = 0;
        while (_loc2_ < rest.length) {
            this._resultHandlers.push(rest[_loc2_]);
            _loc2_++;
        }
        return this;
    }

    public function ifFault(...rest):ConditionQueue {
        if (this._faultHandlers == null) {
            this._faultHandlers = new Vector.<Function>();
        }
        var _loc2_:int = 0;
        while (_loc2_ < rest.length) {
            this._faultHandlers.push(rest[_loc2_]);
            _loc2_++;
        }
        return this;
    }

    public function execute():void {
        if (this._conditions == null || this._conditions.length == 0) {
            this.callResults();
        }
        else {
            this._conditionIndex = 0;
            this.checkCondition(this._conditions[this._conditionIndex]);
        }
    }

    protected function checkCondition(param1:Condition):void {
    }

    protected function checkNextCondition():void {
        if (++this._conditionIndex < this._conditions.length) {
            this.checkCondition(this._conditions[this._conditionIndex]);
        }
        else {
            this.checkFinished();
        }
    }

    protected function checkFinished():void {
    }

    protected function callResults():void {
        this.callHandlers(this._resultHandlers);
    }

    protected function callFaults():void {
        this.callHandlers(this._faultHandlers);
    }

    private function callHandlers(param1:Vector.<Function>):void {
        if (param1 == null) {
            return;
        }
        var _loc2_:int = 0;
        while (_loc2_ < param1.length) {
            param1[_loc2_]();
            _loc2_++;
        }
    }
}
}
