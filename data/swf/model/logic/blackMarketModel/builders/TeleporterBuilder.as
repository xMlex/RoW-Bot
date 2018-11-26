package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.TeleporterItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class TeleporterBuilder implements IBlackMarketItemBuilder {


    public function TeleporterBuilder() {
        super();
    }

    protected function fillLocaledata(param1:TeleporterItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_teleportersHeader");
        param1.fullName = param1.name + " (" + (1 - param1.boostRatio) * 100 + "%)";
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:TeleporterItem = new TeleporterItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.duration = param1.boostData.timeSeconds;
        _loc2_.boostRatio = param1.boostData.speedUpCoefficient;
        _loc2_.isForSupportTroops = param1.boostData.applicableForSupportTroops;
        this.fillLocaledata(_loc2_);
        return _loc2_;
    }
}
}
