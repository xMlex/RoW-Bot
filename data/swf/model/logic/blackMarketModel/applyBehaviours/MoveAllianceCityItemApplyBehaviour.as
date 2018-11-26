package model.logic.blackMarketModel.applyBehaviours {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.applyBehaviours.contexts.TeleportObjectApplyContext;
import model.logic.commands.allianceCity.TeleportCityCmd;

public class MoveAllianceCityItemApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:TeleportCityCmd;

    private var _itemId:int;

    public function MoveAllianceCityItemApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        var _loc3_:TeleportObjectApplyContext = TeleportObjectApplyContext(param2);
        this._commandCache = new TeleportCityCmd(_loc3_.newMapPos);
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
