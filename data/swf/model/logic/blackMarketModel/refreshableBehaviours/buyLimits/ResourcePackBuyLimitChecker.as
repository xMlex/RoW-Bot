package model.logic.blackMarketModel.refreshableBehaviours.buyLimits {
import model.logic.ResourcesKitLimit;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicBoolean;

public class ResourcePackBuyLimitChecker implements IDynamicBoolean {


    private var _value:Boolean;

    public function ResourcePackBuyLimitChecker() {
        super();
    }

    public function get value():Boolean {
        return this._value;
    }

    public function refresh():void {
        var _loc1_:ResourcesKitLimit = StaticDataManager.getResourcesKitLimit(UserManager.user.gameData.account.level);
        var _loc2_:int = _loc1_.maxKitsBoughtPerDay - UserManager.user.gameData.commonData.boughtResourceKitIds.length;
        this._value = _loc2_ == 0;
    }
}
}
