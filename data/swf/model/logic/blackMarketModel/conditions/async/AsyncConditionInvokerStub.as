package model.logic.blackMarketModel.conditions.async {
import model.logic.blackMarketModel.temporaryCore.AsyncActionObject;

public class AsyncConditionInvokerStub extends AsyncActionObject {


    public function AsyncConditionInvokerStub() {
        super();
    }

    override public function invoke():void {
        dispatchResult();
    }
}
}
