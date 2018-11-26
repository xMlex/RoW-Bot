package model.logic.blackMarketModel.buyBehaviours {
import model.data.Resources;
import model.data.stats.GoldMoneySourceType;
import model.logic.PaymentManager;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.commands.sector.BuyBlackMarketItemCmd;

public class BlackMarketItemBuyBehaviour extends BuyBehaviourBase {


    private var _commandCache:BuyBlackMarketItemCmd;

    private var _itemId:int;

    public function BlackMarketItemBuyBehaviour() {
        super();
    }

    override public function prepareBuy(param1:int, param2:BuyContext):void {
        this._commandCache = new BuyBlackMarketItemCmd(param1, 1, param2.activate);
        this._itemId = param1;
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler(param1:*):void {
        dispatchResult(param1);
        var _loc2_:Resources = new Resources();
        if (param1 && param1.o) {
            _loc2_ = Resources.fromDto(param1.o.p);
        }
        var _loc3_:Object = new Object();
        _loc3_[this._itemId] = 1;
        PaymentManager.addPayment(_loc2_.goldMoney, int(UserManager.user.gameData.account.resources.goldMoney), ServerTimeManager.serverTimeNow, GoldMoneySourceType.BlackMarketData, _loc3_);
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }
}
}
