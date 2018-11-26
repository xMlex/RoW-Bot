package model.logic.filterSystem.sorts {
import common.queries.util.query;

import model.data.scenes.types.info.TroopsKindId;
import model.data.scenes.types.info.TroopsTypeId;
import model.logic.StaticDataManager;
import model.logic.discountOffers.UserDiscountOfferManager;
import model.logic.filterSystem.contexts.blackMarket.UnitSortContext;
import model.logic.filterSystem.dataProviders.IUnitDataProvider;
import model.logic.filterSystem.filters.DataFilterBase;
import model.logic.troops.TroopsManager;

public class UnitDefaultSorter extends DataFilterBase {


    public function UnitDefaultSorter() {
        super();
        _context = new UnitSortContext();
    }

    override protected function filter_impl(param1:Array):Array {
        var data:Array = param1;
        return query(data).orderByDescending(function (param1:IUnitDataProvider):* {
            var _loc2_:* = StaticDataManager.getObjectType(param1.id);
            var _loc3_:* = UserDiscountOfferManager.discountTroop(param1.id, _loc2_.troopsInfo.groupId, _loc2_.troopsInfo.kindId).discount;
            if (TroopsTypeId.isAvp(param1.id)) {
                _loc3_ = 1;
            }
            return _loc3_;
        }).thenBy(function (param1:IUnitDataProvider):* {
            var _loc2_:* = StaticDataManager.getObjectType(param1.id);
            if (_loc2_.troopsInfo.missileInfo != null) {
                return 1;
            }
            if (_loc2_.troopsInfo.kindId == TroopsKindId.RECON) {
                return 2;
            }
            return 3;
        }).thenByDescending(function (param1:IUnitDataProvider):* {
            var _loc2_:* = StaticDataManager.getObjectType(param1.id);
            switch (_loc2_.troopsInfo.kindId) {
                case TroopsKindId.ATTACKING:
                    return _loc2_.troopsInfo.baseParameters.attackPoints;
                case TroopsKindId.DEFENSIVE:
                    return TroopsManager.getAverageDefenceWithBonuses(_loc2_.troopsInfo.baseParameters.defenseParameters, _loc2_.id);
                case TroopsKindId.RECON:
                    return _loc2_.troopsInfo.baseParameters.reconPower;
                default:
                    return;
            }
        }).toArray();
    }
}
}
