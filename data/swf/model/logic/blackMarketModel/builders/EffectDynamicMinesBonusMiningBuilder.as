package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.StringUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.EffectDynamicMinesBonusMiningSpeedItem;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class EffectDynamicMinesBonusMiningBuilder implements IBlackMarketItemBuilder {


    public function EffectDynamicMinesBonusMiningBuilder() {
        super();
    }

    protected static function fillLocaleData(param1:EffectDynamicMinesBonusMiningSpeedItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_effectMinesBonusMiningSpeed_name") + StringUtil.WHITESPACE + StringUtil.PLUS + param1.power + StringUtil.PERCENT;
        param1.description = LocaleUtil.getText("forms-blackMarketItems_effectMinesBonusMiningSpeed_description") + " " + buildDuration(param1.timeSeconds);
        param1.fullName = param1.name;
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_effectMinesBonusMiningSpeed_helpText");
    }

    protected static function buildDuration(param1:Number):String {
        var _loc2_:String = "[undefined item in black market]";
        _loc2_ = param1 / 60 / 60 + " " + DateUtil.SEVERAL_HOURS;
        return _loc2_;
    }

    private static function buildImageUrl(param1:EffectDynamicMinesBonusMiningSpeedItem):String {
        if (param1.itemType == BlackMarketItemType.EFFECT_DYNAMIC_MINES_BONUS_MINING_BC) {
            return BuilderHelper.buildImageUrlBlackCrystal(param1.id);
        }
        return param1.iconUrl;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:EffectDynamicMinesBonusMiningSpeedItem = new EffectDynamicMinesBonusMiningSpeedItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.timeSeconds = param1.effectData.timeSeconds;
        _loc2_.power = param1.effectData.power;
        _loc2_.iconUrl = buildImageUrl(_loc2_);
        fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
