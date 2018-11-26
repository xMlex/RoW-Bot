package model.logic.blackMarketModel.refreshableBehaviours {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;

public class StubDynamicDate implements IDynamicDate {


    public function StubDynamicDate() {
        super();
    }

    public function get isExpired():Boolean {
        return false;
    }

    public function get value():Date {
        return null;
    }

    public function set value(param1:Date):void {
    }

    public function refresh():void {
    }
}
}
