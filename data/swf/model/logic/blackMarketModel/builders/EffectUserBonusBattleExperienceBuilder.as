package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.EffectUserBonusBattleExperienceItem;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class EffectUserBonusBattleExperienceBuilder implements IBlackMarketItemBuilder {


    public function EffectUserBonusBattleExperienceBuilder() {
        super();
    }

    protected static function buildDuration(param1:Number):String {
        var _loc2_:String = "[undefined item in black market]";
        _loc2_ = param1 / 60 / 60 + " " + DateUtil.DOZEN_HOURS;
        return _loc2_;
    }

    private static function buildImageUrl(param1:EffectUserBonusBattleExperienceItem):void {
        if (param1.itemType != BlackMarketItemType.EFFECT_USER_BONUS_BATTLE_EXPERIENCE) {
            param1.iconUrl = BuilderHelper.buildImageUrlBlackCrystal(param1.id);
        }
    }

    protected function fillLocaleData(param1:EffectUserBonusBattleExperienceItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_effectUserBonusBattleExperience_name") + " +" + param1.power + "%";
        param1.description = LocaleUtil.getText("forms-blackMarketItems_effectUserBonusBattleExperience_description") + " " + buildDuration(param1.timeSeconds);
        param1.fullName = param1.name;
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_effectUserBonusBattleExperience_helpText");
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:EffectUserBonusBattleExperienceItem = new EffectUserBonusBattleExperienceItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.timeSeconds = param1.effectData.timeSeconds;
        _loc2_.power = param1.effectData.power;
        this.fillLocaleData(_loc2_);
        buildImageUrl(_loc2_);
        return _loc2_;
    }
}
}
