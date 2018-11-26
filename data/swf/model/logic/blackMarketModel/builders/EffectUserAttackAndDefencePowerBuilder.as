package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.EffectUserAttackAndDefencePowerItem;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class EffectUserAttackAndDefencePowerBuilder implements IBlackMarketItemBuilder {


    public function EffectUserAttackAndDefencePowerBuilder() {
        super();
    }

    protected static function fillLocaleData(param1:EffectUserAttackAndDefencePowerItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_effectUserAttackAndDefencePower_name") + " +" + param1.power + "%";
        param1.description = LocaleUtil.getText("forms-blackMarketItems_effectUserAttackAndDefencePower_description") + " " + buildDuration(param1.timeSeconds);
        param1.fullName = param1.name;
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_effectUserAttackAndDefencePower_helpText");
    }

    protected static function buildDuration(param1:Number):String {
        var _loc2_:String = DateUtil.formatTimeDDHHHFullName(param1);
        return _loc2_;
    }

    private static function buildImageUrl(param1:EffectUserAttackAndDefencePowerItem):void {
        if (param1.itemType == BlackMarketItemType.EFFECT_USER_DEFENCE_POWER_BC) {
            param1.iconUrl = BuilderHelper.buildImageUrlBlackCrystal(param1.id);
        }
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:EffectUserAttackAndDefencePowerItem = new EffectUserAttackAndDefencePowerItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.timeSeconds = param1.effectData.timeSeconds;
        _loc2_.power = param1.effectData.power;
        fillLocaleData(_loc2_);
        buildImageUrl(_loc2_);
        return _loc2_;
    }
}
}
