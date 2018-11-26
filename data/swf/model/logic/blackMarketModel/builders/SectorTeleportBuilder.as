package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.SectorTeleportItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class SectorTeleportBuilder implements IBlackMarketItemBuilder {


    public function SectorTeleportBuilder() {
        super();
    }

    protected function fillLocaleData(param1:SectorTeleportItem):void {
        param1.name = !!param1.random ? LocaleUtil.getText("forms-blackMarketItems_sectorRandomTeleportHeader") : LocaleUtil.getText("forms-blackMarketItems_sectorTeleportHeader");
        param1.fullName = param1.name;
        param1.description = LocaleUtil.getText("forms-blackMarketItems_sectorTeleportDescription");
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:SectorTeleportItem = new SectorTeleportItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.random = param1.sectorTeleportData.random;
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
