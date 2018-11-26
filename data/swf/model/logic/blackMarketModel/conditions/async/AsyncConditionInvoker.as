package model.logic.blackMarketModel.conditions.async {
import model.logic.blackMarketModel.conditions.interfaces.ICondition;
import model.logic.blackMarketModel.temporaryCore.AsyncActionObject;

public class AsyncConditionInvoker extends AsyncActionObject {


    private var _currentIndex:int;

    private var _conditions:Vector.<ICondition>;

    public function AsyncConditionInvoker(param1:Vector.<ICondition>) {
        super();
        this._conditions = param1;
    }

    override public function invoke():void {
        if (this._conditions == null || this._conditions.length == 0) {
            dispatchResult();
            return;
        }
        this._currentIndex = 0;
        this.checkCurrentCondition();
    }

    private function checkCurrentCondition():void {
        var _loc1_:ICondition = this._conditions[this._currentIndex];
        _loc1_.registerResult(this.changeCondition);
        _loc1_.registerFault(dispatchFault);
        _loc1_.invoke();
    }

    private function changeCondition():void {
        this._currentIndex++;
        if (this._currentIndex == this._conditions.length) {
            dispatchResult();
            return;
        }
        this.checkCurrentCondition();
    }
}
}
