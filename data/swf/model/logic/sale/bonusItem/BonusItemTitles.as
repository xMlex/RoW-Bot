package model.logic.sale.bonusItem {
import common.localization.LocaleUtil;

import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.data.scenes.types.info.TechnologyTypeId;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.quests.data.CollectibleThemedItemsEvent;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;

public class BonusItemTitles {


    public function BonusItemTitles() {
        super();
    }

    public function sectorSkin(param1:int):String {
        return StaticDataManager.getSkinNameById(param1);
    }

    public function gemChestItem():String {
        return LocaleUtil.getText("forms-formBlackMarket-chestItemRenderer_labelNameChest");
    }

    public function gemRemovalItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function boostItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_boostHeader");
    }

    public function teleportatorItem(param1:BlackMarketItemRaw):String {
        return LocaleUtil.getText("forms-blackMarketItems_teleportersHeader");
    }

    public function vipActivatorItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_vipActivatorHeader");
    }

    public function vipPointsItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_vipPointsHeader");
    }

    public function resourcesBoost():String {
        return LocaleUtil.getText("forms-blackMarketItems_boostResourcesHeader");
    }

    public function discardSkillsItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function sectorTeleportItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function updateSectorItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function upgradeBuildingsItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function upgradeLowerLevelTechnologyItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function upgradeHigherLevelTechnologyItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function inventoryKeyItem(param1:int):String {
        if (param1 < BlackMarketItemsTypeId.InventoryChestTier1Uncommon) {
            return LocaleUtil.getText("bonusItem_heroKey_name");
        }
        return LocaleUtil.getText("bonusItem_heroChest_name");
    }

    public function staticBonusPackItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function boostMoneyConsumptionItem():String {
        return LocaleUtil.getText("bonusItem_boostMoneyConsumption_name");
    }

    public function cancelUnitItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function resetDailyItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_resetDaily_name");
    }

    public function additionalRaidLocationItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function autoMoveTroopsBunkerEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_userAutoMoveTroopsBunker_name");
    }

    public function attackPowerEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectUserAttackPower_name");
    }

    public function defensePowerEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectUserDefencePower_name");
    }

    public function attackAndDefensePowerEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectUserAttackAndDefencePower_name");
    }

    public function fullProtectionEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectUserFullProtection_name");
    }

    public function protectionIntelligenceEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectUserProtectionIntelligence_name");
    }

    public function fakeArmyEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectUserFakeArmy_name");
    }

    public function bonusBattleExperienceEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectUserBonusBattleExperience_name");
    }

    public function sectorDefensePowerBonusEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectSectorDefencePowerBonus_name");
    }

    public function dynamicMinesBonusMiningSpeedEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectMinesBonusMiningSpeed_name");
    }

    public function tierBattleExperienceInfantryEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectTroopsTierBattleExperienceInfantry_name");
    }

    public function tierBattleExperienceArmouredEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectTroopsTierBattleExperienceArmoured_name");
    }

    public function tierBattleExperienceArtilleryEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectTroopsTierBattleExperienceArtillery_name");
    }

    public function tierBattleExperienceAerospaceEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectTroopsTierBattleExperienceAerospace_name");
    }

    public function effectItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function additionalResearcherItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_additionalResearcher_name");
    }

    public function additionalInventoryItemDestroyerItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_additionalInventoryDestroyer_name");
    }

    public function allianceCiytTeleportItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function constructionPointsItem(param1:BlackMarketItemRaw):String {
        return param1.name;
    }

    public function gemSlotActivatorItem(param1:BlackMarketItemRaw):String {
        return param1.name;
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

    public function themedItems():String {
        var _loc1_:QuestState = UserManager.user.gameData.questData.activeThemedEvent;
        if (_loc1_ == null || !_loc1_.isActual()) {
            return "";
        }
        var _loc2_:Quest = UserManager.user.gameData.questData.getQuestById(_loc1_.questId);
        var _loc3_:CollectibleThemedItemsEvent = _loc2_.collectibleThemedItemsEvent;
        return _loc3_.itemName;
    }
}
}
