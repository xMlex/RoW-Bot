package model.logic.blackMarketModel.applyBehaviours {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.applyBehaviours.contexts.TeleportObjectApplyContext;
import model.logic.map.commands.TeleportCmd;

public class MoveSectorItemApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:TeleportCmd;

    private var _itemId:int;

    public function MoveSectorItemApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        var _loc3_:TeleportObjectApplyContext = TeleportObjectApplyContext(param2);
        this._commandCache = new TeleportCmd(_loc3_.userNoteId, _loc3_.newMapPos, _loc3_.randomJump, _loc3_.isUnlimited);
        this._itemId = param1;
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler(param1:*):void {
        dispatchResult(param1);
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }
}
}
