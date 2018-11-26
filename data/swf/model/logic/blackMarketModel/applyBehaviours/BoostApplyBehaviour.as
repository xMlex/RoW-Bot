package model.logic.blackMarketModel.applyBehaviours {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyStandardBoostContext;
import model.logic.commands.sector.BuyBoostCmd;

public class BoostApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:BuyBoostCmd;

    private var _itemId:int;

    public function BoostApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        var _loc3_:ApplyStandardBoostContext = ApplyStandardBoostContext(param2);
        this._commandCache = new BuyBoostCmd(_loc3_.boostTypeId, _loc3_.objectId, -1, false, param1, _loc3_.count);
        this._itemId = param1;
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler():void {
        dispatchResult(null);
    }

    private function faultHandler(param1:*):void {
        trace("BlackMarketItem Activation fault, itemId: " + this._itemId.toString());
        dispatchFault(param1);
    }
}
}
