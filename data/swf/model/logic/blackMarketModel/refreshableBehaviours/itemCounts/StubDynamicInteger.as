package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;

public class StubDynamicInteger extends DynamicStateObject implements IDynamicInteger {


    public function StubDynamicInteger() {
        super();
    }

    public function get value():int {
        return 0;
    }

    public function refresh():void {
    }
}
}
