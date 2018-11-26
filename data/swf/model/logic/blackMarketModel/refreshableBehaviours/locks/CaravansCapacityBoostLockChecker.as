package model.logic.blackMarketModel.refreshableBehaviours.locks {
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicBoolean;

public class CaravansCapacityBoostLockChecker implements IDynamicBoolean {


    private var _value:Boolean;

    public function CaravansCapacityBoostLockChecker() {
        super();
    }

    public function get value():Boolean {
        return this._value;
    }

    public function refresh():void {
        var _loc1_:int = StaticDataManager.knownUsersData.maxCaravansCapacityBoost;
        var _loc2_:int = UserManager.user.gameData.constructionData.caravanCapacityPercentBoost;
        this._value = _loc2_ >= _loc1_;
    }
}
}
