package model.logic.blackMarketModel.buyBehaviours {
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.commands.BuySkillPointsCmd;

public class NanopodBuyBehaviour extends BuyBehaviourBase {


    private var _commandCache:BuySkillPointsCmd;

    public function NanopodBuyBehaviour() {
        super();
    }

    override public function prepareBuy(param1:int, param2:BuyContext):void {
        this._commandCache = new BuySkillPointsCmd(1);
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler():void {
        dispatchResult();
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }
}
}
