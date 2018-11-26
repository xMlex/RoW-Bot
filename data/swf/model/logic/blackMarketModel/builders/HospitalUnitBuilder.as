package model.logic.blackMarketModel.builders {
import common.GameType;

import model.data.scenes.types.GeoSceneObjectType;
import model.logic.UnitResurrectionHelper;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.UnitItem;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;
import model.logic.blackMarketModel.refreshableBehaviours.StubDynamicDate;

public class HospitalUnitBuilder extends UnitBuilder {


    public function HospitalUnitBuilder() {
        super();
    }

    override protected function buildInstance():UnitItem {
        return new UnitItem();
    }

    override protected function buildIconUrl(param1:GeoSceneObjectType):String {
        var _loc2_:String = null;
        if (param1.isStrategyUnit) {
            _loc2_ = param1.getUrlForRequirements();
        }
        else {
            _loc2_ = param1.getUrlForShop();
        }
        if (GameType.isMilitary) {
            _loc2_ = _loc2_.replace(".jpg", ".png");
            if (param1.isStrategyUnit) {
                _loc2_ = _loc2_.replace("_ps", "_bm02");
            }
        }
        if (GameType.isNords) {
            if (!param1.isStrategyUnit) {
                _loc2_ = _loc2_.replace(".jpg", ".png").replace("_p", "_ps");
            }
            else {
                _loc2_ = _loc2_.replace(".jpg", ".png");
            }
        }
        if (GameType.isPirates) {
            if (param1.isStrategyUnit) {
                _loc2_ = _loc2_.replace("_ps", "_p");
            }
        }
        return _loc2_;
    }

    override protected function buildPrice(param1:BlackMarketItemBase):void {
        param1.price = UnitResurrectionHelper.getHospitalPriceById(param1.id);
    }

    override protected function buildEndDate(param1:BlackMarketItemRaw):IDynamicDate {
        return new StubDynamicDate();
    }

    override protected function buildMinCount(param1:BlackMarketItemRaw):int {
        return 0;
    }

    override protected function buildSaleProhibited(param1:BlackMarketItemRaw):Boolean {
        return false;
    }

    override protected function buildMaxCount(param1:BlackMarketItemRaw):int {
        return param1.troopsCount;
    }

    override protected function buildStartDate(param1:BlackMarketItemRaw):IDynamicDate {
        return new StubDynamicDate();
    }
}
}
