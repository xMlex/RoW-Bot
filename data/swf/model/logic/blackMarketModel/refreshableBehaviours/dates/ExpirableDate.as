package model.logic.blackMarketModel.refreshableBehaviours.dates {
import model.logic.ServerTimeManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;

public class ExpirableDate implements IDynamicDate {


    private var _saleEndDate:Date;

    private var _isExpired:Boolean;

    public function ExpirableDate() {
        super();
    }

    public function set value(param1:Date):void {
        this._saleEndDate = param1;
    }

    public function get value():Date {
        return this._saleEndDate;
    }

    public function get isExpired():Boolean {
        return this._isExpired;
    }

    public function refresh():void {
        if (this._saleEndDate == null) {
            this._isExpired = true;
            return;
        }
        this._isExpired = !isNaN(this._saleEndDate.date) && this._saleEndDate < ServerTimeManager.serverTimeNow;
    }
}
}
