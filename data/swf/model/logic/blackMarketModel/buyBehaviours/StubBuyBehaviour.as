package model.logic.blackMarketModel.buyBehaviours {
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;

public class StubBuyBehaviour implements IBuyBehaviour {


    public function StubBuyBehaviour() {
        super();
    }

    public function prepareBuy(param1:int, param2:BuyContext):void {
    }

    public function registerResult(param1:Function):void {
    }

    public function registerFault(param1:Function):void {
    }

    public function invoke():void {
    }
}
}
