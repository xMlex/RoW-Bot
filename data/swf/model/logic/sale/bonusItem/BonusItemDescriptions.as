package model.logic.sale.bonusItem {
import common.DateUtil;
import common.StringUtil;
import common.localization.LocaleUtil;

import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.EffectInfo;
import model.logic.blackMarketItems.enums.UpdateSectorType;

public class BonusItemDescriptions {


    public function BonusItemDescriptions() {
        super();
    }

    public function sectorSkin(param1:EffectInfo):String {
        return LocaleUtil.getText("forms-blackMarketItems_temporarySkin_description") + StringUtil.WHITESPACE + DateUtil.formatTimeDDHHHFullName(param1.timeSeconds);
    }

    public function sectorTeleportItem(param1:Boolean):String {
        if (param1) {
            return LocaleUtil.getText("forms-formPromotionOffers_sectorTeleportRandomDescription");
        }
        return LocaleUtil.getText("forms-formPromotionOffers_sectorTeleportDescription");
    }

    public function updateSectorItem(param1:int):String {
        if (param1 == UpdateSectorType.RENAME) {
            return LocaleUtil.getText("forms-formPromotionOffers_renameSectorDescription");
        }
        return LocaleUtil.getText("forms-formPromotionOffers_itemSelectCharacterDescription");
    }

    public function inventoryKeyItem(param1:BlackMarketItemRaw):String {
        if (param1.id == BlackMarketItemsTypeId.InventoryKeyEpicAllTiers) {
            return LocaleUtil.getText("forms-formHero_setOfKeys_InventoryKeyEpicAllTiers");
        }
        if (param1.id == BlackMarketItemsTypeId.InventoryKeyRareAllTiers) {
            return LocaleUtil.getText("forms-formHero_setOfKeys_InventoryKeyRareAllTiers");
        }
        if (param1.id == BlackMarketItemsTypeId.InventoryKeyUncommonAllTiers) {
            return LocaleUtil.getText("forms-formHero_setOfKeys_InventoryKeyUncommonAllTiers");
        }
        if (param1.id == BlackMarketItemsTypeId.InventoryKeyUniversal) {
            return LocaleUtil.getText("forms-formHero_setOfKeys_InventoryKeyUniversal");
        }
        if (param1.id >= BlackMarketItemsTypeId.InventoryChestTier1Uncommon) {
            return LocaleUtil.getText("forms-formPromotionOffers_inventoryChestDescription");
        }
        return LocaleUtil.getText("forms-formPromotionOffers_inventoryKeyDescription");
    }

    public function resetDailyItem(param1:int):String {
        return LocaleUtil.getText("forms-formPromotionOffers_resetDailyDescription" + param1);
    }

    public function troops(param1:int):String {
        return LocaleUtil.getText("forms-formPromotionOffer_troops_typeId_" + param1);
    }

    public function blackCrystal():String {
        return LocaleUtil.getText("forms-formPromotionOffers_blackCrystalsDescription");
    }

    public function constructionWorker():String {
        return LocaleUtil.getText("forms-formPromotionOffers_constructionWorkerDescription");
    }

    public function gemChestItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_gemChestDescription");
    }

    public function gemRemovalItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_gemRemovalDescription");
    }

    public function boostItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_boostDescription");
    }

    public function teleportatorItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_movementBoostDescription");
    }

    public function vipActivatorItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_vipActivatorDescription");
    }

    public function vipPointsItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_vipPointsDescription");
    }

    public function resources():String {
        return LocaleUtil.getText("forms-formPromotionOffers_addResourcesDescription");
    }

    public function constructionItems():String {
        return LocaleUtil.getText("form-PromotionOffer_constructionItemsDescription");
    }

    public function resourceBoost():String {
        return LocaleUtil.getText("forms-formPromotionOffers_resoursBoostDescription");
    }

    public function allResourcesBoost():String {
        return LocaleUtil.getText("forms-formPromotionOffers_allResoursesBoostDescription");
    }

    public function discardSkillsItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_discardSkillDescription");
    }

    public function upgradeBuildingItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_upgradeBuildingDescription");
    }

    public function upgradeLowerLevelTechnologyItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_upgradeTechnologyDescription");
    }

    public function boostMoneyConsumptionItem():String {
        return LocaleUtil.getText("forms-formPromotionOffer_resourceConsumptionDescription");
    }

    public function cancelUnitItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_cancelUnitDescription");
    }

    public function additionalRaidLocationItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_additionalRaidLocationDescription");
    }

    public function autoMoveTroopsBunkerEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_userAutoMoveTroopsBunkerDescription");
    }

    public function attackPowerEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_userAttackPowerDescription");
    }

    public function defencePowerEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_userDefensePowerDescription");
    }

    public function attackAndDefencePowerEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_userAttackAndDefensePowerDescription");
    }

    public function fullProtectionEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_userFullProtectionDescription");
    }

    public function protectionIntelligenceEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_userFullProtectionIntelligenceDescription");
    }

    public function fakeArmyEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_userFakeArmyDescription");
    }

    public function bonusBattleExperienceEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_userBonusBattleExpirienceDescription");
    }

    public function sectorDefencePowerEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_sectorDefencePowerDescription");
    }

    public function dynamicMinesBonusMiningEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_dynamicMinesBonusMiningDescription");
    }

    public function unlimitedTeleportEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_unlimitedTeleport_description");
    }

    public function troopsSpeedBoostEffectItem():String {
        return LocaleUtil.getText("forms-blackMarketItems_effectTroopsSpeedBoost_description");
    }

    public function tierBattleExperienceInfantryEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_tierBattleExperienceInfantryDescription");
    }

    public function tierBattleExperienceArmouredEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_tierBattleExperienceArmouredDescription");
    }

    public function tierBattleExperienceArtilleryEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_tierBattleExperienceArtilleryDescription");
    }

    public function tierBattleExperienceAerospaceEffectItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_tierBattleExperienceAerospaceDescription");
    }

    public function additionalResearcherItem():String {
        return LocaleUtil.getText("forms-formPromotionOffer_additionalResearcherDescription");
    }

    public function additionalInventoryItemDestroyerItem():String {
        return LocaleUtil.getText("forms-formPromotionOffer_inventoryItemDestroyerDescription");
    }

    public function allianceCiytTeleportItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_allianceCityTeleportDescription");
    }

    public function constructionPointsItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_constructionPointDescription");
    }

    public function gemSlotActivatorItem():String {
        return LocaleUtil.getText("forms-formPromotionOffers_gemSlotActivatorDescription");
    }

    public function skillPoints():String {
        return LocaleUtil.getText("forms-formPromotionOffers_nanopodsDescription");
    }

    public function dragonResourcesJade():String {
        return LocaleUtil.getText("common-dragonResources_jadeDescription");
    }

    public function dragonResourcesOpal():String {
        return LocaleUtil.getText("common-dragonResources_opalDescription");
    }

    public function dragonResourcesRuby():String {
        return LocaleUtil.getText("common-dragonResources_rubyDescription");
    }

    public function character():String {
        return LocaleUtil.getText("forms-formQuest_vipQuest_prizeItemControl_character_description");
    }

    public function gachaChest():String {
        return LocaleUtil.getText("forms-blackMarketItems_gachaChest_description");
    }

    public function dustBonus():String {
        return LocaleUtil.getText("forms-blackMarketItems_dustBonus_description");
    }

    public function themedItems():String {
        return LocaleUtil.getText("forms-formPromotionOffers_themedItemDescription");
    }
}
}
