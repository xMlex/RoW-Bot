package model.logic.sale.bonusItem {
import common.DateUtil;
import common.StringUtil;
import common.localization.LocaleUtil;

import model.data.effects.EffectTypeId;
import model.data.inventory.InventoryItemRareness;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.data.scenes.types.info.TechnologyTypeId;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.enums.UpdateSectorType;
import model.logic.quests.data.CollectibleThemedItemsEvent;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;

public class BonusItemFullNames {


    public function BonusItemFullNames() {
        super();
    }

    public function inventoryKeyItem(param1:BlackMarketItemRaw):String {
        var _loc2_:* = null;
        if (param1.id >= BlackMarketItemsTypeId.InventoryChestTier1Uncommon) {
            return param1.name;
        }
        _loc2_ = StringUtil.EMPTY;
        switch (param1.inventoryKeyData.rareness) {
            case InventoryItemRareness.UNCOMMON:
                _loc2_ = " (" + LocaleUtil.getText("forms-formHero_inventoryControlDescription_Uncommon") + ")";
                break;
            case InventoryItemRareness.RARE:
                _loc2_ = " (" + LocaleUtil.getText("forms-formHero_inventoryControlDescription_Rare") + ")";
                break;
            case InventoryItemRareness.EPIC:
                _loc2_ = " (" + LocaleUtil.getText("forms-formHero_inventoryControlDescription_Epic") + ")";
                break;
            case InventoryItemRareness.ALL_RARENESS:
                _loc2_ = " (" + LocaleUtil.getText("forms-formHero_inventoryControlDescription_AllRareness") + ")";
        }
        return param1.name + _loc2_;
    }

    public function sectorSkin(param1:int):String {
        return StaticDataManager.getSkinNameById(param1);
    }

    public function gemChestItem(param1:BlackMarketItemRaw, param2:int):String {
        var _loc3_:String = "";
        if (param1.chestData.gemLevelFrom == param1.chestData.gemLevelTo) {
            _loc3_ = String(param1.chestData.gemLevelFrom);
        }
        else {
            _loc3_ = String(param1.chestData.gemLevelFrom) + " - " + String(param1.chestData.gemLevelTo);
        }
        if (param2 == 1) {
            return LocaleUtil.getText("forms-formBlackMarket-chestItemRenderer_labelNameChest") + ": " + param2 + ". " + LocaleUtil.getText("forms-PrizeControlPvPGM_itemGems") + " " + param2 * param1.chestData.gemCount + " (" + LocaleUtil.getText("forms-PrizeControlPvPGM_itemGemsLevel") + " " + _loc3_ + ")";
        }
        return LocaleUtil.getText("forms-PrizeControlPvPGM_itemChests") + " " + param2 + ". " + LocaleUtil.getText("forms-PrizeControlPvPGM_itemGems") + " " + param2 * param1.chestData.gemCount + " (" + LocaleUtil.getText("forms-PrizeControlPvPGM_itemGemsLevel") + " " + _loc3_ + ")";
    }

    public function gemRemovalItem(param1:BlackMarketItemRaw):String {
        var _loc2_:String = "";
        if (param1.gemRemovalData.gemLevelFrom == param1.gemRemovalData.gemLevelTo) {
            _loc2_ = String(param1.gemRemovalData.gemLevelFrom);
        }
        else {
            _loc2_ = String(param1.gemRemovalData.gemLevelFrom) + " - " + String(param1.gemRemovalData.gemLevelTo);
        }
        return LocaleUtil.getText("forms-formBlackMarket-chestItemRenderer_labelGemRemoval") + " " + LocaleUtil.getText("forms-PrizeControlPvPGM_itemGemsLevel") + " " + _loc2_;
    }

    public function vipActivatorItem(param1:int):String {
        if (param1 / 60 <= 60) {
            return LocaleUtil.getText("forms-blackMarketItems_vipActivatorHeader") + ": " + LocaleUtil.buildString("forms-formGameVisit_loyaltyDay_prizeItem_min", param1 / 60);
        }
        return LocaleUtil.getText("forms-blackMarketItems_vipActivatorHeader") + ": " + DateUtil.formatTimeDDHHLetters(param1);
    }

    public function vipPointsItem(param1:int, param2:int):String {
        return LocaleUtil.getText("forms-blackMarketItems_vipPointsDescription") + " " + param1 * param2;
    }

    public function boostItem(param1:int, param2:int):String {
        var _loc3_:String = null;
        if (param2 > 1) {
            _loc3_ = LocaleUtil.getText("forms-blackMarketItems_boosts");
        }
        else {
            _loc3_ = LocaleUtil.getText("forms-blackMarketItems_boostHeader");
        }
        if (param1 / 60 < 60) {
            return _loc3_ + ": " + LocaleUtil.buildString("forms-formGameVisit_loyaltyDay_prizeItem_min", param1 / 60);
        }
        return _loc3_ + ": " + DateUtil.formatTimeDDHHLetters(param1);
    }

    public function teleportatorItem(param1:Number):String {
        return LocaleUtil.getText("forms-blackMarketItems_teleportersHeader") + " " + ((1 - param1) * 100).toString() + " %";
    }

    public function inventory(param1:int):String {
        var _loc2_:String = null;
        switch (param1) {
            case TechnologyTypeId.TechIdAerospaceComplex:
                _loc2_ = "forms-formHero_inventoryItemSealed_typeDragons";
                break;
            case TechnologyTypeId.TechIdArtillerySystemsCenter:
                _loc2_ = "forms-formHero_inventoryItemSealed_typeElves";
                break;
            case TechnologyTypeId.TechIdMotorizedInfantryFactory:
                _loc2_ = "forms-formHero_inventoryItemSealed_typeOrks";
                break;
            case TechnologyTypeId.TechIdBarracks:
                _loc2_ = "forms-formHero_inventoryItemSealed_typeNords";
        }
        return LocaleUtil.getText(_loc2_);
    }

    public function effectItem(param1:BlackMarketItemRaw):String {
        var _loc2_:String = StringUtil.EMPTY;
        switch (param1.effectData.effectTypeId) {
            case EffectTypeId.UserAutoMoveTroopsBunker:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_userAutoMoveTroopsBunker_name");
                break;
            case EffectTypeId.UserAttackPower:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectUserAttackPower_name") + StringUtil.WHITESPACE + param1.effectData.power + StringUtil.PERCENT;
                break;
            case EffectTypeId.UserDefensePower:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectUserDefencePower_name") + StringUtil.WHITESPACE + param1.effectData.power + StringUtil.PERCENT;
                break;
            case EffectTypeId.UserAttackAndDefensePowerBonus:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectUserAttackAndDefencePower_name") + StringUtil.WHITESPACE + StringUtil.PLUS + param1.effectData.power + StringUtil.PERCENT + StringUtil.NEW_LINE + StringUtil.LEFT_BRACKET + DateUtil.formatTimeDDHHHFullName(param1.effectData.timeSeconds) + StringUtil.RIGHT_BRACKET;
                break;
            case EffectTypeId.UserFullProtection:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectUserFullProtection_name");
                break;
            case EffectTypeId.UserProtectionIntelligence:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectUserProtectionIntelligence_name");
                break;
            case EffectTypeId.UserBonusBattleExperience:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectUserBonusBattleExperience_name") + " +" + param1.effectData.power + StringUtil.PERCENT;
                break;
            case EffectTypeId.UserFakeArmy:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectUserFakeArmy_name");
                break;
            case EffectTypeId.SectorDefensePowerBonus:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectSectorDefencePowerBonus_name") + StringUtil.WHITESPACE + StringUtil.PLUS + param1.effectData.power + StringUtil.PERCENT;
                break;
            case EffectTypeId.DynamicMinesBonusMiningSpeed:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectMinesBonusMiningSpeed_name") + StringUtil.WHITESPACE + StringUtil.PLUS + param1.effectData.power + StringUtil.PERCENT;
                break;
            case EffectTypeId.UnlimitedSectorTeleport:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_unlimitedTeleport_name") + StringUtil.WHITESPACE + StringUtil.LEFT_BRACKET + DateUtil.formatTimeMMSSLettersSpaceless(param1.effectData.timeSeconds) + StringUtil.RIGHT_BRACKET;
                break;
            case EffectTypeId.TroopsSpeedBoost:
                _loc2_ = LocaleUtil.buildString("forms-blackMarketItems_effectTroopsSpeedBoost_name", param1.effectData.power);
                break;
            case EffectTypeId.TroopsTierBattleExperienceInfantry:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectTroopsTierBattleExperienceInfantry_name") + StringUtil.WHITESPACE + StringUtil.PLUS + param1.effectData.power + StringUtil.PERCENT;
                break;
            case EffectTypeId.TroopsTierBattleExperienceArmoured:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectTroopsTierBattleExperienceArmoured_name") + StringUtil.WHITESPACE + StringUtil.PLUS + param1.effectData.power + StringUtil.PERCENT;
                break;
            case EffectTypeId.TroopsTierBattleExperienceArtillery:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectTroopsTierBattleExperienceArtillery_name") + StringUtil.WHITESPACE + StringUtil.PLUS + param1.effectData.power + StringUtil.PERCENT;
                break;
            case EffectTypeId.TroopsTierBattleExperienceAerospace:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_effectTroopsTierBattleExperienceAerospace_name") + StringUtil.WHITESPACE + StringUtil.PLUS + param1.effectData.power + StringUtil.PERCENT;
        }
        return _loc2_;
    }

    public function themedItems(param1:int):String {
        var _loc2_:QuestState = UserManager.user.gameData.questData.activeThemedEvent;
        if (_loc2_ == null) {
            return "";
        }
        var _loc3_:Quest = UserManager.user.gameData.questData.getQuestById(_loc2_.questId);
        var _loc4_:CollectibleThemedItemsEvent = _loc3_.collectibleThemedItemsEvent;
        var _loc5_:String = _loc4_.itemRares[param1] != null ? _loc4_.itemRares[param1].code : "";
        return _loc4_.itemName + StringUtil.colonLocale() + StringUtil.WHITESPACE + _loc5_;
    }

    public function sectorTeleportItem(param1:Boolean):String {
        if (param1) {
            return LocaleUtil.getText("forms-blackMarketItems_sectorRandomTeleportHeader");
        }
        return LocaleUtil.getText("forms-blackMarketItems_sectorTeleportHeader");
    }

    public function updateSectorItem(param1:int):String {
        if (param1 == UpdateSectorType.RENAME) {
            return LocaleUtil.getText("forms-common-heroNameChange");
        }
        return LocaleUtil.getText("forms-common-heroChange");
    }

    public function moneyBoost(param1:Number, param2:int):String {
        return LocaleUtil.buildString("forms-common_moneyBoost", param1 + "%", param2);
    }

    public function uraniumBoost(param1:Number, param2:int):String {
        return LocaleUtil.buildString("forms-common_uraniumBoost", param1 + "%", param2);
    }

    public function titaniumBoost(param1:Number, param2:int):String {
        return LocaleUtil.buildString("forms-common_titaniumBoost", param1 + "%", param2);
    }

    public function allResourcesBoost(param1:Number, param2:int):String {
        return LocaleUtil.buildString("forms-blackMarketItems_boostAllResources_description_days", param1, param2);
    }

    public function boostMoneyConsumptionItem(param1:int, param2:Number):String {
        var _loc3_:int = param2 / DateUtil.SECONDS_1_DAY;
        return LocaleUtil.buildString("forms-blackMarketItems_boostMoneyConsumption_name_days", param1, _loc3_);
    }

    public function experience(param1:int):String {
        return LocaleUtil.buildString("forms-formQuest_QuestWizard_prizeItemControl_item01", param1.toString());
    }

    public function goldMoney():String {
        return LocaleUtil.getText("forms-common_crystalls");
    }

    public function blackCrystal():String {
        return LocaleUtil.buildString("resourcesControl_BlackCrystal");
    }

    public function constructionWorker():String {
        return LocaleUtil.buildString("controls_account_controls_workers");
    }

    public function vipPointsPasse():String {
        return LocaleUtil.getText("forms-blackMarketItems_vipPointsHeader");
    }

    public function money():String {
        return LocaleUtil.getText("forms-common_money");
    }

    public function uranium():String {
        return LocaleUtil.getText("forms-common_uranium");
    }

    public function titanite():String {
        return LocaleUtil.getText("forms-common_titanite");
    }

    public function biochip():String {
        return LocaleUtil.getText("forms-formHelp_biochips_header");
    }

    public function constructionItems():String {
        return LocaleUtil.getText("forms-common_constructionItem");
    }

    public function discardSkillsItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_spreaderSkillsHeader");
    }

    public function upgradeBuildingsItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_buildingUpgradeHeader");
    }

    public function upgradeLowerLevelTechnologyItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_technologyUpgradeHeader");
    }

    public function upgradeHigherLevelTechnologyItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_technologyHigherLevelUpgradeHeader");
    }

    public function staticBonusPackItem():String {
        return LocaleUtil.getText("forms-formAllianceMissions-missionDescription_prizeInMarket");
    }

    public function cancelUnitItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_cancelUnit_name");
    }

    public function resetDailyItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function additionalRaidLocationItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_additionalRaidLocation_name");
    }

    public function additionalResearcherItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_additionalResearcher_name");
    }

    public function additionalInventoryItemDestroyerItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_additionalInventoryDestroyer_name");
    }

    public function skillPoints():String {
        return LocaleUtil.getText("resourcesControl_nanopods");
    }

    public function dust():String {
        return LocaleUtil.getText("forms-common_dust");
    }

    public function dragonSkillPoints():String {
        return LocaleUtil.getText("common-dragonResources_skillPoints");
    }

    public function wisdomSkillPoints():String {
        return LocaleUtil.getText("form-trophyDetailsControl_wisdomPoints");
    }

    public function allianceResourceCash():String {
        return LocaleUtil.getText("forms-FormResourceHistory_cash");
    }

    public function allianceResourceTechPoints():String {
        return LocaleUtil.getText("forms-FormResourceHistory_points");
    }

    public function buff():String {
        return LocaleUtil.getText("forms-formApplyBuffDebuff_buffTitle");
    }

    public function debuff():String {
        return LocaleUtil.getText("forms-formApplyBuffDebuff_debuffTitle");
    }

    public function dragonResourcesJade():String {
        return LocaleUtil.getText("common-dragonResources_jadeName");
    }

    public function dragonResourcesOpal():String {
        return LocaleUtil.getText("common-dragonResources_opalName");
    }

    public function dragonResourcesRuby():String {
        return LocaleUtil.getText("common-dragonResources_rubyName");
    }

    public function character():String {
        return LocaleUtil.getText("forms-formQuest_vipQuest_prizeItemControl_character");
    }
}
}
