package model.logic.blackMarketModel.refreshableBehaviours {
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicBoolean;
import model.logic.filterSystem.dataProviders.ILevelProvider;

public class LevelReachedChecker implements IDynamicBoolean {


    private var _value:Boolean;

    private var _requiredLevel:int;

    public function LevelReachedChecker(param1:ILevelProvider) {
        super();
        this._requiredLevel = param1.level;
    }

    public function get value():Boolean {
        return this._value;
    }

    public function refresh():void {
        this._value = this._requiredLevel <= UserManager.user.gameData.account.level;
    }
}
}
