package model.logic.sale.bonusItem.blocks {
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.TroopsLevelInfo;
import model.data.scenes.types.info.TroopsTypeInfo;
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IUnitFillingElement;
import model.logic.troops.TroopsManager;

public class UnitFillingBlock implements IAppliableFilling {


    private var _unit:GeoSceneObjectType;

    public function UnitFillingBlock(param1:GeoSceneObjectType) {
        super();
        this._unit = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.UNIT;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IUnitFillingElement = param1 as IUnitFillingElement;
        if (_loc2_ == null) {
            return;
        }
        var _loc3_:TroopsTypeInfo = this._unit.troopsInfo;
        var _loc4_:TroopsLevelInfo = this._unit.troopBaseParameters;
        _loc2_.fillIsRedUnit(this._unit.isRedUnit);
        if (_loc3_.isRecon) {
            _loc2_.fillReconPower(_loc4_.reconPower);
        }
        else if (_loc3_.isAttacking) {
            _loc2_.fillAttackPower(_loc4_.attackPower);
        }
        else if (_loc3_.isDefensive) {
            _loc2_.fillDefencePower(TroopsManager.getAverageDefenceWithoutBonuses(_loc4_.defenseParameters));
        }
    }
}
}
