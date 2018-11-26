package model.logic.blackMarketModel {
import model.data.effects.EffectTypeId;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.logic.StaticDataManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.enums.BlackMarketPackType;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketTypeResolver;

public class ItemTypeResolver implements IBlackMarketTypeResolver {


    public function ItemTypeResolver() {
        super();
    }

    public function resolve(param1:BlackMarketItemRaw):int {
        if (param1.resourcesData && param1.resourcesData.resources.goldMoney == 0) {
            return BlackMarketItemType.RESOURCE_PACK;
        }
        if (param1.resourcesBoostData) {
            if (param1.resourcesBoostData.resources.isMUT) {
                return BlackMarketItemType.ALL_RESOURCES_BOOST;
            }
            return BlackMarketItemType.RESOURCE_BOOST;
        }
        if (param1.sectorSkinType) {
            return BlackMarketItemType.SECTOR_SKIN;
        }
        if (param1.troopsType && !param1.geoSceneObjectType.isStrategyUnit) {
            return BlackMarketItemType.UNIT;
        }
        if (param1.troopsType && param1.geoSceneObjectType.isStrategyUnit) {
            return BlackMarketItemType.STRATEGY_UNIT;
        }
        if (param1.geoSceneObjectType && param1.geoSceneObjectType.buildingInfo) {
            return BlackMarketItemType.BUILDING;
        }
        if (param1.geoSceneObjectType && param1.geoSceneObjectType.technologyInfo && param1.price.goldMoney > 0) {
            return BlackMarketItemType.DRAWING;
        }
        if (param1.geoSceneObjectType && param1.geoSceneObjectType.technologyInfo && param1.price.blackCrystals > 0) {
            return BlackMarketItemType.BLACK_CRYSTAL_DRAWING;
        }
        if (param1.isNanopod) {
            return BlackMarketItemType.NANOPOD;
        }
        if (param1.favoriteUsersBoostType) {
            return BlackMarketItemType.EXTRA_FAVORITE_USERS_BOOST;
        }
        if (param1.caravansCapacityBoostType) {
            return BlackMarketItemType.CARAVANS_CAPACITY_BOOST;
        }
        if (param1.geoSceneObjectType && param1.troopsCount > 0) {
            return BlackMarketItemType.HOSPITAL_UNIT;
        }
        if (param1.boostData && param1.boostData.timeSeconds > 0) {
            return BlackMarketItemType.BOOSTER;
        }
        if (param1.boostData && param1.boostData.timeSeconds == 0) {
            return BlackMarketItemType.TELEPORTER;
        }
        if (param1.vipActivatorData) {
            return BlackMarketItemType.VIP_ACTIVATOR;
        }
        if (param1.vipPointsData) {
            return BlackMarketItemType.VIP_POINTS;
        }
        if (param1.gemRemovalData) {
            return BlackMarketItemType.EXTRACTOR;
        }
        if (param1.chestData) {
            return BlackMarketItemType.CHEST;
        }
        if (param1.constructionPointsData) {
            return BlackMarketItemType.CONSTRUCTION;
        }
        if (param1.discardSkillsData) {
            return BlackMarketItemType.SKILL_DISCARD;
        }
        if (param1.staticBonusPackData) {
            return BlackMarketItemType.CLAN;
        }
        if (param1.sectorTeleportData != null) {
            return BlackMarketItemType.SECTOR_TELEPORT;
        }
        if (param1.saleConsumptionBonus > 0) {
            return BlackMarketItemType.SALE_CONSUMPTION;
        }
        if (param1.updateSectorData) {
            return BlackMarketItemType.UPDATE_SECTOR;
        }
        if (param1.resourcesData && param1.resourcesData.resources.goldMoney > 0) {
            return BlackMarketItemType.VIRALITY_CRYSTAL_PACK;
        }
        if (param1.inventoryItemData) {
            return BlackMarketItemType.KITS_CHESTS;
        }
        if (param1.inventoryKeyData) {
            return BlackMarketItemType.KEY;
        }
        if (param1.id == BlackMarketItemsTypeId.Slot_Rock) {
            return BlackMarketItemType.SLOT_ACTIVATOR;
        }
        if (param1.packData) {
            if (param1.packData.packType == BlackMarketPackType.UPGRADE_BUILDING) {
                return BlackMarketItemType.BUILDING_UPGRADE;
            }
            if (param1.packData.packType == BlackMarketPackType.UPGRADE_TECHNOLOGY_01 || param1.packData.packType == BlackMarketPackType.UPGRADE_TECHNOLOGY_02) {
                return BlackMarketItemType.TECHNOLOGY_UPGRADE;
            }
        }
        if (param1.constructionWorkerData) {
            return BlackMarketItemType.ADDITIONAL_WORKER;
        }
        if (param1.resourceConsumptionData) {
            return BlackMarketItemType.BOOST_MONEY_CONSUMPTION;
        }
        if (param1.effectData && param1.effectData.effectTypeId == EffectTypeId.UserAutoMoveTroopsBunker) {
            if (param1.price && param1.price.blackCrystals > 0) {
                return BlackMarketItemType.USER_AUTO_MOVE_TROOPS_BUNKER_BC;
            }
            return BlackMarketItemType.USER_AUTO_MOVE_TROOPS_BUNKER;
        }
        if (param1.cancelUnitData) {
            return BlackMarketItemType.CANCEL_UNIT;
        }
        if (param1.hiddenReconData) {
            return BlackMarketItemType.HIDDEN_RECON;
        }
        if (param1.resetDailyData) {
            if (param1.price && param1.price.blackCrystals > 0) {
                return BlackMarketItemType.RESET_DAILY_BC;
            }
            return BlackMarketItemType.RESET_DAILY;
        }
        if (param1.blueLightBonusData) {
            return BlackMarketItemType.BLUE_LIGHT;
        }
        if (param1.additionalRaidLocationsData) {
            return BlackMarketItemType.ADDITIONAL_RAID_LOCATION;
        }
        if (param1.effectData && param1.effectData.effectTypeId == EffectTypeId.UserAttackPower) {
            if (param1.price && param1.price.blackCrystals > 0) {
                return BlackMarketItemType.EFFECT_USER_ATTACK_POWER_BC;
            }
            return BlackMarketItemType.EFFECT_USER_ATTACK_POWER;
        }
        if (param1.effectData && param1.effectData.effectTypeId == EffectTypeId.UserDefensePower) {
            if (param1.price && param1.price.blackCrystals > 0) {
                return BlackMarketItemType.EFFECT_USER_DEFENCE_POWER_BC;
            }
            return BlackMarketItemType.EFFECT_USER_DEFENCE_POWER;
        }
        if (param1.effectData && param1.effectData.effectTypeId == EffectTypeId.UserFullProtection) {
            if (param1.price && param1.price.blackCrystals > 0) {
                return BlackMarketItemType.EFFECT_USER_FULL_PROTECTION_BC;
            }
            return BlackMarketItemType.EFFECT_USER_FULL_PROTECTION;
        }
        if (param1.effectData && param1.effectData.effectTypeId == EffectTypeId.UserProtectionIntelligence) {
            if (param1.price && param1.price.blackCrystals > 0) {
                return BlackMarketItemType.EFFECT_USER_PROTECTION_INTELLIGENCE_BC;
            }
            return BlackMarketItemType.EFFECT_USER_PROTECTION_INTELLIGENCE;
        }
        if (param1.effectData && param1.effectData.effectTypeId == EffectTypeId.UserAttackAndDefensePowerBonus) {
            if (param1.price && param1.price.blackCrystals > 0) {
                return BlackMarketItemType.EFFECT_ATTACK_AND_DEFENCE_POWER_BC;
            }
            return BlackMarketItemType.EFFECT_ATTACK_AND_DEFENCE_POWER;
        }
        if (param1.effectData && param1.effectData.effectTypeId == EffectTypeId.UserFakeArmy) {
            if (param1.price && param1.price.blackCrystals > 0) {
                return BlackMarketItemType.EFFECT_USER_FAKE_ARMY_BC;
            }
            return BlackMarketItemType.EFFECT_USER_FAKE_ARMY;
        }
        if (param1.effectData && param1.effectData.effectTypeId == EffectTypeId.UserBonusBattleExperience) {
            return BlackMarketItemType.EFFECT_USER_BONUS_BATTLE_EXPERIENCE;
        }
        if (param1.effectData && param1.effectData.effectTypeId == EffectTypeId.SectorDefensePowerBonus) {
            if (param1.price && param1.price.blackCrystals > 0) {
                return BlackMarketItemType.EFFECT_SECTOR_DEFENCE_POWER_BONUS_BC;
            }
            return BlackMarketItemType.EFFECT_SECTOR_DEFENCE_POWER_BONUS;
        }
        if (param1.effectData && param1.effectData.effectTypeId == EffectTypeId.DynamicMinesBonusMiningSpeed) {
            if (param1.price && param1.price.blackCrystals > 0) {
                return BlackMarketItemType.EFFECT_DYNAMIC_MINES_BONUS_MINING_BC;
            }
            return BlackMarketItemType.EFFECT_DYNAMIC_MINES_BONUS_MINING;
        }
        if (param1.allianceCityTeleportData) {
            return BlackMarketItemType.ALLIANCE_CITY_TELEPORT;
        }
        if (param1.researcherData) {
            return BlackMarketItemType.ADDITIONAL_RESEARCHER;
        }
        if (param1.inventoryItemDestroyerData) {
            return BlackMarketItemType.ADDITIONAL_INVENTORY_DESTROYER;
        }
        if (param1.id == BlackMarketItemsTypeId.RedistributeTroopsTierUpgradePoints) {
            return BlackMarketItemType.REDISTRIBUTE_TROOPS_TIER_UPGRADE_POINTS;
        }
        if (param1.effectData != null && param1.effectData.effectTypeId == EffectTypeId.TroopsTierBattleExperienceInfantry) {
            return BlackMarketItemType.EFFECT_TROOPS_TIER_BATTLE_EXPERIENCE_INFANTRY;
        }
        if (param1.effectData != null && param1.effectData.effectTypeId == EffectTypeId.TroopsTierBattleExperienceArmoured) {
            return BlackMarketItemType.EFFECT_TROOPS_TIER_BATTLE_EXPERIENCE_ARMOURED;
        }
        if (param1.effectData != null && param1.effectData.effectTypeId == EffectTypeId.TroopsTierBattleExperienceArtillery) {
            return BlackMarketItemType.EFFECT_TROOPS_TIER_BATTLE_EXPERIENCE_ARTILLERY;
        }
        if (param1.effectData != null && param1.effectData.effectTypeId == EffectTypeId.TroopsTierBattleExperienceAerospace) {
            return BlackMarketItemType.EFFECT_TROOPS_TIER_BATTLE_EXPERIENCE_AEROSPACE;
        }
        if (param1.effectData != null && param1.effectData.effectTypeId == EffectTypeId.UnlimitedSectorTeleport) {
            return BlackMarketItemType.UNLIMITED_SECTOR_TELEPORT;
        }
        if (param1.effectData != null && param1.effectData.effectTypeId == EffectTypeId.TroopsSpeedBoost) {
            return BlackMarketItemType.TROOPS_SPEED_BOOST;
        }
        if (param1.levelUpPointsData != null) {
            return BlackMarketItemType.LEVEL_UP_POINTS;
        }
        if (param1.temporarySkinData != null && StaticDataManager.getSectorSkinType(param1.temporarySkinData.skinTypeId) != null) {
            return BlackMarketItemType.TEMPORARY_SKIN;
        }
        if (param1.gachaChestData != null) {
            return BlackMarketItemType.GACHA_CHEST;
        }
        if (param1.dustBonusData != null) {
            return BlackMarketItemType.DUST_BONUS;
        }
        return -1;
    }
}
}
