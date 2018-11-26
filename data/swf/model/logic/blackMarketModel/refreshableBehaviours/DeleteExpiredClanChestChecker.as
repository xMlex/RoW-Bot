package model.logic.blackMarketModel.refreshableBehaviours {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicBoolean;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;

public class DeleteExpiredClanChestChecker implements IDynamicBoolean {


    private var _value:Boolean;

    private var _date:IDynamicDate;

    public function DeleteExpiredClanChestChecker(param1:IDynamicDate) {
        super();
        this._date = param1;
    }

    public function get value():Boolean {
        return this._value;
    }

    public function refresh():void {
        this._value = false;
        if (this._date == null) {
            return;
        }
        this._date.refresh();
        this._value = this._date.isExpired;
    }
}
}
