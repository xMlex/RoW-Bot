package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.AllianceCityTeleportItem;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class AllianceCityTeleportBuilder implements IBlackMarketItemBuilder {


    public function AllianceCityTeleportBuilder() {
        super();
    }

    protected function fillLocaleData(param1:AllianceCityTeleportItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_allianceCityTeleport_name");
        param1.fullName = param1.name;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:AllianceCityTeleportItem = new AllianceCityTeleportItem();
        BuilderHelper.fill(_loc2_, param1);
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
