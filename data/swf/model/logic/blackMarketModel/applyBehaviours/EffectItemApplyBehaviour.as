package model.logic.blackMarketModel.applyBehaviours {
import model.logic.UserManager;
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.commands.blackMarcket.ActivateEffectItemCmd;

public class EffectItemApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:ActivateEffectItemCmd;

    private var _itemId:int;

    public function EffectItemApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        this._itemId = param1;
        this._commandCache = new ActivateEffectItemCmd(this._itemId, UserManager.user.id);
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler(param1:*):void {
        dispatchResult(param1);
    }

    private function faultHandler(param1:*):void {
        trace("BlackMarketItem Activation fault, itemId: " + this._itemId.toString());
        dispatchFault(param1);
    }
}
}
