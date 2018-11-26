package model.logic.blackMarketModel.applyBehaviours {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.applyBehaviours.contexts.UnitCancelApplyContext;
import model.logic.commands.server.FaultDto;
import model.logic.commands.world.UnitCancelCmd;

public class CancelUnitApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:UnitCancelCmd;

    private var _itemId:int;

    public function CancelUnitApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        var _loc3_:UnitCancelApplyContext = UnitCancelApplyContext(param2);
        this._commandCache = new UnitCancelCmd(_loc3_.unit, _loc3_.itemId);
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler():void {
        dispatchResult(null);
    }

    private function faultHandler(param1:FaultDto):void {
        trace("BlackMarketItem Activation fault, itemId: " + this._itemId.toString());
        dispatchFault(param1);
    }
}
}
