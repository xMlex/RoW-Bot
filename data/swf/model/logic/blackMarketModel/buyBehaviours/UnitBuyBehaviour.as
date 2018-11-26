package model.logic.blackMarketModel.buyBehaviours {
import model.data.scenes.types.GeoSceneObjectType;
import model.data.stats.GoldMoneySourceType;
import model.logic.BlackMarketTroopsType;
import model.logic.PaymentManager;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.commands.sector.BuyBlackMarketOfferCmd;
import model.logic.discountOffers.UserDiscountOfferManager;

public class UnitBuyBehaviour extends BuyBehaviourBase {


    private var _commandCache:BuyBlackMarketOfferCmd;

    public function UnitBuyBehaviour() {
        super();
    }

    override public function prepareBuy(param1:int, param2:BuyContext):void {
        this._commandCache = new BuyBlackMarketOfferCmd(param1, param2.count);
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler():void {
        dispatchResult();
        var _loc1_:GeoSceneObjectType = StaticDataManager.getObjectType(this._commandCache.sotId);
        var _loc2_:Object = UserDiscountOfferManager.discountTroop(_loc1_.robotTroopsId, _loc1_.troopsInfo.groupId, _loc1_.troopsInfo.kindId);
        var _loc3_:Object = new Object();
        _loc3_[this._commandCache.sotId] = this._commandCache.count;
        var _loc4_:Number = _loc2_.discount > 0 ? Number(1 - _loc2_.discount) : Number(1);
        var _loc5_:Number = this.getPrice(this._commandCache.sotId) * _loc4_;
        PaymentManager.addPayment(Math.round(_loc5_ * this._commandCache.count), int(UserManager.user.gameData.account.resources.goldMoney), ServerTimeManager.serverTimeNow, GoldMoneySourceType.TroopsPurchaseOrUpgrade, _loc3_);
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }

    private function getPrice(param1:int):Number {
        var _loc2_:BlackMarketTroopsType = null;
        for each(_loc2_ in StaticDataManager.blackMarketData.troopTypes) {
            if (param1 == _loc2_.troopsTypeId) {
                return _loc2_.price.goldMoney;
            }
        }
        return 0;
    }
}
}
