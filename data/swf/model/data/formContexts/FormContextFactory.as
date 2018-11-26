package model.data.formContexts {
import common.localization.LocaleUtil;

import model.data.Resources;
import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.logic.StaticDataManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.inventory.SealedInventoryItemData;

public class FormContextFactory {

    private static const HEADER_TEXT:String = LocaleUtil.getText("tools-BuyRequirementsHelper_NotResources");

    private static const DESCRIPTION_TEXT:String = LocaleUtil.getText("forms-formRequirement_buildingUpgrade_description");

    private static const BLACK_MARKET_TEXT:String = LocaleUtil.getText("forms-common_black_market");

    private static const BUY_ITEM_DESCRIPTION_TEXT:String = LocaleUtil.getText("forms-formRequirement_wantBuyItem");

    private static const OK_TEXT:String = LocaleUtil.getText("global-app_ok");

    private static const YES_TEXT:String = LocaleUtil.getText("global-app_yes");

    private static const NO_TEXT:String = LocaleUtil.getText("global-app_no");

    private static const ALERT_TEXT:String = LocaleUtil.getText("forms_biochips_alert_title");


    public function FormContextFactory() {
        super();
    }

    public static function createBlackMarketRequirement(param1:Resources, param2:Boolean = false):RequirementFormContext {
        var _loc3_:RequirementFormContext = new RequirementFormContext();
        var _loc4_:String = !!param2 ? getDescription(param1) : DESCRIPTION_TEXT;
        _loc3_.requirementItemData = new RequirementItemData();
        _loc3_.requirementItemData.missingResources = param1;
        _loc3_.requirementItemData.isResources = true;
        _loc3_.textData = new FormTextDataBase(HEADER_TEXT, _loc4_, OK_TEXT, BLACK_MARKET_TEXT);
        _loc3_.navigation = new RequirementNavigationContext("items", 604, 2701);
        return _loc3_;
    }

    public static function createInventoryKeyRequirement(param1:SealedInventoryItemData):RequirementFormContext {
        var _loc2_:RequirementFormContext = new RequirementFormContext();
        _loc2_.requirementItemData = new RequirementItemData();
        _loc2_.requirementItemData.isItem = true;
        _loc2_.requirementItemData.missingItemUrl = new BMIRewardUrl(param1.keyId).build(RewardUrl.BM, RewardUrl.PNG);
        _loc2_.requirementItemData.missingItemGoldMoneyPrice = BlackMarketItemRaw(StaticDataManager.blackMarketData.itemsById[param1.keyId]).price.goldMoney;
        _loc2_.requirementItemData.itemId = param1.keyId;
        _loc2_.textData = new FormTextDataBase(ALERT_TEXT, BUY_ITEM_DESCRIPTION_TEXT, YES_TEXT, NO_TEXT);
        return _loc2_;
    }

    private static function getDescription(param1:Resources):String {
        var _loc2_:String = "";
        if (param1.upgradeItems) {
            if (param1.upgradeItems.technologyUpgrades > 0) {
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_technologyUpgradeHeader");
            }
            else if (param1.upgradeItems.technologyUpgradesHigherLevel > 0) {
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_technologyHigherLevelUpgradeHeader");
            }
        }
        return LocaleUtil.buildString("forms-formRequirement_technologyUpgrade_description", _loc2_);
    }
}
}
