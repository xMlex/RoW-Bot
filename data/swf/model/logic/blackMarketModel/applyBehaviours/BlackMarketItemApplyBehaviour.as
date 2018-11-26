package model.logic.blackMarketModel.applyBehaviours {
import model.logic.blackMarketItems.ActivateItemResponse;
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.commands.sector.ActivateBlackMarketItemCmd;

public class BlackMarketItemApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:ActivateBlackMarketItemCmd;

    private var _itemId:int;

    public function BlackMarketItemApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        this._commandCache = new ActivateBlackMarketItemCmd(param1, param2.useAutoBuying, param2.applyAll, null, param2.count);
        this._itemId = param1;
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler(param1:*, param2:ActivateItemResponse):void {
        param1.activateItemResponse = param2;
        dispatchResult(param1);
    }

    private function faultHandler(param1:*):void {
        trace("BlackMarketItem Activation fault, itemId: " + this._itemId.toString());
        dispatchFault(param1);
    }
}
}
