package model.logic.blackMarketModel.refreshableBehaviours {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicBoolean;

public class StubDynamicBoolean implements IDynamicBoolean {


    public function StubDynamicBoolean() {
        super();
    }

    public function get value():Boolean {
        return false;
    }

    public function refresh():void {
    }
}
}
