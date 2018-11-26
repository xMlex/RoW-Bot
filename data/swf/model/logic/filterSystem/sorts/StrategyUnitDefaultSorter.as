package model.logic.filterSystem.sorts {
import common.queries.util.query;

import model.data.scenes.types.info.TroopsGroupId;
import model.data.scenes.types.info.TroopsKindId;
import model.data.scenes.types.info.TroopsTypeId;
import model.logic.StaticDataManager;
import model.logic.discountOffers.UserDiscountOfferManager;
import model.logic.filterSystem.contexts.blackMarket.UnitSortContext;
import model.logic.filterSystem.dataProviders.IUnitDataProvider;
import model.logic.filterSystem.filters.DataFilterBase;

public class StrategyUnitDefaultSorter extends DataFilterBase {


    public function StrategyUnitDefaultSorter() {
        super();
        _context = new UnitSortContext();
    }

    override protected function filter_impl(param1:Array):Array {
        var data:Array = param1;
        return query(data).orderByDescending(function (param1:IUnitDataProvider):* {
            var _loc2_:* = StaticDataManager.getObjectType(param1.id);
            var _loc3_:* = UserDiscountOfferManager.discountTroop(param1.id, _loc2_.troopsInfo.groupId, _loc2_.troopsInfo.kindId).discount;
            if (param1.id == TroopsTypeId.StrategyUnit10 || param1.id == TroopsTypeId.StrategyUnit11) {
                _loc3_ = 1;
            }
            if (TroopsTypeId.isAvp(param1.id)) {
                _loc3_ = 1;
            }
            return _loc3_;
        }).thenBy(function (param1:IUnitDataProvider):* {
            var _loc3_:* = undefined;
            var _loc2_:* = StaticDataManager.getObjectType(param1.id);
            if (_loc2_ == null || _loc2_.troopsInfo == null) {
                return 1;
            }
            if (_loc2_.troopsInfo.groupId == TroopsGroupId.AEROSPACE || _loc2_.troopsInfo.groupId == TroopsGroupId.AEROSPACE_2) {
                _loc3_ = 1;
            }
            else if (_loc2_.troopsInfo.groupId == TroopsGroupId.ARTILLERY || _loc2_.troopsInfo.groupId == TroopsGroupId.ARTILLERY_2) {
                _loc3_ = 2;
            }
            else if (_loc2_.troopsInfo.groupId == TroopsGroupId.ARMOURED || _loc2_.troopsInfo.groupId == TroopsGroupId.ARMOURED_2) {
                _loc3_ = 3;
            }
            else {
                _loc3_ = 4;
            }
            return _loc3_;
        }).thenBy(function (param1:IUnitDataProvider):* {
            var _loc2_:* = StaticDataManager.getObjectType(param1.id);
            if (_loc2_.troopsInfo.kindId == TroopsKindId.RECON) {
                return 1;
            }
            return 2;
        }).thenBy(function (param1:IUnitDataProvider):* {
            var _loc2_:* = StaticDataManager.getObjectType(param1.id);
            return _loc2_.troopsInfo.kindId;
        }).toArray();
    }
}
}
