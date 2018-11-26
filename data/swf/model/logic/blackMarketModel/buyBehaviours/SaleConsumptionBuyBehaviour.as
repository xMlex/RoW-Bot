package model.logic.blackMarketModel.buyBehaviours {
import model.data.acceleration.types.BoostTypeId;
import model.data.stats.GoldMoneySourceType;
import model.logic.PaymentManager;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.blackMarketModel.buyBehaviours.contexts.SaleConsumptionBuyContext;
import model.logic.commands.sector.BuyBoostCmd;
import model.logic.commands.sector.SetResourceConsumptionBonusBoostsAutoRenewalCmd;

public class SaleConsumptionBuyBehaviour extends BuyBehaviourBase {


    private var _commandCache:BuyBoostCmd;

    private var _itemId:int;

    private var _context:SaleConsumptionBuyContext;

    public function SaleConsumptionBuyBehaviour() {
        super();
    }

    override public function prepareBuy(param1:int, param2:BuyContext):void {
        this._itemId = param1;
        this._context = param2 as SaleConsumptionBuyContext;
        var _loc3_:BlackMarketItemRaw = StaticDataManager.blackMarketData.itemsById[this._itemId];
        this._commandCache = new BuyBoostCmd(BoostTypeId.RESOURCES_CONSUMPTION_MONEY, -1, _loc3_.saleConsumptionBonus, false, _loc3_.id);
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler():void {
        dispatchResult();
        var _loc1_:Number = this._context.actualPrice;
        UserManager.user.gameData.constructionData.consumptionChanged = true;
        UserManager.user.gameData.dispatchEvents();
        if (UserManager.user.gameData.constructionData.resourceConsumptionBonusBoostAutoRenewal) {
            new SetResourceConsumptionBonusBoostsAutoRenewalCmd(false).execute();
        }
        if (_loc1_ > 0) {
            PaymentManager.addPayment(int(_loc1_), int(UserManager.user.gameData.account.resources.goldMoney), ServerTimeManager.serverTimeNow, GoldMoneySourceType.BoostResourcesConsumptionMoney);
        }
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }
}
}
