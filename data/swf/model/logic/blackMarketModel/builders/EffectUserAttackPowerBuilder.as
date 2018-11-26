package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.EffectUserAttackPowerItem;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class EffectUserAttackPowerBuilder implements IBlackMarketItemBuilder {


    public function EffectUserAttackPowerBuilder() {
        super();
    }

    protected static function fillLocaleData(param1:EffectUserAttackPowerItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_effectUserAttackPower_name");
        param1.description = LocaleUtil.getText("forms-blackMarketItems_effectUserAttackPower_description") + " " + buildDuration(param1.timeSeconds);
        param1.fullName = param1.name;
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_effectUserAttackPower_helpText");
    }

    protected static function buildDuration(param1:Number):String {
        var _loc2_:String = param1 / 60 / 60 + " " + DateUtil.SEVERAL_HOURS;
        return _loc2_;
    }

    private static function buildImageUrl(param1:EffectUserAttackPowerItem):String {
        if (param1.itemType == BlackMarketItemType.EFFECT_USER_ATTACK_POWER_BC) {
            return BuilderHelper.buildImageUrlBlackCrystal(param1.id);
        }
        return param1.iconUrl;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:EffectUserAttackPowerItem = new EffectUserAttackPowerItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.timeSeconds = param1.effectData.timeSeconds;
        _loc2_.power = param1.effectData.power;
        _loc2_.newUntil = param1.newUntil;
        _loc2_.iconUrl = buildImageUrl(_loc2_);
        fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
