package model.logic.blackMarketModel.refreshableBehaviours {
import model.logic.AllianceManager;
import model.logic.blackMarketModel.core.AllianceCityTeleportItem;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicNumber;

public class AllianceCityLastTeleportationTime implements IDynamicNumber {


    private var _data:AllianceCityTeleportItem;

    private var _value:Number;

    public function AllianceCityLastTeleportationTime(param1:AllianceCityTeleportItem) {
        super();
        this._data = param1;
    }

    public function get value():Number {
        return this._value;
    }

    public function refresh():void {
        if (!AllianceManager.currentAllianceCity || !AllianceManager.currentAllianceCity.gameData || !AllianceManager.currentAllianceCity.gameData.allianceCityData || !AllianceManager.currentAllianceCity.gameData.allianceCityData.lastTeleportationTime) {
            this._value = 0;
        }
        else {
            this._value = AllianceManager.currentAllianceCity.gameData.allianceCityData.lastTeleportationTime.time;
        }
    }
}
}
