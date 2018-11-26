package model.logic.blackMarketModel.buyBehaviours {
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.commands.sector.BuyExtraFavoriteUsersCmd;

public class ExtraFavoriteUsersBoostBuyBehaviour extends BuyBehaviourBase {


    private var _commandCache:BuyExtraFavoriteUsersCmd;

    public function ExtraFavoriteUsersBoostBuyBehaviour() {
        super();
    }

    override public function prepareBuy(param1:int, param2:BuyContext):void {
        this._commandCache = new BuyExtraFavoriteUsersCmd(param1);
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
