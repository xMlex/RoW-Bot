package model.logic.blackMarketModel.dataAdapters {
import common.localization.LocaleUtil;

import model.data.acceleration.types.ExtraFavoriteUsersBoostType;
import model.logic.blackMarketItems.BlackMarketItemRaw;

public class ExtraFavoriteUsersBoostAdapter {


    public function ExtraFavoriteUsersBoostAdapter() {
        super();
    }

    public function adapt(param1:ExtraFavoriteUsersBoostType):BlackMarketItemRaw {
        var _loc2_:BlackMarketItemRaw = new BlackMarketItemRaw();
        _loc2_.id = param1.typeId;
        _loc2_.name = LocaleUtil.getText("forms-formBlackMarket_labelTitleNotes");
        _loc2_.price = param1.price;
        _loc2_.favoriteUsersBoostType = param1;
        return _loc2_;
    }
}
}
