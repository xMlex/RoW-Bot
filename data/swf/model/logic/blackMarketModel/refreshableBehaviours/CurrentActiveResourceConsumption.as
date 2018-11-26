package model.logic.blackMarketModel.refreshableBehaviours {
import flash.events.Event;

import model.data.users.acceleration.ConstructionData;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicObject;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;

public class CurrentActiveResourceConsumption extends DynamicStateObject implements IDynamicObject {


    private var _value:Object;

    public function CurrentActiveResourceConsumption(param1:Boolean) {
        super();
        if (param1) {
            UserManager.user.gameData.constructionData.addEventHandler(ConstructionData.CONSUMPTION_CHANGED, this.userDataChangeHandler);
        }
    }

    public function get value():Object {
        return this._value;
    }

    public function refresh():void {
        this._value = UserManager.user.gameData.constructionData.getActiveConsumptionBonusBoost();
    }

    private function userDataChangeHandler(param1:Event = null):void {
        this.refresh();
        dispatchChange();
    }
}
}
