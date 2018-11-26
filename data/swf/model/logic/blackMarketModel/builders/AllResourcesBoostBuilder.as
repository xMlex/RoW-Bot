package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ResourceBoostItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class AllResourcesBoostBuilder implements IBlackMarketItemBuilder {

    private static const DAY:String = LocaleUtil.getText("forms-formLoyaltyProgram_daysLeftControl_day0");

    private static const DAYS:String = LocaleUtil.getText("forms-formLoyaltyProgram_daysLeftControl_day1");


    public function AllResourcesBoostBuilder() {
        super();
    }

    protected static function fillLocaleData(param1:ResourceBoostItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_boostResourcesHeader") + " +" + param1.boostRatio + "%";
        param1.description = LocaleUtil.getText("forms-blackMarketItems_boostAllResources_description") + " " + formatDate(param1.duration);
        param1.shortDescription = LocaleUtil.getText("forms-blackMarketItems_boostAllResources_shortDescription");
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

    public static function formatDateForUrl(param1:Number):String {
        var _loc2_:String = null;
        switch (param1) {
            case DateUtil.SECONDS_1_DAY:
                _loc2_ = "1day";
                break;
            case DateUtil.SECONDS_3_DAYS:
                _loc2_ = "3days";
        }
        return _loc2_;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:ResourceBoostItem = new ResourceBoostItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.resources = param1.resourcesBoostData.resources;
        _loc2_.duration = param1.resourcesBoostData.durationSeconds;
        _loc2_.boostRatio = param1.resourcesBoostData.resources.titanite;
        _loc2_.fullName = LocaleUtil.getText("forms-blackMarketItems_boostResourcesHeader") + " +" + param1.resourcesBoostData.resources.money + "%";
        fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
