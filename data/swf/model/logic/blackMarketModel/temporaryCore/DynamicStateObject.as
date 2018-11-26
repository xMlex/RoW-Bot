package model.logic.blackMarketModel.temporaryCore {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicState;

public class DynamicStateObject implements IDynamicState {


    private var _changeHandler:Function;

    public function DynamicStateObject() {
        super();
    }

    protected function dispatchChange():void {
        if (this._changeHandler != null) {
            this._changeHandler();
        }
    }

    public function onChange(param1:Function):void {
        this._changeHandler = param1;
    }
}
}
