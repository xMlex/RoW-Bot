package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import flash.events.Event;

import model.data.users.misc.UserBlackMarketData;
import model.logic.UserManager;

public class ConstructionBlockCountNords extends ConstructionBlockCount {


    private var _changeHandler:Function;

    public function ConstructionBlockCountNords() {
        super();
        UserManager.user.gameData.blackMarketData.addEventHandler(UserBlackMarketData.DATA_CHANGED, this.dispatchChange);
    }

    override public function onChange(param1:Function):void {
        this._changeHandler = param1;
    }

    private function dispatchChange(param1:Event = null):void {
        if (this._changeHandler != null) {
            this._changeHandler();
        }
    }
}
}
