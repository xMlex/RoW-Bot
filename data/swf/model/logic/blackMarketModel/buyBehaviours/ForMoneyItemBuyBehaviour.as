package model.logic.blackMarketModel.buyBehaviours {
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;

public class ForMoneyItemBuyBehaviour extends BuyBehaviourBase {


    private var _itemId:int;

    public function ForMoneyItemBuyBehaviour() {
        super();
    }

    override public function prepareBuy(param1:int, param2:BuyContext):void {
        this._itemId = param1;
    }

    override public function invoke():void {
    }

    private function resultHandler(param1:*):void {
        dispatchResult(param1);
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }
}
}
