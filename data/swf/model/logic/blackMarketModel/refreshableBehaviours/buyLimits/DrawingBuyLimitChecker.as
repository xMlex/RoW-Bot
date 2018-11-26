package model.logic.blackMarketModel.refreshableBehaviours.buyLimits {
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;

public class DrawingBuyLimitChecker extends DynamicStateObject implements IDynamicInteger {


    private var _value:int;

    public function DrawingBuyLimitChecker() {
        super();
    }

    public function get value():int {
        return this._value;
    }

    public function refresh():void {
        this._value = StaticDataManager.blackMarketData.drawingsPurchasesDailyLimit - UserManager.user.gameData.blackMarketData.drawingsPurchasesCount;
    }
}
}
