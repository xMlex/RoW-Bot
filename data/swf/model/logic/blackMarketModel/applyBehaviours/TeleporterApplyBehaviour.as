package model.logic.blackMarketModel.applyBehaviours {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.applyBehaviours.contexts.UnitCancelApplyContext;
import model.logic.commands.world.UnitMovementBoostCmd;

public class TeleporterApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:UnitMovementBoostCmd;

    private var _itemId:int;

    public function TeleporterApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        var _loc3_:UnitCancelApplyContext = UnitCancelApplyContext(param2);
        this._itemId = param1;
        this._commandCache = new UnitMovementBoostCmd(_loc3_.unit, _loc3_.itemId);
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
