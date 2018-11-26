package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.AdditionalResearcherItem;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class AdditionalResearcherBuilder implements IBlackMarketItemBuilder {


    public function AdditionalResearcherBuilder() {
        super();
    }

    protected static function buildDuration(param1:Number):String {
        var _loc2_:String = "[undefined item in black market]";
        _loc2_ = DateUtil.formatTimeDDHHHFullName(param1);
        return _loc2_;
    }

    protected static function fillLocaleData(param1:AdditionalResearcherItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_additionalResearcher_name");
        param1.description = LocaleUtil.getText("forms-blackMarketItems_additionalResearcher_description") + " " + buildDuration(param1.duration.toSeconds());
        param1.fullName = param1.name;
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_additionalResearcher_helpText");
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:AdditionalResearcherItem = new AdditionalResearcherItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.duration = param1.researcherData.duration;
        fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
