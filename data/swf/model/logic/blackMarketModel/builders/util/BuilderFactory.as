package model.logic.blackMarketModel.builders.util {
import model.logic.blackMarketModel.builders.AdditionalInventoryDestroyerBuilder;
import model.logic.blackMarketModel.builders.AdditionalRaidLocationBuilder;
import model.logic.blackMarketModel.builders.AdditionalResearcherBuilder;
import model.logic.blackMarketModel.builders.AllResourcesBoostBuilder;
import model.logic.blackMarketModel.builders.AllianceCityTeleportBuilder;
import model.logic.blackMarketModel.builders.BlackCrystalDrawingBuilder;
import model.logic.blackMarketModel.builders.BoostMoneyConsumptionBuilder;
import model.logic.blackMarketModel.builders.BoosterBuilder;
import model.logic.blackMarketModel.builders.BuildingBuilder;
import model.logic.blackMarketModel.builders.BuildingUpgradeBuilder;
import model.logic.blackMarketModel.builders.CancelUnitBuilder;
import model.logic.blackMarketModel.builders.CaravansCapacityBoostBuilder;
import model.logic.blackMarketModel.builders.ChestBuilder;
import model.logic.blackMarketModel.builders.ClanBuilder;
import model.logic.blackMarketModel.builders.ConstructionBuilder;
import model.logic.blackMarketModel.builders.DrawingBuilder;
import model.logic.blackMarketModel.builders.DustBonusBuilder;
import model.logic.blackMarketModel.builders.EffectDynamicMinesBonusMiningBuilder;
import model.logic.blackMarketModel.builders.EffectSectorDefencePowerBuilder;
import model.logic.blackMarketModel.builders.EffectTroopsTierBattleExperienceAerospaceBuilder;
import model.logic.blackMarketModel.builders.EffectTroopsTierBattleExperienceArmouredBuilder;
import model.logic.blackMarketModel.builders.EffectTroopsTierBattleExperienceArtilleryBuilder;
import model.logic.blackMarketModel.builders.EffectTroopsTierBattleExperienceInfantryBuilder;
import model.logic.blackMarketModel.builders.EffectUserAttackAndDefencePowerBuilder;
import model.logic.blackMarketModel.builders.EffectUserAttackPowerBuilder;
import model.logic.blackMarketModel.builders.EffectUserBonusBattleExperienceBuilder;
import model.logic.blackMarketModel.builders.EffectUserDefencePowerBuilder;
import model.logic.blackMarketModel.builders.EffectUserFakeArmyBuilder;
import model.logic.blackMarketModel.builders.EffectUserFullProtectionBuilder;
import model.logic.blackMarketModel.builders.EffectUserProtectionIntelligenceBuilder;
import model.logic.blackMarketModel.builders.ExtraFavoriteUsersBoostBuilder;
import model.logic.blackMarketModel.builders.ExtractorBuilder;
import model.logic.blackMarketModel.builders.GachaChestBuilder;
import model.logic.blackMarketModel.builders.HiddenReconBuilder;
import model.logic.blackMarketModel.builders.HospitalUnitBuilder;
import model.logic.blackMarketModel.builders.InventoryKeyBuilder;
import model.logic.blackMarketModel.builders.KitsChestsBuilder;
import model.logic.blackMarketModel.builders.LevelUpPointsPackBuilder;
import model.logic.blackMarketModel.builders.NanopodBuilder;
import model.logic.blackMarketModel.builders.RedistributeTroopsTierUpgradePointsBuilder;
import model.logic.blackMarketModel.builders.ResetDailyBuilder;
import model.logic.blackMarketModel.builders.ResourceBoostBuilder;
import model.logic.blackMarketModel.builders.ResourcePackBuilder;
import model.logic.blackMarketModel.builders.SaleConsumptionBuilder;
import model.logic.blackMarketModel.builders.SectorSkinBuilder;
import model.logic.blackMarketModel.builders.SectorTeleportBuilder;
import model.logic.blackMarketModel.builders.SkillDiscardBuilder;
import model.logic.blackMarketModel.builders.SlotActivatorBuilder;
import model.logic.blackMarketModel.builders.StrategyUnitBuilder;
import model.logic.blackMarketModel.builders.TechnologyUpgradeBuilder;
import model.logic.blackMarketModel.builders.TeleporterBuilder;
import model.logic.blackMarketModel.builders.TemporarySectorSkinBuilder;
import model.logic.blackMarketModel.builders.TroopsSpeedBoostBuilder;
import model.logic.blackMarketModel.builders.UnitBuilder;
import model.logic.blackMarketModel.builders.UnlimitedSectorTeleportBuilder;
import model.logic.blackMarketModel.builders.UpdateSectorBuilder;
import model.logic.blackMarketModel.builders.UserAutoMoveTroopsBunkerBuilder;
import model.logic.blackMarketModel.builders.VipActivatorBuilder;
import model.logic.blackMarketModel.builders.VipPointsBuilder;
import model.logic.blackMarketModel.builders.ViralityCrystalPackBuilder;
import model.logic.blackMarketModel.builders.WorkerBuilder;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class BuilderFactory {

    private static var _builders:Vector.<IBlackMarketItemBuilder>;

    {
        initialize();
    }

    public function BuilderFactory() {
        super();
    }

    private static function initialize():void {
        _builders = new Vector.<IBlackMarketItemBuilder>();
        _builders[BlackMarketItemType.RESOURCE_PACK] = new ResourcePackBuilder();
        _builders[BlackMarketItemType.RESOURCE_BOOST] = new ResourceBoostBuilder();
        _builders[BlackMarketItemType.SECTOR_SKIN] = new SectorSkinBuilder();
        _builders[BlackMarketItemType.UNIT] = new UnitBuilder();
        _builders[BlackMarketItemType.STRATEGY_UNIT] = new StrategyUnitBuilder();
        _builders[BlackMarketItemType.BUILDING] = new BuildingBuilder();
        _builders[BlackMarketItemType.DRAWING] = new DrawingBuilder();
        _builders[BlackMarketItemType.BLACK_CRYSTAL_DRAWING] = new BlackCrystalDrawingBuilder();
        _builders[BlackMarketItemType.NANOPOD] = new NanopodBuilder();
        _builders[BlackMarketItemType.EXTRA_FAVORITE_USERS_BOOST] = new ExtraFavoriteUsersBoostBuilder();
        _builders[BlackMarketItemType.CARAVANS_CAPACITY_BOOST] = new CaravansCapacityBoostBuilder();
        _builders[BlackMarketItemType.HOSPITAL_UNIT] = new HospitalUnitBuilder();
        _builders[BlackMarketItemType.CHEST] = new ChestBuilder();
        _builders[BlackMarketItemType.EXTRACTOR] = new ExtractorBuilder();
        _builders[BlackMarketItemType.SKILL_DISCARD] = new SkillDiscardBuilder();
        _builders[BlackMarketItemType.BOOSTER] = new BoosterBuilder();
        _builders[BlackMarketItemType.TELEPORTER] = new TeleporterBuilder();
        _builders[BlackMarketItemType.CONSTRUCTION] = new ConstructionBuilder();
        _builders[BlackMarketItemType.CLAN] = new ClanBuilder();
        _builders[BlackMarketItemType.VIP_ACTIVATOR] = new VipActivatorBuilder();
        _builders[BlackMarketItemType.VIP_POINTS] = new VipPointsBuilder();
        _builders[BlackMarketItemType.SECTOR_TELEPORT] = new SectorTeleportBuilder();
        _builders[BlackMarketItemType.SALE_CONSUMPTION] = new SaleConsumptionBuilder();
        _builders[BlackMarketItemType.UPDATE_SECTOR] = new UpdateSectorBuilder();
        _builders[BlackMarketItemType.VIRALITY_CRYSTAL_PACK] = new ViralityCrystalPackBuilder();
        _builders[BlackMarketItemType.BUILDING_UPGRADE] = new BuildingUpgradeBuilder();
        _builders[BlackMarketItemType.TECHNOLOGY_UPGRADE] = new TechnologyUpgradeBuilder();
        _builders[BlackMarketItemType.KEY] = new InventoryKeyBuilder();
        _builders[BlackMarketItemType.SLOT_ACTIVATOR] = new SlotActivatorBuilder();
        _builders[BlackMarketItemType.ADDITIONAL_WORKER] = new WorkerBuilder();
        _builders[BlackMarketItemType.BOOST_MONEY_CONSUMPTION] = new BoostMoneyConsumptionBuilder();
        _builders[BlackMarketItemType.ALL_RESOURCES_BOOST] = new AllResourcesBoostBuilder();
        _builders[BlackMarketItemType.USER_AUTO_MOVE_TROOPS_BUNKER] = new UserAutoMoveTroopsBunkerBuilder();
        _builders[BlackMarketItemType.HIDDEN_RECON] = new HiddenReconBuilder();
        _builders[BlackMarketItemType.CANCEL_UNIT] = new CancelUnitBuilder();
        _builders[BlackMarketItemType.RESET_DAILY] = new ResetDailyBuilder();
        _builders[BlackMarketItemType.KITS_CHESTS] = new KitsChestsBuilder();
        _builders[BlackMarketItemType.USER_AUTO_MOVE_TROOPS_BUNKER_BC] = new UserAutoMoveTroopsBunkerBuilder();
        _builders[BlackMarketItemType.RESET_DAILY_BC] = new ResetDailyBuilder();
        _builders[BlackMarketItemType.BLUE_LIGHT] = new BlueLightBuilder();
        _builders[BlackMarketItemType.ADDITIONAL_RAID_LOCATION] = new AdditionalRaidLocationBuilder();
        _builders[BlackMarketItemType.EFFECT_USER_ATTACK_POWER] = new EffectUserAttackPowerBuilder();
        _builders[BlackMarketItemType.EFFECT_USER_ATTACK_POWER_BC] = new EffectUserAttackPowerBuilder();
        _builders[BlackMarketItemType.EFFECT_USER_DEFENCE_POWER] = new EffectUserDefencePowerBuilder();
        _builders[BlackMarketItemType.EFFECT_USER_DEFENCE_POWER_BC] = new EffectUserDefencePowerBuilder();
        _builders[BlackMarketItemType.EFFECT_USER_FULL_PROTECTION] = new EffectUserFullProtectionBuilder();
        _builders[BlackMarketItemType.EFFECT_USER_FULL_PROTECTION_BC] = new EffectUserFullProtectionBuilder();
        _builders[BlackMarketItemType.EFFECT_USER_PROTECTION_INTELLIGENCE] = new EffectUserProtectionIntelligenceBuilder();
        _builders[BlackMarketItemType.EFFECT_USER_PROTECTION_INTELLIGENCE_BC] = new EffectUserProtectionIntelligenceBuilder();
        _builders[BlackMarketItemType.EFFECT_ATTACK_AND_DEFENCE_POWER] = new EffectUserAttackAndDefencePowerBuilder();
        _builders[BlackMarketItemType.EFFECT_ATTACK_AND_DEFENCE_POWER_BC] = new EffectUserAttackAndDefencePowerBuilder();
        _builders[BlackMarketItemType.EFFECT_USER_FAKE_ARMY] = new EffectUserFakeArmyBuilder();
        _builders[BlackMarketItemType.EFFECT_USER_FAKE_ARMY_BC] = _builders[BlackMarketItemType.EFFECT_USER_FAKE_ARMY];
        _builders[BlackMarketItemType.EFFECT_USER_BONUS_BATTLE_EXPERIENCE] = new EffectUserBonusBattleExperienceBuilder();
        _builders[BlackMarketItemType.ALLIANCE_CITY_TELEPORT] = new AllianceCityTeleportBuilder();
        _builders[BlackMarketItemType.EFFECT_SECTOR_DEFENCE_POWER_BONUS] = new EffectSectorDefencePowerBuilder();
        _builders[BlackMarketItemType.EFFECT_SECTOR_DEFENCE_POWER_BONUS_BC] = _builders[BlackMarketItemType.EFFECT_SECTOR_DEFENCE_POWER_BONUS];
        _builders[BlackMarketItemType.EFFECT_DYNAMIC_MINES_BONUS_MINING] = new EffectDynamicMinesBonusMiningBuilder();
        _builders[BlackMarketItemType.EFFECT_DYNAMIC_MINES_BONUS_MINING_BC] = _builders[BlackMarketItemType.EFFECT_DYNAMIC_MINES_BONUS_MINING];
        _builders[BlackMarketItemType.ADDITIONAL_RESEARCHER] = new AdditionalResearcherBuilder();
        _builders[BlackMarketItemType.ADDITIONAL_INVENTORY_DESTROYER] = new AdditionalInventoryDestroyerBuilder();
        _builders[BlackMarketItemType.REDISTRIBUTE_TROOPS_TIER_UPGRADE_POINTS] = new RedistributeTroopsTierUpgradePointsBuilder();
        _builders[BlackMarketItemType.EFFECT_TROOPS_TIER_BATTLE_EXPERIENCE_INFANTRY] = new EffectTroopsTierBattleExperienceInfantryBuilder();
        _builders[BlackMarketItemType.EFFECT_TROOPS_TIER_BATTLE_EXPERIENCE_ARMOURED] = new EffectTroopsTierBattleExperienceArmouredBuilder();
        _builders[BlackMarketItemType.EFFECT_TROOPS_TIER_BATTLE_EXPERIENCE_ARTILLERY] = new EffectTroopsTierBattleExperienceArtilleryBuilder();
        _builders[BlackMarketItemType.EFFECT_TROOPS_TIER_BATTLE_EXPERIENCE_AEROSPACE] = new EffectTroopsTierBattleExperienceAerospaceBuilder();
        _builders[BlackMarketItemType.LEVEL_UP_POINTS] = new LevelUpPointsPackBuilder();
        _builders[BlackMarketItemType.UNLIMITED_SECTOR_TELEPORT] = new UnlimitedSectorTeleportBuilder();
        _builders[BlackMarketItemType.TROOPS_SPEED_BOOST] = new TroopsSpeedBoostBuilder();
        _builders[BlackMarketItemType.TEMPORARY_SKIN] = new TemporarySectorSkinBuilder();
        _builders[BlackMarketItemType.GACHA_CHEST] = new GachaChestBuilder();
        _builders[BlackMarketItemType.DUST_BONUS] = new DustBonusBuilder();
    }

    public static function getBuilder(param1:int):IBlackMarketItemBuilder {
        return _builders[param1];
    }
}
}
