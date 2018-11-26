package model.logic.blackMarketItems {
import common.ArrayCustom;

import model.data.Resources;
import model.data.SectorSkinType;
import model.data.acceleration.types.CaravansCapacityBoostType;
import model.data.acceleration.types.ExtraFavoriteUsersBoostType;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.temporarySkins.TemporarySkin;
import model.logic.BlackMarketTroopsType;
import model.logic.dtoSerializer.DtoDeserializer;

public class BlackMarketItemRaw {


    public var id:int;

    public var price:Resources;

    public var name:String;

    public var iconUrl:String;

    public var lifeTime:Date;

    public var purchaseLimit:int;

    public var resourcesData:BlackMarketResourceData;

    public var resourcesBoostData:BlackMarketResourceBoostData;

    public var boostData:BlackMarketBoostData;

    public var chestData:BlackMarketChestData;

    public var gemRemovalData:BlackMarketGemRemovalData;

    public var vipActivatorData:BlackMarketVipActivatorData;

    public var vipPointsData:BlackMarketVipPointsData;

    public var constructionPointsData:BlackMarketConstructionPointsData;

    public var staticBonusPackData:StaticBonusPackData;

    public var discardSkillsData:BlackMarketDiscardSkillsData;

    public var sectorTeleportData:SectorTeleportData;

    public var updateSectorData:UpdateSectorData;

    public var inventoryKeyData:InventoryKeyData;

    public var inventoryItemData:InventoryItemData;

    public var packData:BlackMarketPackData;

    public var resourceConsumptionData:ResourceConsumptionData;

    public var cancelUnitData:BlackMarketCancelUnitData;

    public var hiddenReconData:BlackMarketHiddenReconData;

    public var resetDailyData:BlackMarketResetDailyData;

    public var effectData:EffectInfo;

    public var blueLightBonusData:BlueLightBonusData;

    public var allianceCityTeleportData:AllianceCityTeleportData;

    public var researcherData:ResearcherData;

    public var inventoryItemDestroyerData:InventoryItemDestroyerData;

    public var additionalRaidLocationsData:ArrayCustom;

    public var abTestData:AbTestData;

    public var levelUpPointsData:LevelUpPointsData;

    public var fortificationPackageData:FortificationPackage;

    public var temporarySkinData:TemporarySkin;

    public var gachaChestData:GachaChestData;

    public var dustBonusData:DustBonusData;

    public var newUntil:Date;

    public var collectibleThemedItems:Array;

    public var sectorSkinType:SectorSkinType;

    public var troopsType:BlackMarketTroopsType;

    public var geoSceneObjectType:GeoSceneObjectType;

    public var buildingTechLevel:int;

    public var isNanopod:Boolean;

    public var saleConsumptionBonus:int;

    public var favoriteUsersBoostType:ExtraFavoriteUsersBoostType;

    public var caravansCapacityBoostType:CaravansCapacityBoostType;

    public var constructionWorkerData:ConstructionWorkersData;

    public var troopsCount:int;

    public var buyInBank:Boolean;

    public var saleProhibited:Boolean;

    public function BlackMarketItemRaw() {
        super();
    }

    public static function fromDto(param1:*):BlackMarketItemRaw {
        var _loc2_:BlackMarketItemRaw = new BlackMarketItemRaw();
        _loc2_.id = param1.i;
        _loc2_.price = param1.p == null ? null : Resources.fromDto(param1.p);
        _loc2_.name = param1.l == null ? null : param1.l.c;
        _loc2_.iconUrl = param1.u == null ? null : param1.u;
        _loc2_.resourcesData = param1.r == null ? null : BlackMarketResourceData.fromDto(param1.r);
        _loc2_.resourcesBoostData = param1.n == null ? null : BlackMarketResourceBoostData.fromDto(param1.n);
        _loc2_.boostData = param1.b == null ? null : BlackMarketBoostData.fromDto(param1.b);
        _loc2_.chestData = param1.c == null ? null : BlackMarketChestData.fromDto(param1.c);
        _loc2_.gemRemovalData = param1.g == null ? null : BlackMarketGemRemovalData.fromDto(param1.g);
        _loc2_.vipActivatorData = param1.a == null ? null : BlackMarketVipActivatorData.fromDto(param1.a);
        _loc2_.vipPointsData = param1.v == null ? null : BlackMarketVipPointsData.fromDto(param1.v);
        _loc2_.constructionPointsData = param1.q == null ? null : BlackMarketConstructionPointsData.fromDto(param1.q);
        _loc2_.staticBonusPackData = param1.f == null ? null : StaticBonusPackData.fromDto(param1.f);
        _loc2_.discardSkillsData = param1.d == null ? null : BlackMarketDiscardSkillsData.fromDto(param1.d);
        _loc2_.sectorTeleportData = param1.x == null ? null : SectorTeleportData.fromDto(param1.x);
        _loc2_.updateSectorData = param1.s == null ? null : UpdateSectorData.fromDto(param1.s);
        _loc2_.inventoryKeyData = param1.e == null ? null : InventoryKeyData.fromDto(param1.e);
        _loc2_.inventoryItemData = param1.y == null ? null : InventoryItemData.fromDto(param1.y);
        _loc2_.packData = param1.k == null ? null : BlackMarketPackData.fromDto(param1.k);
        _loc2_.constructionWorkerData = param1.w == null ? null : ConstructionWorkersData.fromDto(param1.w);
        _loc2_.resourceConsumptionData = param1.z == null ? null : ResourceConsumptionData.fromDto(param1.z);
        _loc2_.cancelUnitData = param1.ct == null ? null : BlackMarketCancelUnitData.fromDto(param1.ct);
        _loc2_.hiddenReconData = param1.y == null ? null : BlackMarketHiddenReconData.fromDto(param1.y);
        _loc2_.resetDailyData = param1.rd == null ? null : BlackMarketResetDailyData.fromDto(param1.rd);
        _loc2_.effectData = param1.ed == null ? null : EffectInfo.fromDto(param1.ed);
        _loc2_.blueLightBonusData = param1.bb == null ? null : BlueLightBonusData.fromDto(param1.bb);
        _loc2_.allianceCityTeleportData = param1.at == null ? null : AllianceCityTeleportData.fromDto(param1.at);
        _loc2_.additionalRaidLocationsData = param1.rl == null ? null : AdditionalRaidLocationData.fromDtos(param1.rl);
        _loc2_.abTestData = param1.tg == null ? null : AbTestData.fromDto(param1.tg);
        _loc2_.newUntil = param1.nu == null ? null : new Date(param1.nu);
        _loc2_.researcherData = param1.ar == null ? null : ResearcherData.fromDto(param1.ar);
        _loc2_.inventoryItemDestroyerData = param1.ad == null ? null : InventoryItemDestroyerData.fromDto(param1.ad);
        _loc2_.buyInBank = param1.ob == null ? false : Boolean(param1.ob);
        _loc2_.saleProhibited = param1.sp == null ? false : Boolean(param1.sp);
        _loc2_.levelUpPointsData = param1.lu == null ? null : LevelUpPointsData.fromDto(param1.lu);
        _loc2_.fortificationPackageData = param1.fp == null ? null : FortificationPackage.fromDto(param1.fp);
        _loc2_.temporarySkinData = param1.ts == null ? null : TemporarySkin.fromDto(param1.ts);
        _loc2_.gachaChestData = param1.gc == null ? null : GachaChestData.fromDto(param1.gc);
        _loc2_.dustBonusData = param1.dp == null ? null : DustBonusData.fromDto(param1.dp);
        _loc2_.collectibleThemedItems = DtoDeserializer.toArray(param1.cti, CollectibleThemedItem.fromDto);
        _loc2_.lifeTime = param1.h == null ? null : new Date(param1.h / 10000);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
