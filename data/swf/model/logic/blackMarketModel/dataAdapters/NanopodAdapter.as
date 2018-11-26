package model.logic.blackMarketModel.dataAdapters {
import common.localization.LocaleUtil;

import configs.Global;

import model.data.Resources;
import model.logic.StaticDataManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;

public class NanopodAdapter {


    public function NanopodAdapter() {
        super();
    }

    public function adapt():BlackMarketItemRaw {
        if (!Global.SKILL_POINT_BLACK_CRYSTAL_ENABLED) {
            return null;
        }
        var _loc1_:BlackMarketItemRaw = new BlackMarketItemRaw();
        _loc1_.id = -1;
        _loc1_.isNanopod = true;
        _loc1_.name = LocaleUtil.getText("resourcesControl_nanopods");
        var _loc2_:Resources = new Resources();
        _loc2_.blackCrystals = StaticDataManager.blackMarketData.skillPointBlackCrystalPrice;
        _loc1_.price = _loc2_;
        return _loc1_;
    }
}
}
