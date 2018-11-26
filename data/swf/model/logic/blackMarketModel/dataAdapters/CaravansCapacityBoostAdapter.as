package model.logic.blackMarketModel.dataAdapters {
import common.localization.LocaleUtil;

import model.data.acceleration.types.CaravansCapacityBoostType;
import model.logic.blackMarketItems.BlackMarketItemRaw;

public class CaravansCapacityBoostAdapter {


    public function CaravansCapacityBoostAdapter() {
        super();
    }

    public function adapt(param1:CaravansCapacityBoostType):BlackMarketItemRaw {
        var _loc2_:BlackMarketItemRaw = new BlackMarketItemRaw();
        _loc2_.id = param1.typeId;
        _loc2_.price = param1.price;
        _loc2_.name = LocaleUtil.getText("forms-formBlackMarket_labelTitleCaravans");
        _loc2_.caravansCapacityBoostType = param1;
        return _loc2_;
    }
}
}
