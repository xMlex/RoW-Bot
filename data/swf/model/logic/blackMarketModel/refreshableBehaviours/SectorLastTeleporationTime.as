package model.logic.blackMarketModel.refreshableBehaviours {
import model.logic.UserManager;
import model.logic.blackMarketModel.core.SectorTeleportItem;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicNumber;

public class SectorLastTeleporationTime implements IDynamicNumber {


    private var _data:SectorTeleportItem;

    private var _value:Number;

    public function SectorLastTeleporationTime(param1:SectorTeleportItem) {
        super();
        this._data = param1;
    }

    public function get value():Number {
        return this._value;
    }

    public function refresh():void {
        this._value = 0;
        if (this._data.random) {
            if (UserManager.user.gameData.mapData.lastRandomTeleportationTime) {
                this._value = UserManager.user.gameData.mapData.lastRandomTeleportationTime.time;
            }
        }
        else if (UserManager.user.gameData.mapData.lastTeleportationTime) {
            this._value = UserManager.user.gameData.mapData.lastTeleportationTime.time;
        }
    }
}
}
