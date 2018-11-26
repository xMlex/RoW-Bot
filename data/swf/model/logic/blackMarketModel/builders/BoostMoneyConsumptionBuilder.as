package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.BoostMoneyConsumptionItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class BoostMoneyConsumptionBuilder implements IBlackMarketItemBuilder {

    private static const DAY:String = LocaleUtil.getText("forms-formLoyaltyProgram_daysLeftControl_day0");

    private static const DAYS:String = LocaleUtil.getText("forms-formLoyaltyProgram_daysLeftControl_day1");


    public function BoostMoneyConsumptionBuilder() {
        super();
    }

    protected static function fillLocaleData(param1:BoostMoneyConsumptionItem):void {
        param1.name = LocaleUtil.buildString("forms-blackMarketItems_boostMoneyConsumption_name", param1.resources.money);
        param1.description = LocaleUtil.getText("forms-blackMarketItems_boostMoneyConsumption_description") + " " + formatDate(param1.durationSecond);
    }

    protected static function formatDate(param1:Number):String {
        var _loc2_:String = null;
        switch (param1) {
            case DateUtil.SECONDS_1_DAY:
                _loc2_ = "1 " + DAY;
                break;
            case DateUtil.SECONDS_3_DAYS:
                _loc2_ = "3 " + DAYS;
        }
        return _loc2_;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:BoostMoneyConsumptionItem = new BoostMoneyConsumptionItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.durationSecond = param1.resourceConsumptionData.durationSeconds;
        _loc2_.resources = param1.resourceConsumptionData.resources;
        _loc2_.fullName = LocaleUtil.buildString("forms-blackMarketItems_boostMoneyConsumption_name", param1.resourceConsumptionData.resources.money);
        fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
