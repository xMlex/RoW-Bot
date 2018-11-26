package model.logic.blackMarketModel.refreshableBehaviours.buyLimits {
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicBoolean;

public class StrategyUnitBuyLimitChecker implements IDynamicBoolean {


    private var _value:Boolean;

    public function StrategyUnitBuyLimitChecker() {
        super();
    }

    public function get value():Boolean {
        return this._value;
    }

    public function refresh():void {
        this._value = StaticDataManager.blackMarketData.strategyTroopsPurchasesDailyLimit - UserManager.user.gameData.blackMarketData.strategyTroopsPurchasesCount <= 0;
    }
}
}
