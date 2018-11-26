package model.data.discountOffers {
import common.ArrayCustom;

public class DiscountOfferType {

    public static const DISCOUNT_KIND_Drawings:int = 1;

    public static const DISCOUNT_KIND_ResourceKits:int = 2;

    public static const DISCOUNT_KIND_CitySkins:int = 3;

    public static const DISCOUNT_KIND_ResourceConversion:int = 4;

    public static const DISCOUNT_KIND_SectorExtension:int = 5;

    public static const DISCOUNT_KIND_TowerUpgrade:int = 6;

    public static const DISCOUNT_KIND_ConstructionWorker:int = 7;

    public static const DISCOUNT_KIND_Boost:int = 8;

    public static const DISCOUNT_KIND_Buildings:int = 9;

    public static const DISCOUNT_KIND_Troops:int = 10;

    public static const DISCOUNT_KIND_Resurrection:int = 11;

    public static const DISCOUNT_KIND_Payments:int = 12;

    public static const DISCOUNT_KIND_BlackMarketItems:int = 13;

    public static const DISCOUNT_KIND_InstantUnitReturn:int = 14;

    public static const DISCOUNT_KIND_AllianceCreating:int = 15;


    public var segmentId:int;

    public var typeId:int;

    public var kind:int;

    public var coefficient:Number;

    public var count:int;

    public var drawingsData:DiscountOfferDataDrawings;

    public var resourceKitsData:DiscountOfferDataResourceKits;

    public var skinsData:DiscountOfferDataSkins;

    public var resourceConversionData:DiscountOfferDataResourceConversion;

    public var sectorExtensionData:DiscountOfferDataSectorExtension;

    public var towerUpgradeData:DiscountOfferDataTowerUpgrade;

    public var workersData:DiscountOfferDataWorkers;

    public var boostData:DiscountOfferDataBoost;

    public var troopsData:DiscountOfferDataTroops;

    public var buildingsData:DiscountOfferDataBuildings;

    public var resurrectionData:DiscountOfferDataResurrection;

    public var itemsData:DiscountOfferDataBlackMarketItems;

    public var instantUnitReturnData:DiscountOfferDataInstantUnitReturn;

    public var allianceCreatingData:DiscountOfferDataAllianceCreating;

    public function DiscountOfferType() {
        super();
    }

    public static function fromDto(param1:*):DiscountOfferType {
        var _loc2_:DiscountOfferType = new DiscountOfferType();
        _loc2_.segmentId = param1.s == null ? -1 : int(param1.s);
        _loc2_.typeId = param1.i == null ? 0 : int(param1.i);
        _loc2_.kind = param1.k == null ? 0 : int(param1.k);
        _loc2_.coefficient = param1.c == null ? Number(1) : Number((1 * 10 - param1.c * 10) / 10);
        _loc2_.count = param1.m == null ? 0 : int(param1.m);
        _loc2_.drawingsData = param1.dd == null ? null : DiscountOfferDataDrawings.fromDto(param1.dd);
        _loc2_.resourceKitsData = param1.dk == null ? null : DiscountOfferDataResourceKits.fromDto(param1.dk);
        _loc2_.skinsData = param1.ds == null ? null : DiscountOfferDataSkins.fromDto(param1.ds);
        _loc2_.resourceConversionData = param1.dc == null ? null : DiscountOfferDataResourceConversion.fromDto(param1.dc);
        _loc2_.sectorExtensionData = param1.de == null ? null : DiscountOfferDataSectorExtension.fromDto(param1.de);
        _loc2_.towerUpgradeData = param1.du == null ? null : DiscountOfferDataTowerUpgrade.fromDto(param1.du);
        _loc2_.workersData = param1.dw == null ? null : DiscountOfferDataWorkers.fromDto(param1.dw);
        _loc2_.boostData = param1.da == null ? null : DiscountOfferDataBoost.fromDto(param1.da);
        _loc2_.troopsData = param1.dt == null ? null : DiscountOfferDataTroops.fromDto(param1.dt);
        _loc2_.buildingsData = param1.db == null ? null : DiscountOfferDataBuildings.fromDto(param1.db);
        _loc2_.resurrectionData = param1.dr == null ? null : DiscountOfferDataResurrection.fromDto(param1.dr);
        _loc2_.itemsData = param1.di == null ? null : DiscountOfferDataBlackMarketItems.fromDto(param1.di);
        _loc2_.instantUnitReturnData = param1.dn == null ? null : DiscountOfferDataInstantUnitReturn.fromDto(param1.dn);
        _loc2_.allianceCreatingData = param1.dg == null ? null : DiscountOfferDataAllianceCreating.fromDto(param1.dg);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return null;
        }
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
