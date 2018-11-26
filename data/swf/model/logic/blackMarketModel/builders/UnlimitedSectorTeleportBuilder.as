package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.UnlimitedSectorTeleportItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class UnlimitedSectorTeleportBuilder implements IBlackMarketItemBuilder {


    public function UnlimitedSectorTeleportBuilder() {
        super();
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:UnlimitedSectorTeleportItem = new UnlimitedSectorTeleportItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.durationTime = param1.effectData.timeSeconds;
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }

    private function fillLocaleData(param1:UnlimitedSectorTeleportItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_unlimitedTeleport_name");
        param1.description = LocaleUtil.getText("forms-blackMarketItems_unlimitedTeleport_description_for_time") + " " + DateUtil.formatTimeMMSSLetters(param1.durationTime);
        param1.descriptionWithoutDuration = LocaleUtil.getText("forms-blackMarketItems_unlimitedTeleport_description");
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_unlimitedTeleport_helpText");
    }
}
}
