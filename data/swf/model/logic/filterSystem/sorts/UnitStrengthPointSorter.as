package model.logic.filterSystem.sorts {
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.TroopsGroupId;
import model.data.scenes.types.info.TroopsKindId;
import model.data.scenes.types.info.TroopsTypeInfo;
import model.logic.StaticDataManager;
import model.logic.filterSystem.contexts.blackMarket.UnitSortContext;
import model.logic.filterSystem.dataProviders.IUnitDataProvider;
import model.logic.filterSystem.filters.DataFilterBase;

public class UnitStrengthPointSorter extends DataFilterBase {


    public function UnitStrengthPointSorter() {
        super();
        _context = new UnitSortContext();
    }

    override protected function filter_impl(param1:Array):Array {
        return param1.sort(this._sortFnc);
    }

    private function _sortFnc(param1:IUnitDataProvider, param2:IUnitDataProvider):int {
        var _loc3_:GeoSceneObjectType = StaticDataManager.getObjectType(param1.id);
        var _loc4_:GeoSceneObjectType = StaticDataManager.getObjectType(param2.id);
        return this.compareTroops(_loc3_, _loc4_, this.calculatePower(_loc3_), this.calculatePower(_loc4_));
    }

    private function calculatePower(param1:GeoSceneObjectType):int {
        var _loc2_:int = 0;
        var _loc3_:TroopsTypeInfo = param1.troopsInfo;
        if (_loc3_.kindId == TroopsKindId.RECON) {
            return 1;
        }
        if (_loc3_.kindId == TroopsKindId.ATTACKING) {
            _loc2_ = _loc2_ + 1;
        }
        switch (_loc3_.groupId) {
            case TroopsGroupId.INFANTRY:
            case TroopsGroupId.INFANTRY_2:
                _loc2_ = _loc2_ + 2;
                break;
            case TroopsGroupId.ARTILLERY:
            case TroopsGroupId.ARTILLERY_2:
                _loc2_ = _loc2_ + 6;
                break;
            case TroopsGroupId.ARMOURED:
            case TroopsGroupId.ARMOURED_2:
                _loc2_ = _loc2_ + 4;
                break;
            case TroopsGroupId.AEROSPACE:
            case TroopsGroupId.AEROSPACE_2:
                _loc2_ = _loc2_ + 8;
                break;
            default:
                throw new Error("У юнита TroopsGroupId который не определен в данном контексте");
        }
        return _loc2_;
    }

    private function compareTroops(param1:GeoSceneObjectType, param2:GeoSceneObjectType, param3:int, param4:int):int {
        var _loc5_:int = this.comparator(param3, param4);
        if (_loc5_ != 0) {
            return _loc5_;
        }
        if (param1.troopsInfo.isAttacking) {
            return this.comparator(param1.troopBaseParameters.attackPoints, param2.troopBaseParameters.attackPoints);
        }
        return this.comparator(param1.troopBaseParameters.defensePoints, param2.troopBaseParameters.defensePoints);
    }

    private function comparator(param1:Number, param2:Number):int {
        if (param1 > param2) {
            return -1;
        }
        if (param1 < param2) {
            return 1;
        }
        return 0;
    }
}
}
