package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;

public class StubOneDynamicInteger extends DynamicStateObject implements IDynamicInteger {


    public function StubOneDynamicInteger() {
        super();
    }

    public function get value():int {
        return 1;
    }

    public function refresh():void {
    }
}
}
