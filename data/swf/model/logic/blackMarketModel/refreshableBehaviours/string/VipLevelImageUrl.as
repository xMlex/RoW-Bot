package model.logic.blackMarketModel.refreshableBehaviours.string {
import common.GameType;

import model.logic.ServerManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicString;

public class VipLevelImageUrl implements IDynamicString {


    private var _value:String;

    public function VipLevelImageUrl() {
        super();
    }

    public function get value():String {
        return this._value;
    }

    public function refresh():void {
        var _loc1_:int = UserManager.user.gameData.vipData.vipLevel;
        if (GameType.isElves) {
            this._value = _loc1_ > 0 ? ServerManager.buildContentUrl("ui/vip/progress/separator/" + _loc1_.toString() + ".png") : null;
        }
        else if (GameType.isPirates || GameType.isSparta) {
            this._value = _loc1_ > 0 ? ServerManager.buildContentUrl("ui/vip/lvl/" + _loc1_.toString() + ".png") : null;
        }
        else {
            this._value = _loc1_ > 0 ? ServerManager.buildContentUrl("ui/vip/lvl/count/" + _loc1_.toString() + ".png") : null;
        }
    }
}
}
