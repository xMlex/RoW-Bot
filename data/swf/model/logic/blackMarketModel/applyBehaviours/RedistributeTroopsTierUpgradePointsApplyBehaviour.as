package model.logic.blackMarketModel.applyBehaviours {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.applyBehaviours.contexts.DistributeUpgradePointsApplyContext;
import model.logic.commands.troopsTier.RedistributeUpgradePointsCmd;

public class RedistributeTroopsTierUpgradePointsApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:RedistributeUpgradePointsCmd;

    private var _itemId:int;

    public function RedistributeTroopsTierUpgradePointsApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        this._itemId = param1;
        var _loc3_:DistributeUpgradePointsApplyContext = param2 as DistributeUpgradePointsApplyContext;
        if (_loc3_ != null) {
            this._commandCache = new RedistributeUpgradePointsCmd(_loc3_);
        }
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler():void {
        dispatchResult();
    }

    private function faultHandler(param1:*):void {
        trace("BlackMarketItem Activation fault, itemId: " + this._itemId.toString());
        dispatchFault(param1);
    }
}
}
