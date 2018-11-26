package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.StringUtil;
import common.localization.LocaleUtil;

import model.data.scenes.types.info.TroopsGroupId;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BattleExperienceIncreaserItem;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class EffectTroopsTierBattleExperienceAerospaceBuilder implements IBlackMarketItemBuilder {

    private static const HOUR_IN_SECONDS:int = 60 * 60;


    public function EffectTroopsTierBattleExperienceAerospaceBuilder() {
        super();
    }

    protected static function buildDuration(param1:Number):String {
        return param1 / HOUR_IN_SECONDS + StringUtil.WHITESPACE + DateUtil.DOZEN_HOURS;
    }

    protected function fillLocaleData(param1:BattleExperienceIncreaserItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_effectTroopsTierBattleExperienceAerospace_name") + " +" + param1.power + "%";
        param1.description = LocaleUtil.getText("forms-blackMarketItems_effectTroopsTierBattleExperienceAerospace_description") + " " + buildDuration(param1.timeSeconds);
        param1.descriptionWithoutDuration = LocaleUtil.getText("forms-formPromotionOffers_tierBattleExperienceAerospaceDescription");
        param1.fullName = param1.name;
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_effectTroopsTierBattleExperienceAerospace_helpText");
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:BattleExperienceIncreaserItem = new BattleExperienceIncreaserItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.timeSeconds = param1.effectData.timeSeconds;
        _loc2_.power = param1.effectData.power;
        _loc2_.troopsGroupId = TroopsGroupId.AEROSPACE;
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
