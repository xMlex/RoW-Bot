package model.logic.blackMarketModel.refreshableBehaviours {
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.blackMarketModel.builders.UnitBuilder;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicNumber;

public class UnitPowerRefresher implements IDynamicNumber {


    private var _value:Number;

    private var _gsoType:GeoSceneObjectType;

    public function UnitPowerRefresher(param1:GeoSceneObjectType) {
        super();
        this._gsoType = param1;
    }

    public function get value():Number {
        return this._value;
    }

    public function refresh():void {
        if (this._gsoType.troopsInfo.isAttacking) {
            this._value = UnitBuilder.buildOffence(this._gsoType);
        }
        else if (this._gsoType.troopsInfo.isDefensive) {
            this._value = UnitBuilder.buildDefence(this._gsoType);
        }
        else if (this._gsoType.troopsInfo.isRecon) {
            this._value = UnitBuilder.buildIntelligence(this._gsoType);
        }
    }
}
}
