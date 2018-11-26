package model.logic.blackMarketModel.refreshableBehaviours {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicBoolean;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;

public class DeletedExpiredGachaChestChecker implements IDynamicBoolean {


    private var _value:Boolean;

    private var _date:IDynamicDate;

    private var _userChestId:int;

    public function DeletedExpiredGachaChestChecker(param1:IDynamicDate, param2:int) {
        super();
        this._date = param1;
        this._userChestId = param2;
    }

    public function get value():Boolean {
        return this._value;
    }

    public function refresh():void {
        this._value = false;
        if (this._date == null || this._userChestId < 0) {
            return;
        }
        this._date.refresh();
        this._value = this._date.isExpired;
    }
}
}
