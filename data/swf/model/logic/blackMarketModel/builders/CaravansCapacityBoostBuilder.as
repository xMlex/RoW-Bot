package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.CaravansCapacityBoostItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.StubDiscountContext;

public class CaravansCapacityBoostBuilder implements IBlackMarketItemBuilder {


    public function CaravansCapacityBoostBuilder() {
        super();
    }

    protected function fillLocaleData(param1:BlackMarketItemBase):void {
        param1.name = LocaleUtil.getText("forms-formBlackMarket_labelTitleCaravans");
        param1.fullName = param1.name;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:CaravansCapacityBoostItem = new CaravansCapacityBoostItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.boostValue = param1.caravansCapacityBoostType.boostValue;
        _loc2_.discountContext = new StubDiscountContext();
        _loc2_.description = LocaleUtil.getText("forms-formBlackMarket_labelDescriptionCaravans");
        _loc2_.iconUrl = new RewardUrl("resources").build(RewardUrl.BM, RewardUrl.PNG);
        _loc2_.newUntil = param1.newUntil;
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
