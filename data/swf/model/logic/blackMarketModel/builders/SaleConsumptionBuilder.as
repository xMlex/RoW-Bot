package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.SaleConsumptionItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class SaleConsumptionBuilder implements IBlackMarketItemBuilder {


    public function SaleConsumptionBuilder() {
        super();
    }

    protected function fillLocaleData(param1:SaleConsumptionItem):void {
        param1.name = LocaleUtil.getText("forms-formBlackMarket_resourcesTab_saleOnAlimentationTroops") + LocaleUtil.getText("forms-formBlackMarket_currentSale");
        param1.fullName = param1.name + " (" + param1.saleConsumptionBonus + ")";
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:SaleConsumptionItem = new SaleConsumptionItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.saleConsumptionBonus = param1.saleConsumptionBonus;
        return _loc2_;
    }
}
}
