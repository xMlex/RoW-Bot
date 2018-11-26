package model.logic.blackMarketModel.buyBehaviours {
import model.data.Resources;
import model.data.SectorSkinType;
import model.data.stats.GoldMoneySourceType;
import model.logic.PaymentManager;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.commands.sector.BuySectorSkinCmd;

public class SectorSkinBuyBehaviour extends BuyBehaviourBase {


    private var _commandCache:BuySectorSkinCmd;

    private var _itemId:int;

    public function SectorSkinBuyBehaviour() {
        super();
    }

    override public function prepareBuy(param1:int, param2:BuyContext):void {
        this._commandCache = new BuySectorSkinCmd(param1);
        this._itemId = param1;
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler(param1:*):void {
        dispatchResult();
        var _loc2_:SectorSkinType = StaticDataManager.getSectorSkinType(this._itemId);
        var _loc3_:Resources = param1.o != null ? Resources.fromDto(param1.o) : _loc2_.price;
        var _loc4_:Object = new Object();
        _loc4_[this._itemId] = 1;
        PaymentManager.addPayment(_loc3_.goldMoney, int(UserManager.user.gameData.account.resources.goldMoney), ServerTimeManager.serverTimeNow, GoldMoneySourceType.PurchaseInBlackMarket, _loc4_);
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }
}
}
