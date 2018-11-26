package model.logic.blackMarketModel.buyBehaviours {
import model.data.stats.GoldMoneySourceType;
import model.logic.PaymentManager;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.blackMarketModel.buyBehaviours.contexts.DrawingPartBuyContext;
import model.logic.commands.sector.BuyBlackMarketOfferCmd;
import model.logic.discountOffers.UserDiscountOfferManager;

public class DrawingPartBuyBehaviour extends BuyBehaviourBase {


    private var _commandCache:BuyBlackMarketOfferCmd;

    public function DrawingPartBuyBehaviour() {
        super();
    }

    override public function prepareBuy(param1:int, param2:BuyContext):void {
        var _loc3_:DrawingPartBuyContext = DrawingPartBuyContext(param2);
        this._commandCache = new BuyBlackMarketOfferCmd(param1 + 100, _loc3_.partNumber);
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    protected function addPayment():void {
        var _loc1_:Number = UserDiscountOfferManager.getDiscountCoefficient(this._commandCache.sotId - 100);
        var _loc2_:Object = new Object();
        _loc2_[this._commandCache.sotId - 100] = 1;
        PaymentManager.addPayment(BuyBlackMarketOfferCmd.getPrice(this._commandCache.sotId).goldMoney * (1 - _loc1_), int(UserManager.user.gameData.account.resources.goldMoney), ServerTimeManager.serverTimeNow, GoldMoneySourceType.DrawingPurchase, _loc2_);
    }

    private function resultHandler():void {
        dispatchResult();
        this.addPayment();
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }
}
}
