package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.AdditionalRaidLocationData;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.AdditionalRaidLocationItem;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class AdditionalRaidLocationBuilder implements IBlackMarketItemBuilder {


    public function AdditionalRaidLocationBuilder() {
        super();
    }

    protected static function fillLocaleData(param1:AdditionalRaidLocationItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_additionalRaidLocation_name");
        param1.description = LocaleUtil.buildString("forms-blackMarketItems_additionalRaidLocation_description", param1.value);
        param1.helpText = LocaleUtil.buildString("forms-blackMarketItems_additionalRaidLocation_helpText", param1.value);
        param1.fullName = param1.name;
    }

    private function countValue(param1:BlackMarketItemRaw):int {
        var _loc3_:AdditionalRaidLocationData = null;
        var _loc2_:int = 0;
        var _loc4_:int = 0;
        while (_loc4_ < param1.additionalRaidLocationsData.length) {
            _loc3_ = param1.additionalRaidLocationsData[_loc4_];
            _loc2_ = _loc2_ + _loc3_.count;
            _loc4_++;
        }
        return _loc2_;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:AdditionalRaidLocationItem = new AdditionalRaidLocationItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.value = this.countValue(param1);
        fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
