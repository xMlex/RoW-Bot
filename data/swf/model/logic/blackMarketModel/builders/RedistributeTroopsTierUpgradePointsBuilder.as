package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.RedistributeTroopsTierUpgradePointsItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class RedistributeTroopsTierUpgradePointsBuilder implements IBlackMarketItemBuilder {


    public function RedistributeTroopsTierUpgradePointsBuilder() {
        super();
    }

    protected function fillLocaleData(param1:RedistributeTroopsTierUpgradePointsItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_redistributeUpgradePointsItem_name");
        param1.description = LocaleUtil.getText("forms-blackMarketItems_redistributeUpgradePointsItem_description");
        param1.fullName = param1.name;
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_redistributeUpgradePointsItem_helpText");
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:RedistributeTroopsTierUpgradePointsItem = new RedistributeTroopsTierUpgradePointsItem();
        BuilderHelper.fill(_loc2_, param1);
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
