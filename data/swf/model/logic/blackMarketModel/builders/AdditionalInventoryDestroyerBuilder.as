package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.AdditionalInventoryDestroyerItem;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class AdditionalInventoryDestroyerBuilder implements IBlackMarketItemBuilder {


    public function AdditionalInventoryDestroyerBuilder() {
        super();
    }

    private static function buildDuration(param1:Number):String {
        var _loc2_:String = "[undefined item in black market]";
        _loc2_ = DateUtil.formatTimeDDHHHFullName(param1);
        return _loc2_;
    }

    private static function fillLocaleData(param1:AdditionalInventoryDestroyerItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_additionalInventoryDestroyer_name");
        param1.description = LocaleUtil.getText("forms-blackMarketItems_additionalInventoryDestroyer_description") + " " + buildDuration(param1.duration.toSeconds());
        param1.fullName = param1.name;
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_additionalInventoryDestroyer_helpText");
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:AdditionalInventoryDestroyerItem = new AdditionalInventoryDestroyerItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.duration = param1.inventoryItemDestroyerData.duration;
        fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
