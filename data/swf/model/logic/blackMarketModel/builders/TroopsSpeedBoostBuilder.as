package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.TroopsSpeedBoostItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class TroopsSpeedBoostBuilder implements IBlackMarketItemBuilder {


    public function TroopsSpeedBoostBuilder() {
        super();
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:TroopsSpeedBoostItem = new TroopsSpeedBoostItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.durationTime = param1.effectData.timeSeconds;
        _loc2_.power = param1.effectData.power;
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }

    private function fillLocaleData(param1:TroopsSpeedBoostItem):void {
        param1.name = LocaleUtil.buildString("forms-blackMarketItems_effectTroopsSpeedBoost_name", param1.power);
        param1.description = LocaleUtil.buildString("forms-blackMarketItems_effectTroopsSpeedBoost_description_for_time", DateUtil.formatTimeMMSSLetters(param1.durationTime));
        param1.descriptionWithoutDuration = LocaleUtil.getText("forms-blackMarketItems_effectTroopsSpeedBoost_description");
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_effectTroopsSpeedBoost_helpText");
    }
}
}
