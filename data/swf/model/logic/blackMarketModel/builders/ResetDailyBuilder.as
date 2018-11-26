package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.data.quests.DailyQuestKind;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ResetDailyItem;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class ResetDailyBuilder implements IBlackMarketItemBuilder {


    public function ResetDailyBuilder() {
        super();
    }

    protected static function buildDescription(param1:int):String {
        var _loc2_:String = "[undefined item in black market]";
        switch (param1) {
            case DailyQuestKind.Daily:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_resetDaily_descriptionSolo");
                break;
            case DailyQuestKind.Alliance:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_resetDaily_descriptionAlliance");
                break;
            case DailyQuestKind.Vip:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_resetDaily_descriptionVip");
        }
        return _loc2_;
    }

    protected static function fillLocaleData(param1:ResetDailyItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_resetDaily_name");
        param1.description = buildDescription(param1.dailyQuestKind);
        param1.fullName = param1.name;
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_resetDaily_helpText");
    }

    private static function buildImageUrl(param1:ResetDailyItem):void {
        if (param1.itemType == BlackMarketItemType.RESET_DAILY_BC) {
            param1.iconUrl = BuilderHelper.buildImageUrlBlackCrystal(param1.id);
        }
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:ResetDailyItem = new ResetDailyItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.dailyQuestKind = param1.resetDailyData.dailyQuestKind;
        fillLocaleData(_loc2_);
        buildImageUrl(_loc2_);
        return _loc2_;
    }
}
}
