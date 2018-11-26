package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.DustBonusItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class DustBonusBuilder implements IBlackMarketItemBuilder {


    public function DustBonusBuilder() {
        super();
    }

    protected function fillLocaleData(param1:DustBonusItem):void {
        param1.description = LocaleUtil.getText("forms-blackMarketItems_dustBonus_description");
        param1.fullName = param1.name;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:DustBonusItem = new DustBonusItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.amount = param1.dustBonusData.amount;
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
