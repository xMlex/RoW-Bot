package model.logic.discountOffers {
import common.ArrayCustom;
import common.DateUtil;
import common.DictionaryUtil;
import common.GameType;
import common.StringUtil;
import common.localization.LocaleUtil;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.utils.Dictionary;
import flash.utils.Timer;

import model.data.ResourcesKit;
import model.data.acceleration.types.BoostTypeId;
import model.data.discountOffers.ActiveDiscountOffer;
import model.data.discountOffers.DiscountOfferDataBlackMarketItems;
import model.data.discountOffers.DiscountOfferDataBoost;
import model.data.discountOffers.DiscountOfferDataBuildings;
import model.data.discountOffers.DiscountOfferDataDrawings;
import model.data.discountOffers.DiscountOfferDataResourceKits;
import model.data.discountOffers.DiscountOfferDataResurrection;
import model.data.discountOffers.DiscountOfferDataSkins;
import model.data.discountOffers.DiscountOfferDataTowerUpgrade;
import model.data.discountOffers.DiscountOfferDataTroops;
import model.data.discountOffers.DiscountOfferType;
import model.data.discountOffers.OfferCountPair;
import model.data.locations.Location;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.data.scenes.types.info.BuildingGroupId;
import model.data.scenes.types.info.BuildingTypeId;
import model.data.scenes.types.info.DecorTypeId;
import model.data.scenes.types.info.DefensiveKind;
import model.data.scenes.types.info.TroopsGroupId;
import model.data.scenes.types.info.TroopsKindId;
import model.data.scenes.types.info.TroopsTypeId;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.commands.discountOffers.OpenDiscountOfferCmd;
import model.logic.resourcesConversion.data.ResourcesConversionJobType;

public class UserDiscountOfferManager {

    public static const CLASS_NAME:String = "UserDiscountOfferManager";

    public static const DISCOUNT_TIME_CHANGED:String = "DiscountTimeChanged";

    public static const NEXT_DISCOUNT_TIME_CHANGED:String = "NextDiscountTimeChanged";

    public static const ACTIVE_DISCOUNT_OFFERS_UPDATE:String = "activeUpdate";

    public static const TIME_TO_NEXT_SALE:Number = 1000 * 60 * 60 * 22;

    private static const OFFERS_INTERVAL:Number = DateUtil.MILLISECONDS_PER_DAY;

    public static var dontShowDiscountOffer:Boolean;

    public static var isSaleToday:Boolean = false;

    private static var _allTypeIdsDic:Dictionary = new Dictionary();

    private static var _isSale:Boolean = false;

    private static var _timer:Timer = new Timer(1000);

    private static var _eventDispatcher:EventDispatcher = new EventDispatcher();

    private static var _lastDiscountOpenTime:Date = new Date(1970);

    private static var _discountOfferTypes:ArrayCustom;

    private static var _activeDiscountOffers:ArrayCustom;

    {
        _timer.addEventListener(TimerEvent.TIMER, time_tick);
        _timer.start();
    }

    public function UserDiscountOfferManager() {
        super();
    }

    public static function get lastDiscountOpenTime():Date {
        return _lastDiscountOpenTime;
    }

    public static function set lastDiscountOpenTime(param1:Date):void {
        _lastDiscountOpenTime = param1;
        isSaleToday = checkSaleToDay();
    }

    public static function get discountOfferTypes():ArrayCustom {
        return _discountOfferTypes;
    }

    public static function set discountOfferTypes(param1:ArrayCustom):void {
        _discountOfferTypes = param1;
        _isSale = _activeDiscountOffers != null && _activeDiscountOffers.length > 0 && _discountOfferTypes != null && _discountOfferTypes.length > 0;
        fillDiscountsByType();
        events.dispatchEvent(new Event(ACTIVE_DISCOUNT_OFFERS_UPDATE));
    }

    public static function get activeDiscountOffers():ArrayCustom {
        return _activeDiscountOffers;
    }

    public static function set activeDiscountOffers(param1:ArrayCustom):void {
        _activeDiscountOffers = param1;
        _isSale = _activeDiscountOffers != null && _activeDiscountOffers.length > 0 && _discountOfferTypes != null && _discountOfferTypes.length > 0;
        events.dispatchEvent(new Event(ACTIVE_DISCOUNT_OFFERS_UPDATE));
    }

    public static function get hasDiscount():Boolean {
        return _isSale;
    }

    public static function getDiscountCoefficient(param1:int):Number {
        return _allTypeIdsDic[param1] != undefined ? Number(_allTypeIdsDic[param1]) : Number(0);
    }

    public static function getCoefficient(param1:DiscountOfferType = null):Number {
        if (param1 == null) {
            return Number.NaN;
        }
        return param1.coefficient;
    }

    public static function openDiscountOffer():void {
        new OpenDiscountOfferCmd().execute();
    }

    public static function discountTroop(param1:int, param2:int = -1, param3:int = -1):Object {
        var offerType:DiscountOfferType = null;
        var pActiveDiscountOffer:ActiveDiscountOffer = null;
        var troopsData:DiscountOfferDataTroops = null;
        var troopId:int = param1;
        var troopGroupId:int = param2;
        var troopKindId:int = param3;
        var fillDiscountParams:Function = function ():void {
            pDiscount = offerType.coefficient;
            pSegmentId = offerType.segmentId;
            pTypeId = offerType.typeId;
        };
        var pDiscountObj:Object = new Object();
        var pDiscount:Number = 0;
        var pDiscountCount:Number = 0;
        var pSegmentId:int = 0;
        var pTypeId:int = 0;
        var type:GeoSceneObjectType = StaticDataManager.getObjectType(troopId);
        if (type.saleableInfo != null && type.saleableInfo.discountsProhibited || TroopsTypeId.isAvp(troopId)) {
            pDiscountObj.discount = pDiscount;
            pDiscountObj.count = pDiscountCount;
            return pDiscountObj;
        }
        for each(offerType in discountOfferTypes) {
            if (offerType.troopsData != null) {
                troopsData = offerType.troopsData;
                if (troopsData.allGold) {
                    if (troopsData.kindId != -1) {
                        switch (troopsData.kindId) {
                            case TroopsKindId.ATTACKING:
                                if (type.isGold && type.troopsInfo.kindId == TroopsKindId.ATTACKING) {
                                    fillDiscountParams();
                                }
                                break;
                            case TroopsKindId.DEFENSIVE:
                                if (type.isGold && type.troopsInfo.kindId == TroopsKindId.DEFENSIVE) {
                                    fillDiscountParams();
                                }
                                break;
                            case TroopsKindId.RECON:
                                if (type.isGold && type.troopsInfo.kindId == TroopsKindId.RECON) {
                                    fillDiscountParams();
                                }
                        }
                    }
                    else if (StaticDataManager.getObjectType(troopId).isGold) {
                        fillDiscountParams();
                    }
                    break;
                }
                if (troopsData.allStrategies) {
                    if (type.isStrategyUnit && troopKindId != -1 && troopKindId == troopsData.kindId) {
                        fillDiscountParams();
                    }
                    else if (type.isStrategyUnit && troopsData.kindId == -1) {
                        fillDiscountParams();
                    }
                    break;
                }
                if (troopsData.all) {
                    fillDiscountParams();
                    break;
                }
                if (troopsData.typeIdsDic != null && troopsData.typeIdsDic[troopId] == 1) {
                    fillDiscountParams();
                    break;
                }
                if (!type.isStrategyUnit && troopGroupId != -1 && troopGroupId == troopsData.groupId) {
                    fillDiscountParams();
                    break;
                }
                if (!type.isStrategyUnit && troopKindId != -1 && troopKindId == troopsData.kindId) {
                    fillDiscountParams();
                    break;
                }
            }
        }
        pActiveDiscountOffer = getActiveDiscountOffer(pTypeId, pSegmentId);
        pDiscountCount = pActiveDiscountOffer != null ? Number(pActiveDiscountOffer.countLeft) : Number(0);
        pDiscountObj.discount = pDiscount;
        pDiscountObj.count = pDiscountCount;
        return pDiscountObj;
    }

    public static function discountBuildings(param1:int, param2:int = -1, param3:int = -1, param4:int = -1):Object {
        var _loc8_:DiscountOfferType = null;
        var _loc9_:DiscountOfferDataBuildings = null;
        var _loc5_:Object = new Object();
        var _loc6_:Number = 0;
        var _loc7_:Number = 0;
        for each(_loc8_ in discountOfferTypes) {
            if (_loc8_.buildingsData != null) {
                _loc7_ = getActiveDiscountOffer(_loc8_.typeId, _loc8_.segmentId).countLeft;
                _loc9_ = _loc8_.buildingsData;
                if (_loc9_ != null) {
                    if (_loc9_.all) {
                        _loc6_ = _loc8_.coefficient;
                        break;
                    }
                    if (_loc9_.typeIdsDic && _loc9_.typeIdsDic[param1] == 1) {
                        _loc6_ = _loc8_.coefficient;
                        break;
                    }
                    if (param2 != -1 && param2 == _loc9_.groupId) {
                        _loc6_ = _loc8_.coefficient;
                        break;
                    }
                    if (param3 != -1 && param3 == _loc9_.defensiveKind) {
                        _loc6_ = _loc8_.coefficient;
                        break;
                    }
                    if (param4 != -1 && param4 == _loc9_.slotKindId) {
                        _loc6_ = _loc8_.coefficient;
                        break;
                    }
                }
            }
        }
        _loc5_.discount = _loc6_;
        _loc5_.count = _loc7_;
        return _loc5_;
    }

    public static function discountResourceKit(param1:ResourcesKit):Number {
        var _loc3_:DiscountOfferType = null;
        var _loc4_:DiscountOfferDataResourceKits = null;
        var _loc2_:Number = 0;
        for each(_loc3_ in discountOfferTypes) {
            if (_loc3_.resourceKitsData != null) {
                _loc4_ = _loc3_.resourceKitsData;
                if (_loc4_.all || _loc4_.kitIdsDic != null && _loc4_.kitIdsDic[param1.id] == 1 || _loc4_.resourceTypeIdsDic != null && _loc4_.resourceTypeIdsDic[param1.id] == 1) {
                    _loc2_ = _loc3_.coefficient;
                    break;
                }
            }
        }
        return _loc2_;
    }

    public static function discountInstantUnitReturn():Number {
        var _loc2_:DiscountOfferType = null;
        var _loc1_:Number = 0;
        for each(_loc2_ in discountOfferTypes) {
            if (_loc2_.instantUnitReturnData != null) {
                if (_loc2_.instantUnitReturnData.enabled) {
                    _loc1_ = _loc2_.coefficient;
                    break;
                }
            }
        }
        return _loc1_;
    }

    public static function discountAllianceCreating():Number {
        var _loc2_:DiscountOfferType = null;
        var _loc1_:Number = 0;
        for each(_loc2_ in discountOfferTypes) {
            if (_loc2_.allianceCreatingData != null) {
                if (_loc2_.allianceCreatingData.enabled) {
                    _loc1_ = _loc2_.coefficient;
                    break;
                }
            }
        }
        return _loc1_;
    }

    public static function discountBoost(param1:int):Number {
        var _loc3_:DiscountOfferType = null;
        var _loc4_:DiscountOfferDataBoost = null;
        var _loc2_:Number = 0;
        for each(_loc3_ in discountOfferTypes) {
            if (_loc3_.boostData != null) {
                _loc4_ = _loc3_.boostData;
                if (_loc4_.all || _loc4_.typeIdsDic != null && _loc4_.typeIdsDic[param1] == 1) {
                    _loc2_ = _loc3_.coefficient;
                    break;
                }
            }
        }
        return _loc2_;
    }

    public static function discountForBoostResources(param1:int):Number {
        var _loc2_:ArrayCustom = null;
        var _loc4_:DiscountOfferType = null;
        var _loc5_:Boolean = false;
        var _loc6_:Boolean = false;
        var _loc7_:Boolean = false;
        if (param1 != BoostTypeId.RESOURCES_MONEY && param1 != BoostTypeId.RESOURCES_TITANITE && param1 != BoostTypeId.RESOURCES_URANIUM) {
            return discountBoost(param1);
        }
        var _loc3_:Number = 0;
        for each(_loc4_ in discountOfferTypes) {
            if (_loc4_.boostData != null) {
                _loc3_ = discountBoost(param1);
                break;
            }
            if (_loc4_.itemsData == null) {
                continue;
            }
            _loc2_ = _loc4_.itemsData.typeIds;
            _loc5_ = _loc2_.contains(BlackMarketItemsTypeId.BOOST_RESOURCES_URAN);
            _loc6_ = _loc2_.contains(BlackMarketItemsTypeId.BOOST_RESOURCES_URAN);
            _loc7_ = _loc2_.contains(BlackMarketItemsTypeId.BOOST_RESOURCES_URAN);
            if (!_loc5_ || !_loc6_ || !_loc7_) {
                continue;
            }
            _loc3_ = _loc4_.coefficient;
            break;
        }
        return _loc3_;
    }

    public static function discountSkin(param1:int):Number {
        var _loc3_:DiscountOfferType = null;
        var _loc4_:DiscountOfferDataSkins = null;
        var _loc2_:Number = 0;
        for each(_loc3_ in discountOfferTypes) {
            if (_loc3_.skinsData != null) {
                _loc4_ = _loc3_.skinsData;
                if (_loc4_.all || _loc4_.skinTypeIdsDic != null && _loc4_.skinTypeIdsDic[param1] == 1) {
                    _loc2_ = _loc3_.coefficient;
                    break;
                }
            }
        }
        return _loc2_;
    }

    public static function discountDrawing(param1:int):Number {
        var _loc3_:DiscountOfferType = null;
        var _loc4_:DiscountOfferDataDrawings = null;
        var _loc2_:Number = 0;
        for each(_loc3_ in discountOfferTypes) {
            if (_loc3_.drawingsData != null) {
                _loc4_ = _loc3_.drawingsData;
                if (_loc4_.all || _loc4_.drawingIdsDic != null && _loc4_.drawingIdsDic[param1] == 1) {
                    _loc2_ = _loc3_.coefficient;
                    break;
                }
            }
        }
        return _loc2_;
    }

    public static function discountResurrection(param1:int, param2:int = -1, param3:int = -1):Number {
        var _loc5_:DiscountOfferType = null;
        var _loc6_:DiscountOfferDataResurrection = null;
        var _loc4_:Number = 0;
        for each(_loc5_ in discountOfferTypes) {
            if (_loc5_.resurrectionData != null) {
                _loc6_ = _loc5_.resurrectionData;
                if (_loc6_.all) {
                    _loc4_ = _loc5_.coefficient;
                    break;
                }
                if (_loc6_.typeIdsDic != null && _loc6_.typeIdsDic[param1] == 1) {
                    _loc4_ = _loc5_.coefficient;
                    break;
                }
                if (param2 != -1 && param2 == _loc6_.groupId) {
                    _loc4_ = _loc5_.coefficient;
                    break;
                }
                if (param3 != -1 && param3 == _loc6_.kindId) {
                    _loc4_ = _loc5_.coefficient;
                    break;
                }
            }
        }
        return _loc4_;
    }

    public static function discountBlackMarketItems(param1:int):Number {
        var _loc3_:DiscountOfferType = null;
        var _loc4_:DiscountOfferDataBlackMarketItems = null;
        var _loc2_:Number = 0;
        for each(_loc3_ in discountOfferTypes) {
            if (_loc3_.itemsData != null) {
                _loc4_ = _loc3_.itemsData;
                if (_loc4_.typeIdsDic != null && _loc4_.typeIdsDic[param1] == 1) {
                    if (_loc3_.count > 0) {
                        _loc2_ = _loc3_.coefficient;
                        break;
                    }
                }
            }
        }
        return _loc2_;
    }

    public static function discountSectorExtension(param1:int):Number {
        var _loc3_:DiscountOfferType = null;
        var _loc2_:Number = 0;
        for each(_loc3_ in discountOfferTypes) {
            if (!(_loc3_.kind != DiscountOfferType.DISCOUNT_KIND_SectorExtension || _loc3_.sectorExtensionData == null)) {
                if (param1 < _loc3_.sectorExtensionData.sizeNewUpperBound) {
                    _loc2_ = _loc3_.coefficient;
                    break;
                }
            }
        }
        return _loc2_;
    }

    public static function discountBuyingSlot():Number {
        var _loc2_:DiscountOfferType = null;
        var _loc1_:Number = 0;
        for each(_loc2_ in discountOfferTypes) {
            if (_loc2_.kind == DiscountOfferType.DISCOUNT_KIND_SectorExtension && _loc2_.sectorExtensionData != null && _loc2_.sectorExtensionData.allSlotsExtension) {
                _loc1_ = _loc2_.coefficient;
                break;
            }
        }
        return _loc1_;
    }

    public static function discountWorkers():Number {
        var _loc2_:DiscountOfferType = null;
        var _loc1_:Number = 0;
        for each(_loc2_ in discountOfferTypes) {
            if (_loc2_.workersData != null) {
                if (_loc2_.workersData.enabled) {
                    _loc1_ = _loc2_.coefficient;
                    break;
                }
            }
        }
        return _loc1_;
    }

    public static function discountTowerUpgrade(param1:Location):Number {
        var _loc3_:DiscountOfferType = null;
        var _loc4_:DiscountOfferDataTowerUpgrade = null;
        var _loc2_:Number = 0;
        for each(_loc3_ in discountOfferTypes) {
            if (!(_loc3_.kind != DiscountOfferType.DISCOUNT_KIND_TowerUpgrade || _loc3_.towerUpgradeData == null)) {
                _loc4_ = _loc3_.towerUpgradeData;
                if (param1.gameData.towerData.level >= _loc4_.towerLevelFrom && param1.gameData.towerData.level < _loc4_.towerLevelTo) {
                    _loc2_ = _loc3_.coefficient;
                    break;
                }
            }
        }
        return _loc2_;
    }

    public static function discountResourceConversion(param1:ResourcesConversionJobType):Number {
        var _loc3_:DiscountOfferType = null;
        var _loc4_:Object = null;
        var _loc2_:Number = 0;
        for each(_loc3_ in discountOfferTypes) {
            if (_loc3_.kind == DiscountOfferType.DISCOUNT_KIND_ResourceConversion) {
                for each(_loc4_ in _loc3_.resourceConversionData.conversionJobTypes) {
                    if (_loc4_ == param1.id) {
                        _loc2_ = _loc3_.coefficient;
                        break;
                    }
                }
            }
        }
        return _loc2_;
    }

    public static function discountUnitReturn():Number {
        var _loc2_:DiscountOfferType = null;
        var _loc1_:Number = 0;
        for each(_loc2_ in discountOfferTypes) {
            if (_loc2_.kind == DiscountOfferType.DISCOUNT_KIND_InstantUnitReturn) {
                if (_loc2_.instantUnitReturnData != null && _loc2_.instantUnitReturnData.enabled) {
                    _loc1_ = _loc2_.coefficient;
                    break;
                }
            }
        }
        return _loc1_;
    }

    public static function getDiscountOfferType(param1:int, param2:int):DiscountOfferType {
        var _loc3_:DiscountOfferType = null;
        var _loc4_:DiscountOfferType = null;
        for each(_loc4_ in _discountOfferTypes) {
            if (_loc4_.typeId == param1 && _loc4_.segmentId == param2) {
                _loc3_ = _loc4_;
                break;
            }
        }
        return _loc3_;
    }

    public static function getActiveDiscountOffer(param1:int, param2:int):ActiveDiscountOffer {
        var _loc3_:ActiveDiscountOffer = null;
        var _loc4_:ActiveDiscountOffer = null;
        for each(_loc4_ in _activeDiscountOffers) {
            if (_loc4_.offerTypeId == param1 && _loc4_.segmentId == param2) {
                _loc3_ = _loc4_;
                break;
            }
        }
        return _loc3_;
    }

    public static function updateUserOfferData(param1:ArrayCustom):void {
        var _loc3_:OfferCountPair = null;
        var _loc4_:int = 0;
        var _loc2_:ArrayCustom = UserManager.user.gameData.discountOfferData.activeDiscountOffers;
        for each(_loc3_ in param1) {
            while (_loc4_ < _loc2_.length) {
                if (_loc3_.discountOfferId == _loc2_[_loc4_].id) {
                    if (_loc2_[_loc4_].countLeft - _loc3_.count <= 0) {
                        _loc2_.removeItemAt(_loc4_);
                        _discountOfferTypes.removeItemAt(_loc4_);
                        _allTypeIdsDic = new Dictionary();
                        fillDiscountsByType();
                    }
                    else {
                        _loc2_[_loc4_].countLeft = _loc2_[_loc4_].countLeft - _loc3_.count;
                    }
                    break;
                }
                _loc4_++;
            }
        }
        activeDiscountOffers = UserManager.user.gameData.discountOfferData.activeDiscountOffers;
    }

    public static function checkSaleToDay():Boolean {
        var _loc1_:* = false;
        if (_lastDiscountOpenTime != null) {
            if (GameType.isMilitary) {
                _loc1_ = Boolean(isSaleAvailable_MK);
            }
            else {
                _loc1_ = _lastDiscountOpenTime.time + TIME_TO_NEXT_SALE < ServerTimeManager.serverTimeNow.time;
            }
        }
        else {
            _loc1_ = true;
        }
        return _loc1_;
    }

    public static function sortDiscountBuildings(param1:*, param2:*):int {
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        if (param1 is Number && param2 is Number) {
            _loc3_ = discountBuildings(param1).discount;
            _loc4_ = discountBuildings(param2).discount;
        }
        else {
            _loc3_ = discountBuildings(param1.id).discount;
            _loc4_ = discountBuildings(param2.id).discount;
        }
        return comparator(_loc3_, _loc4_);
    }

    public static function getImageByDiscountKind(param1:int, param2:DiscountOfferType = null):String {
        if (param2 == null) {
            return null;
        }
        var _loc3_:String = GameType.isTotalDomination || GameType.isElves ? "newItems" : "items";
        var _loc4_:* = "ui/roulette/" + _loc3_ + "/big/";
        switch (param1) {
            case DiscountOfferType.DISCOUNT_KIND_Drawings:
                _loc4_ = _loc4_ + "drawings.jpg";
                break;
            case DiscountOfferType.DISCOUNT_KIND_ResourceKits:
                _loc4_ = _loc4_ + "resources/resourcesNew.jpg";
                break;
            case DiscountOfferType.DISCOUNT_KIND_CitySkins:
                _loc4_ = _loc4_ + "skins.jpg";
                break;
            case DiscountOfferType.DISCOUNT_KIND_ResourceConversion:
                _loc4_ = _loc4_ + "resources/resourcesBioplasm.jpg";
                break;
            case DiscountOfferType.DISCOUNT_KIND_SectorExtension:
                _loc4_ = _loc4_ + "extension.jpg";
                break;
            case DiscountOfferType.DISCOUNT_KIND_TowerUpgrade:
                _loc4_ = _loc4_ + "towerUpgrade.jpg";
                break;
            case DiscountOfferType.DISCOUNT_KIND_ConstructionWorker:
                _loc4_ = _loc4_ + "workers.jpg";
                break;
            case DiscountOfferType.DISCOUNT_KIND_Boost:
                _loc4_ = _loc4_ + getImgForBoost(param2);
                break;
            case DiscountOfferType.DISCOUNT_KIND_Buildings:
                if (GameType.isTotalDomination) {
                    _loc4_ = _loc4_ + getImgForBuildingsStandard(param2);
                }
                else if (!GameType.isNords) {
                    _loc4_ = _loc4_ + getImgForBuildings(param2);
                }
                break;
            case DiscountOfferType.DISCOUNT_KIND_Troops:
                _loc4_ = _loc4_ + getImgForUnit(param2);
                break;
            case DiscountOfferType.DISCOUNT_KIND_Resurrection:
                _loc4_ = _loc4_ + "newHospital.jpg";
                break;
            case DiscountOfferType.DISCOUNT_KIND_BlackMarketItems:
                _loc4_ = _loc4_ + getImgForBlackMarker(param2);
                break;
            case DiscountOfferType.DISCOUNT_KIND_InstantUnitReturn:
                _loc4_ = _loc4_ + "boost/boostTroopsReturn.jpg";
                break;
            case DiscountOfferType.DISCOUNT_KIND_AllianceCreating:
                _loc4_ = _loc4_ + "clanCreating.jpg";
        }
        return _loc4_;
    }

    private static function getImgForBuildingsStandard(param1:DiscountOfferType):String {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc2_:* = StringUtil.EMPTY;
        if (param1.buildingsData.allPerimeter) {
            _loc2_ = _loc2_ + "buildingDefence/buildingDefenceAll.jpg";
        }
        else if (param1.buildingsData.groupId != -1) {
            switch (param1.buildingsData.groupId) {
                case BuildingGroupId.DEFENSIVE:
                    _loc2_ = _loc2_ + "buildingDefence/buildingDefenceAll.jpg";
                    break;
                default:
                    _loc2_ = _loc2_ + "decor/decorAll.jpg";
            }
        }
        else if (param1.buildingsData.defensiveKind != -1) {
            switch (param1.buildingsData.defensiveKind) {
                case DefensiveKind.FLAG:
                    _loc2_ = _loc2_ + "decor/decorFlags.jpg";
                    break;
                case DefensiveKind.HOLIDAYS:
                    _loc2_ = _loc2_ + "decor/decorHoliday.jpg";
                    break;
                default:
                    _loc2_ = _loc2_ + "decor/decorWar.jpg";
            }
        }
        else if (param1.buildingsData.slotKindId == -1) {
            if (param1.buildingsData.decorTypes != null && param1.buildingsData.decorTypes.length > 0) {
                for each(_loc3_ in param1.buildingsData.decorTypes) {
                    switch (_loc3_) {
                        case DecorTypeId.DECOR_TYPE_ID_All:
                            _loc2_ = _loc2_ + "decor/decorAll.jpg";
                            break;
                        case DecorTypeId.DECOR_TYPE_ID_Miscellaneous:
                            _loc2_ = _loc2_ + "decor/decorWar.jpg";
                            break;
                        case DecorTypeId.DECOR_TYPE_ID_Flag:
                            _loc2_ = _loc2_ + "decor/decorFlags.jpg";
                            break;
                        case DecorTypeId.DECOR_TYPE_ID_Holidays:
                            _loc2_ = _loc2_ + "decor/decorHoliday.jpg";
                            break;
                        case DecorTypeId.DECOR_TYPE_ID_Military:
                            _loc2_ = _loc2_ + "decor/decorWar.jpg";
                    }
                }
            }
            else if (DictionaryUtil.lengthOf(param1.buildingsData.typeIdsDic) == 1) {
                for (_loc4_ in param1.buildingsData.typeIdsDic) {
                    if (_loc4_ == BuildingTypeId.RobotBoostResources) {
                        _loc2_ = _loc2_ + "buildingForGold.jpg";
                    }
                }
            }
        }
        return _loc2_;
    }

    private static function getImgForBuildings(param1:DiscountOfferType):String {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc2_:* = StringUtil.EMPTY;
        if (param1.buildingsData.allPerimeter) {
            _loc2_ = _loc2_ + "buildingDefence/buildingDefenceAll.jpg";
        }
        else if (param1.buildingsData.groupId != -1) {
            switch (param1.buildingsData.groupId) {
                case BuildingGroupId.DEFENSIVE:
                    _loc2_ = _loc2_ + "buildingDefence/buildingDefenceAll.jpg";
                    break;
                default:
                    _loc2_ = _loc2_ + "decor/decorAll.jpg";
            }
        }
        else if (param1.buildingsData.defensiveKind != -1) {
            _loc2_ = _loc2_ + "decor/decorAll.jpg";
        }
        else if (param1.buildingsData.slotKindId == -1) {
            if (param1.buildingsData.decorTypes && param1.buildingsData.decorTypes.length > 0) {
                for each(_loc3_ in param1.buildingsData.decorTypes) {
                    _loc2_ = _loc2_ + "decor/decorAll.jpg";
                }
            }
            else if (DictionaryUtil.lengthOf(param1.buildingsData.typeIdsDic) == 1) {
                for (_loc4_ in param1.buildingsData.typeIdsDic) {
                    if (_loc4_ == BuildingTypeId.RobotBoostResources) {
                        _loc2_ = _loc2_ + "buildingForGold.jpg";
                    }
                }
            }
        }
        return _loc2_;
    }

    private static function getImgForBlackMarker(param1:DiscountOfferType):String {
        if (param1.itemsData.typeIdsDic == null) {
            return StringUtil.EMPTY;
        }
        var _loc2_:String = StringUtil.EMPTY;
        var _loc3_:int = DictionaryUtil.lengthOf(param1.itemsData.typeIdsDic);
        if (_loc3_ == 1) {
            _loc2_ = getImageBMForOneType(param1.itemsData.typeIdsDic);
        }
        else if (_loc3_ > 1) {
            _loc2_ = getImageBMForManyTypes(param1.itemsData.typeIdsDic);
        }
        return _loc2_;
    }

    private static function getImageBMForOneType(param1:Dictionary):String {
        var _loc3_:BlackMarketItemRaw = null;
        var _loc4_:int = 0;
        var _loc5_:* = undefined;
        var _loc2_:* = StringUtil.EMPTY;
        for (_loc5_ in param1) {
            _loc3_ = StaticDataManager.blackMarketData.itemsById[_loc5_];
            if (_loc3_ != null) {
                if (_loc3_.vipActivatorData != null) {
                    _loc2_ = _loc2_ + "vip/vipActivator";
                    switch (_loc3_.vipActivatorData.durationSeconds) {
                        case DateUtil.SECONDS_2_DAYS:
                            _loc2_ = _loc2_ = _loc2_ + "_2_days";
                            break;
                        case DateUtil.SECONDS_7_DAYS:
                            _loc2_ = _loc2_ = _loc2_ + "_7_days";
                            break;
                        case DateUtil.SECONDS_30_DAYS:
                            _loc2_ = _loc2_ = _loc2_ + "_30_days";
                    }
                    _loc2_ = _loc2_ + ".jpg";
                }
                else if (_loc3_.vipPointsData != null) {
                    _loc4_ = _loc3_.vipPointsData.points;
                    _loc2_ = _loc2_ + "vip/vipPoints.jpg";
                    if (_loc4_ == 75 || _loc4_ == 150 || _loc4_ == 600) {
                        _loc2_ = _loc2_.replace(".jpg", "_" + _loc4_.toString() + ".jpg");
                    }
                }
                else if (_loc3_.chestData != null) {
                    _loc2_ = _loc2_ + "chest.jpg";
                }
                else if (_loc3_.gemRemovalData != null) {
                    _loc2_ = _loc2_ + "gemExtractor.jpg";
                }
                else if (_loc3_.boostData != null) {
                    _loc2_ = _loc2_ + "boost/booster.jpg";
                }
                else if (_loc3_.id == BlackMarketItemsTypeId.Slot_Rock) {
                    _loc2_ = _loc2_ + "centrifuge.jpg";
                }
                else if (_loc3_.sectorTeleportData != null) {
                    _loc2_ = _loc2_ + ("sectorTeleports/item_" + _loc3_.id + ".jpg");
                }
            }
        }
        return _loc2_;
    }

    private static function getImageBMForManyTypes(param1:Dictionary):String {
        var _loc3_:BlackMarketItemRaw = null;
        var _loc4_:int = 0;
        var _loc5_:* = undefined;
        var _loc2_:* = StringUtil.EMPTY;
        var _loc6_:Boolean = false;
        var _loc7_:Boolean = false;
        var _loc8_:int = 0;
        for (_loc5_ in param1) {
            _loc3_ = StaticDataManager.blackMarketData.itemsById[_loc5_];
            if (_loc3_ != null) {
                if (_loc3_.vipActivatorData != null) {
                    if (_loc8_ != 0 && _loc8_ != _loc3_.vipActivatorData.durationSeconds) {
                        _loc6_ = true;
                    }
                    _loc8_ = _loc3_.vipActivatorData.durationSeconds;
                }
                if (_loc3_.vipPointsData != null) {
                    if (_loc8_ != 0 && _loc8_ != _loc3_.vipPointsData.points) {
                        _loc7_ = true;
                    }
                    _loc8_ = _loc3_.vipPointsData.points;
                }
            }
        }
        if (_loc6_) {
            _loc2_ = _loc2_ + "vip/vipActivator.jpg";
        }
        if (_loc7_) {
            _loc2_ = _loc2_ + "vip/vipPoints.jpg";
        }
        if (!_loc7_ && !_loc6_) {
            for (_loc5_ in param1) {
                _loc3_ = StaticDataManager.blackMarketData.itemsById[_loc5_];
                if (_loc3_ == null) {
                    continue;
                }
                if (_loc3_.vipActivatorData != null) {
                    _loc2_ = _loc2_ + "vip/vipActivator";
                    switch (_loc3_.vipActivatorData.durationSeconds) {
                        case DateUtil.SECONDS_2_DAYS:
                            _loc2_ = _loc2_ = _loc2_ + "_2_days";
                            break;
                        case DateUtil.SECONDS_7_DAYS:
                            _loc2_ = _loc2_ = _loc2_ + "_7_days";
                            break;
                        case DateUtil.SECONDS_30_DAYS:
                            _loc2_ = _loc2_ = _loc2_ + "_30_days";
                    }
                    _loc2_ = _loc2_ + ".jpg";
                }
                else if (_loc3_.vipPointsData != null) {
                    _loc4_ = _loc3_.vipPointsData.points;
                    _loc2_ = _loc2_ + "vip/vipPoints.jpg";
                    if (_loc4_ == 75 || _loc4_ == 150 || _loc4_ == 600) {
                        _loc2_ = _loc2_.replace(".jpg", "_" + _loc4_.toString() + ".jpg");
                    }
                }
                else if (_loc3_.chestData != null) {
                    _loc2_ = _loc2_ + "chest.jpg";
                }
                else if (_loc3_.gemRemovalData != null) {
                    _loc2_ = _loc2_ + "gemExtractor.jpg";
                }
                else if (_loc3_.boostData != null && _loc3_.boostData.speedUpCoefficient == 0) {
                    _loc2_ = _loc2_ + "boost/booster.jpg";
                }
                else if (_loc3_.boostData != null && _loc3_.boostData.speedUpCoefficient != 0) {
                    _loc2_ = _loc2_ + "boost/teleporter.jpg";
                }
                else if (_loc3_.resourcesData != null) {
                    _loc2_ = _loc2_ + "resources/resourcesNew.jpg";
                }
                else if (_loc3_.resourcesBoostData != null) {
                    _loc2_ = _loc2_ + "boost/resourcesBoostNew_2.jpg";
                }
                else if (_loc3_.sectorTeleportData != null) {
                    _loc2_ = _loc2_ + "sectorTeleports/allSectorTeleports.jpg";
                }
                break;
            }
        }
        return _loc2_;
    }

    private static function getImgForUnit(param1:DiscountOfferType):String {
        var _loc3_:* = undefined;
        var _loc2_:* = "troops/";
        if (param1.troopsData.all) {
            _loc2_ = _loc2_ + "troopsAll.jpg";
        }
        else if (param1.troopsData.allGold) {
            _loc2_ = _loc2_ + "troopsElite.jpg";
        }
        else if (param1.troopsData.allStrategies) {
            _loc2_ = _loc2_ + "troopsStrategy.jpg";
        }
        else if (param1.troopsData.kindId != -1) {
            switch (param1.troopsData.kindId) {
                case TroopsKindId.ATTACKING:
                    _loc2_ = _loc2_ + "troopsAttack.jpg";
                    break;
                case TroopsKindId.DEFENSIVE:
                    _loc2_ = _loc2_ + "troopsDefence.jpg";
                    break;
                case TroopsKindId.RECON:
                    _loc2_ = _loc2_ + "troopsIntelligence.jpg";
            }
        }
        else if (param1.troopsData.groupId != -1) {
            switch (param1.troopsData.groupId) {
                case TroopsGroupId.STRATEGY:
                    _loc2_ = _loc2_ + "troopsStrategy.jpg";
            }
        }
        else if (param1.troopsData.typeIdsDic) {
            if (DictionaryUtil.lengthOf(param1.troopsData.typeIdsDic) == 1) {
                _loc2_ = _loc2_ + "units/";
                for (_loc3_ in param1.troopsData.typeIdsDic) {
                    _loc2_ = _loc2_ + (_loc3_.toString() + ".jpg");
                }
            }
            else if (DictionaryUtil.lengthOf(param1.troopsData.typeIdsDic) != 0) {
                _loc2_ = _loc2_ + "troopsElite.jpg";
            }
        }
        return _loc2_;
    }

    private static function getImgForBoost(param1:DiscountOfferType):String {
        var _loc3_:* = undefined;
        var _loc2_:* = "boost/";
        if (param1.boostData.all) {
            _loc2_ = _loc2_ + "boost.jpg";
            return _loc2_;
        }
        if (DictionaryUtil.lengthOf(param1.boostData.typeIdsDic) > 1) {
            if (DictionaryUtil.lengthOf(param1.boostData.typeIdsDic) == 2 && param1.boostData.typeIdsDic[BoostTypeId.INSTANT_TROOPS_QUEUE] && param1.boostData.typeIdsDic[BoostTypeId.INSTANT_TROOPS_ORDER]) {
                _loc2_ = _loc2_ + "boostUnits.jpg";
            }
            else if (DictionaryUtil.lengthOf(param1.boostData.typeIdsDic) == 3 && param1.boostData.typeIdsDic[BoostTypeId.RESOURCES_TITANITE] && param1.boostData.typeIdsDic[BoostTypeId.RESOURCES_URANIUM] && param1.boostData.typeIdsDic[BoostTypeId.RESOURCES_MONEY]) {
                _loc2_ = _loc2_ + "resourcesBoostNew_2.jpg";
            }
            else {
                _loc2_ = _loc2_ + "boost.jpg";
            }
            return _loc2_;
        }
        for (_loc3_ in param1.boostData.typeIdsDic) {
            switch (_loc3_) {
                case BoostTypeId.INSTANT_BUILDING:
                    _loc2_ = _loc2_ + "boostBuildings.jpg";
                    break;
                case BoostTypeId.INSTANT_TECHNOLOGY:
                    _loc2_ = _loc2_ + "boostTechnoligies.jpg";
                    break;
                case BoostTypeId.DAILY_QUEST:
                    _loc2_ = _loc2_ + "boostDailyQuest.jpg";
                    break;
                case BoostTypeId.INSTANT_TROOPS_QUEUE:
                case BoostTypeId.INSTANT_TROOPS_ORDER:
                    _loc2_ = _loc2_ + "boostUnits.jpg";
                    break;
                case BoostTypeId.RESOURCES_TITANITE:
                case BoostTypeId.RESOURCES_URANIUM:
                case BoostTypeId.RESOURCES_MONEY:
                    _loc2_ = _loc2_ + "resourcesBoostNew_2.jpg";
                    break;
                case BoostTypeId.INSTANT_SKILL:
                    _loc2_ = _loc2_ + "boost_instant_skill.jpg";
            }
            return _loc2_;
        }
        return _loc2_;
    }

    public static function getTextByDiscountKind(param1:int, param2:DiscountOfferType = null):Object {
        var _loc5_:Object = null;
        if (param2 == null) {
            return {
                "name": StringUtil.EMPTY,
                "description": StringUtil.EMPTY
            };
        }
        var _loc3_:String = StringUtil.EMPTY;
        var _loc4_:String = StringUtil.EMPTY;
        switch (param1) {
            case DiscountOfferType.DISCOUNT_KIND_Drawings:
                _loc3_ = LocaleUtil.getText("forms-formRoulette_Modules");
                _loc4_ = LocaleUtil.getText("forms-formRoulette_Drawings_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_ResourceKits:
                _loc3_ = LocaleUtil.getText("forms-formBlackMarket_resources");
                _loc4_ = LocaleUtil.getText("forms-formRoulette_ResourceKits_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_CitySkins:
                _loc3_ = LocaleUtil.getText("forms-formBlackMarket_towns");
                _loc4_ = LocaleUtil.getText("forms-formRoulette_CitySkins_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_ResourceConversion:
                _loc3_ = LocaleUtil.getText("forms_formBioreactor_JobItemRenderer_label02");
                _loc4_ = LocaleUtil.getText("forms-formRoulette_ResourceConversion_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_SectorExtension:
                _loc3_ = LocaleUtil.getText("forms-formBuildingShop_extensionControl_sector_extension");
                _loc4_ = LocaleUtil.getText("forms-formRoulette_SectorExtension_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_TowerUpgrade:
                _loc3_ = LocaleUtil.getText("forms-formPayment_Incoming_TowerUpgrade");
                _loc4_ = LocaleUtil.getText("forms-formRoulette_TowerUpgrade_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_ConstructionWorker:
                _loc3_ = LocaleUtil.getText("forms-formRoulette_ConstructionWorker");
                _loc4_ = LocaleUtil.getText("forms-formRoulette_ConstructionWorker_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_Boost:
                _loc3_ = getTextForBoost(param2);
                _loc4_ = LocaleUtil.getText("forms-formRoulette_Boost_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_Buildings:
                if (GameType.isTotalDomination) {
                    _loc3_ = getTextForBuildingsStandard(param2);
                }
                else if (!GameType.isNords) {
                    _loc3_ = getTextForBuildings(param2);
                }
                _loc4_ = LocaleUtil.getText("forms-formRoulette_Buildings_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_Troops:
                _loc3_ = getTextForUnit(param2);
                _loc4_ = LocaleUtil.getText("forms-formRoulette_Troops_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_Resurrection:
                _loc3_ = getTextForHospital(param2);
                _loc4_ = LocaleUtil.getText("forms-formRoulette_Resurrection_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_BlackMarketItems:
                _loc3_ = getTextForBlackMarker(param2);
                _loc4_ = LocaleUtil.getText("forms-formRoulette_BlackMarketItems_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_InstantUnitReturn:
                _loc3_ = LocaleUtil.getText("forms-formRoulette_BoostReturnTroops");
                _loc4_ = LocaleUtil.getText("forms-formRoulette_InstantUnitReturn_text");
                break;
            case DiscountOfferType.DISCOUNT_KIND_AllianceCreating:
                _loc3_ = LocaleUtil.getText("forms-formRoulette_AllianceCreating");
                _loc4_ = LocaleUtil.getText("forms-formRoulette_AllianceCreating_text");
        }
        _loc5_ = {
            "name": _loc3_,
            "description": _loc4_
        };
        return _loc5_;
    }

    private static function getTextForBoost(param1:DiscountOfferType):String {
        var _loc4_:* = undefined;
        var _loc2_:String = StringUtil.EMPTY;
        var _loc3_:uint = DictionaryUtil.lengthOf(param1.boostData.typeIdsDic);
        if (param1.boostData.all) {
            _loc2_ = LocaleUtil.getText("forms-formRoulette_AllBoosts");
            return _loc2_;
        }
        if (_loc3_ > 1) {
            if (_loc3_ == 2 && param1.boostData.typeIdsDic[BoostTypeId.INSTANT_TROOPS_QUEUE] && param1.boostData.typeIdsDic[BoostTypeId.INSTANT_TROOPS_ORDER]) {
                _loc2_ = LocaleUtil.getText("forms-formRoulette_BoostTrainingTroops");
            }
            else if (_loc3_ == 3 && param1.boostData.typeIdsDic[BoostTypeId.RESOURCES_TITANITE] && param1.boostData.typeIdsDic[BoostTypeId.RESOURCES_URANIUM] && param1.boostData.typeIdsDic[BoostTypeId.RESOURCES_MONEY]) {
                _loc2_ = LocaleUtil.getText("forms-formRoulette_BoostResourcesConsumption");
            }
            else {
                _loc2_ = LocaleUtil.getText("forms-formRoulette_AllBoosts");
            }
            return _loc2_;
        }
        for (_loc4_ in param1.boostData.typeIdsDic) {
            switch (_loc4_) {
                case BoostTypeId.INSTANT_BUILDING:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_BoostBuild");
                    break;
                case BoostTypeId.DAILY_QUEST:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_BoostDailyQuest");
                    break;
                case BoostTypeId.INSTANT_TECHNOLOGY:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_BoostTechnology");
                    break;
                case BoostTypeId.INSTANT_TROOPS_QUEUE:
                case BoostTypeId.INSTANT_TROOPS_ORDER:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_BoostTrainingTroops");
                    break;
                case BoostTypeId.RESOURCES_TITANITE:
                case BoostTypeId.RESOURCES_URANIUM:
                case BoostTypeId.RESOURCES_MONEY:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_BoostResourcesConsumption");
                    break;
                case BoostTypeId.INSTANT_SKILL:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_BoostInstantSkill");
            }
            return _loc2_;
        }
        return _loc2_;
    }

    private static function getTextForBuildingsStandard(param1:DiscountOfferType):String {
        var _loc3_:Boolean = false;
        var _loc4_:* = undefined;
        var _loc5_:String = null;
        var _loc6_:* = undefined;
        var _loc2_:String = StringUtil.EMPTY;
        if (param1.buildingsData.allPerimeter) {
            _loc2_ = LocaleUtil.getText("forms-formRoulette_DefensiveBuildings");
        }
        else if (param1.buildingsData.groupId != -1) {
            switch (param1.buildingsData.groupId) {
                case BuildingGroupId.DEFENSIVE:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_DefensiveBuildings");
                    break;
                case BuildingGroupId.DECOR_FOR_SECTOR:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_DecorativeBuildings");
            }
        }
        else if (param1.buildingsData.defensiveKind != -1) {
            switch (param1.buildingsData.defensiveKind) {
                case DefensiveKind.FLAG:
                    _loc2_ = LocaleUtil.getText("forms_formBuildingShop_decor_flags");
                    break;
                case DefensiveKind.HOLIDAYS:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_DecorativeHolidays");
                    break;
                default:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_MilitaryAndOthers");
            }
        }
        else if (param1.buildingsData.slotKindId == -1) {
            if (param1.buildingsData.decorTypes != null && param1.buildingsData.decorTypes.length > 0) {
                _loc3_ = false;
                for each(_loc4_ in param1.buildingsData.decorTypes) {
                    switch (_loc4_) {
                        case DecorTypeId.DECOR_TYPE_ID_All:
                            if (_loc3_) {
                                _loc2_ = _loc2_ + (StringUtil.WHITESPACE + LocaleUtil.getText("forms-formRoulette_And") + StringUtil.WHITESPACE);
                                _loc2_ = _loc2_ + LocaleUtil.getText("forms-formRoulette_DecorativeBuildings");
                            }
                            else {
                                _loc2_ = _loc2_ + LocaleUtil.getText("forms-formRoulette_DecorativeBuildings");
                                _loc3_ = true;
                            }
                            continue;
                        case DecorTypeId.DECOR_TYPE_ID_Miscellaneous:
                            if (_loc3_) {
                                _loc5_ = _loc2_;
                                _loc2_ = LocaleUtil.getText("forms-common_buildings_decor");
                                _loc2_ = _loc2_ + (StringUtil.WHITESPACE + LocaleUtil.getText("forms-formRoulette_And") + StringUtil.WHITESPACE + _loc5_);
                            }
                            else {
                                _loc2_ = _loc2_ + LocaleUtil.getText("forms-common_buildings_decor");
                                _loc3_ = true;
                            }
                            continue;
                        case DecorTypeId.DECOR_TYPE_ID_Flag:
                            if (_loc3_) {
                                _loc2_ = _loc2_ + (StringUtil.WHITESPACE + LocaleUtil.getText("forms-formRoulette_And") + StringUtil.WHITESPACE);
                                _loc2_ = _loc2_ + LocaleUtil.getText("forms_formBuildingShop_decor_flags");
                            }
                            else {
                                _loc2_ = _loc2_ + LocaleUtil.getText("forms_formBuildingShop_decor_flags");
                                _loc3_ = true;
                            }
                            continue;
                        case DecorTypeId.DECOR_TYPE_ID_Holidays:
                            if (_loc3_) {
                                _loc2_ = _loc2_ + (StringUtil.WHITESPACE + LocaleUtil.getText("forms-formRoulette_And") + StringUtil.WHITESPACE);
                                _loc2_ = _loc2_ + LocaleUtil.getText("forms-formRoulette_DecorativeHolidays");
                            }
                            else {
                                _loc2_ = _loc2_ + LocaleUtil.getText("forms-formRoulette_DecorativeHolidays");
                                _loc3_ = true;
                            }
                            continue;
                        case DecorTypeId.DECOR_TYPE_ID_Military:
                            if (_loc3_) {
                                _loc2_ = _loc2_ + (StringUtil.WHITESPACE + LocaleUtil.getText("forms-formRoulette_And") + StringUtil.WHITESPACE);
                                _loc2_ = _loc2_ + LocaleUtil.getText("forms-formRoulette_MilitaryAndOthers");
                            }
                            else {
                                _loc2_ = _loc2_ + LocaleUtil.getText("forms-formRoulette_MilitaryAndOthers");
                                _loc3_ = true;
                            }
                            continue;
                        default:
                            continue;
                    }
                }
            }
            else if (DictionaryUtil.lengthOf(param1.buildingsData.typeIdsDic) == 1) {
                for (_loc6_ in param1.buildingsData.typeIdsDic) {
                    _loc2_ = StaticDataManager.getObjectType(_loc6_).name;
                }
            }
        }
        return _loc2_;
    }

    private static function getTextForBuildings(param1:DiscountOfferType):String {
        var _loc3_:* = undefined;
        var _loc2_:String = StringUtil.EMPTY;
        if (param1.buildingsData.allPerimeter) {
            _loc2_ = LocaleUtil.getText("forms-formRoulette_DefensiveBuildings");
        }
        else if (param1.buildingsData.groupId != -1) {
            switch (param1.buildingsData.groupId) {
                case BuildingGroupId.DEFENSIVE:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_DefensiveBuildings");
                    break;
                case BuildingGroupId.DECOR_FOR_SECTOR:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_DecorativeBuildings");
            }
        }
        else if (param1.buildingsData.defensiveKind != -1) {
            _loc2_ = LocaleUtil.getText("forms-formRoulette_DecorativeBuildings");
        }
        else if (param1.buildingsData.slotKindId == -1) {
            if (param1.buildingsData.decorTypes != null && param1.buildingsData.decorTypes.length > 0) {
                _loc2_ = LocaleUtil.getText("forms-formRoulette_DecorativeBuildings");
            }
            else if (DictionaryUtil.lengthOf(param1.buildingsData.typeIdsDic) == 1) {
                for (_loc3_ in param1.buildingsData.typeIdsDic) {
                    _loc2_ = StaticDataManager.getObjectType(_loc3_).name;
                }
            }
        }
        return _loc2_;
    }

    private static function getTextForUnit(param1:DiscountOfferType):String {
        var _loc3_:* = null;
        var _loc4_:int = 0;
        var _loc5_:Boolean = false;
        var _loc6_:Boolean = false;
        var _loc7_:Boolean = false;
        var _loc8_:GeoSceneObjectType = null;
        if (param1 == null) {
            return null;
        }
        var _loc2_:String = StringUtil.EMPTY;
        if (param1.troopsData.all) {
            _loc2_ = LocaleUtil.getText("forms-formRoulette_units");
        }
        else if (param1.troopsData.allStrategies) {
            _loc2_ = LocaleUtil.getText("controls-common-troopsList-troopsListControl_strategyForces");
            if (param1.troopsData.kindId != -1) {
                switch (param1.troopsData.kindId) {
                    case TroopsKindId.ATTACKING:
                        _loc2_ = _loc2_ + ": " + LocaleUtil.getText("forms-formUnitDescription_attack2");
                        break;
                    case TroopsKindId.DEFENSIVE:
                        _loc2_ = _loc2_ + ": " + LocaleUtil.getText("forms-formUnitDescription_protection");
                        break;
                    case TroopsKindId.RECON:
                        _loc2_ = _loc2_ + ": " + LocaleUtil.getText("controls-menu-subMenuControl_intelligence");
                }
            }
        }
        else if (param1.troopsData.kindId != -1 && !param1.troopsData.allGold) {
            switch (param1.troopsData.kindId) {
                case TroopsKindId.ATTACKING:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_OffensiveTroops");
                    break;
                case TroopsKindId.DEFENSIVE:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_DefensiveTroops");
                    break;
                case TroopsKindId.RECON:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_ReconTroops");
            }
        }
        else if (param1.troopsData.allGold) {
            if (param1.troopsData.kindId != -1) {
                switch (param1.troopsData.kindId) {
                    case TroopsKindId.ATTACKING:
                        _loc2_ = LocaleUtil.getText("forms-formRoulette_OffensiveTroopsElite");
                        break;
                    case TroopsKindId.DEFENSIVE:
                        _loc2_ = LocaleUtil.getText("forms-formRoulette_DefensiveTroopsElite");
                        break;
                    case TroopsKindId.RECON:
                        _loc2_ = LocaleUtil.getText("forms-formRoulette_ReconTroopsElite");
                }
            }
            else {
                _loc2_ = LocaleUtil.getText("forms-formChoseTroops_army_elite");
            }
        }
        else if (param1.troopsData.groupId != -1) {
            switch (param1.troopsData.groupId) {
                case TroopsGroupId.STRATEGY:
                    _loc2_ = LocaleUtil.getText("controls-common-troopsList-troopsListControl_strategyForces");
            }
        }
        else if (param1.troopsData.typeIdsDic != null) {
            _loc4_ = DictionaryUtil.lengthOf(param1.troopsData.typeIdsDic);
            if (_loc4_ == 1) {
                for (_loc3_ in param1.troopsData.typeIdsDic) {
                    _loc2_ = StaticDataManager.getObjectType(uint(_loc3_)).name;
                }
            }
            else if (_loc4_ != 0) {
                _loc5_ = false;
                _loc6_ = false;
                _loc7_ = false;
                for (_loc3_ in param1.troopsData.typeIdsDic) {
                    _loc8_ = StaticDataManager.getObjectType(uint(_loc3_));
                    if (_loc8_ != null && _loc8_.troopsInfo != null && _loc8_.troopsInfo.groupId == TroopsGroupId.INFANTRY_2) {
                        if (_loc8_.troopsInfo.isAttacking) {
                            _loc6_ = true;
                        }
                        else if (_loc8_.troopsInfo.isDefensive) {
                            _loc5_ = true;
                        }
                        else if (_loc8_.troopsInfo.isRecon) {
                            _loc7_ = true;
                        }
                    }
                }
                if (_loc5_ && _loc6_ && _loc7_) {
                    _loc2_ = LocaleUtil.getText("forms-formChoseTroops_army_elite");
                }
                else if (_loc6_) {
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_OffensiveTroopsElite");
                }
                else if (_loc5_) {
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_DefensiveTroopsElite");
                }
                else if (_loc7_) {
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_ReconTroopsElite");
                }
            }
        }
        return _loc2_;
    }

    private static function getTextForHospital(param1:DiscountOfferType):String {
        if (param1 == null) {
            return null;
        }
        var _loc2_:String = StringUtil.EMPTY;
        if (param1.resurrectionData.all) {
            _loc2_ = LocaleUtil.getText("forms-formRoulette_AllTroopsResurection");
        }
        else if (param1.resurrectionData.kindId != -1) {
            switch (param1.resurrectionData.kindId) {
                case TroopsKindId.ATTACKING:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_AllOffensiveTroopsResurection");
                    break;
                case TroopsKindId.DEFENSIVE:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_AllDefensiveTroopsResurection");
                    break;
                case TroopsKindId.RECON:
                    _loc2_ = LocaleUtil.getText("forms-formRoulette_AllReconTroopsResurection");
            }
        }
        else if (param1.resurrectionData.allStrategies) {
            _loc2_ = LocaleUtil.getText("forms-formRoulette_AllStrategyTroopsResurection");
        }
        return _loc2_;
    }

    private static function getTextForBlackMarker(param1:DiscountOfferType):String {
        var _loc3_:* = undefined;
        var _loc4_:BlackMarketItemRaw = null;
        var _loc5_:Boolean = false;
        var _loc6_:Boolean = false;
        var _loc7_:Boolean = false;
        var _loc8_:Boolean = false;
        var _loc9_:Boolean = false;
        var _loc10_:Boolean = false;
        var _loc11_:BlackMarketItemRaw = null;
        if (param1.itemsData.typeIdsDic == null) {
            return StringUtil.EMPTY;
        }
        var _loc2_:String = StringUtil.EMPTY;
        if (DictionaryUtil.lengthOf(param1.itemsData.typeIdsDic) == 1) {
            for (_loc3_ in param1.itemsData.typeIdsDic) {
                _loc4_ = StaticDataManager.blackMarketData.itemsById[_loc3_];
                if (_loc4_) {
                    if (_loc4_.vipActivatorData) {
                        _loc2_ = LocaleUtil.buildString("forms-formRoulette_VipActivator", _loc4_.vipActivatorData.durationSeconds / (60 * 60 * 24));
                    }
                    if (_loc4_.vipPointsData) {
                        _loc2_ = LocaleUtil.buildString("forms-formRoulette_VipPoints", _loc4_.vipPointsData.points);
                    }
                    if (_loc4_.chestData) {
                        if (_loc4_.chestData.gemLevelFrom != _loc4_.chestData.gemLevelTo) {
                            _loc2_ = LocaleUtil.buildString("forms-formRoulette_СhestItemRemovalWithCount", _loc4_.chestData.gemLevelFrom, _loc4_.chestData.gemLevelTo);
                        }
                        else {
                            _loc2_ = LocaleUtil.buildString("forms-formRoulette_СhestItemChestWithCount", _loc4_.chestData.gemLevelFrom);
                        }
                    }
                    if (_loc4_.gemRemovalData) {
                        if (_loc4_.gemRemovalData.gemLevelFrom == 1 && _loc4_.gemRemovalData.gemLevelTo == 4) {
                            _loc2_ = LocaleUtil.getText("forms-formRoulette_GemAlpha");
                        }
                        if (_loc4_.gemRemovalData.gemLevelFrom == 1 && _loc4_.gemRemovalData.gemLevelTo == 8) {
                            _loc2_ = LocaleUtil.getText("forms-formRoulette_GemBeta");
                        }
                        if (_loc4_.gemRemovalData.gemLevelFrom == 1 && _loc4_.gemRemovalData.gemLevelTo == 12) {
                            _loc2_ = LocaleUtil.getText("forms-formRoulette_GemGamma");
                        }
                    }
                    if (_loc4_.boostData) {
                        _loc2_ = LocaleUtil.buildString("forms-formRoulette_BoostForMin", _loc4_.boostData.timeSeconds / 60);
                    }
                    if (_loc4_.id == BlackMarketItemsTypeId.Slot_Rock) {
                        _loc2_ = LocaleUtil.buildString("forms-formRoulette_GemGamma");
                    }
                    else if (_loc4_.sectorTeleportData) {
                        if (_loc4_.sectorTeleportData.random) {
                            _loc2_ = LocaleUtil.buildString("forms-blackMarketItems_sectorRandomTeleportHeader");
                        }
                        else {
                            _loc2_ = LocaleUtil.buildString("forms-blackMarketItems_sectorTeleportHeader");
                        }
                    }
                }
            }
        }
        else if (DictionaryUtil.lengthOf(param1.itemsData.typeIdsDic) > 1) {
            _loc5_ = false;
            _loc6_ = false;
            _loc7_ = false;
            _loc8_ = false;
            _loc9_ = false;
            _loc10_ = false;
            for (_loc3_ in param1.itemsData.typeIdsDic) {
                _loc4_ = StaticDataManager.blackMarketData.itemsById[_loc3_];
                if (_loc4_ != null) {
                    if (_loc4_.vipActivatorData != null) {
                        if (_loc11_ != null && _loc11_.vipActivatorData.durationSeconds != _loc4_.vipActivatorData.durationSeconds) {
                            _loc5_ = true;
                        }
                        _loc11_ = _loc4_;
                    }
                    else if (_loc4_.vipPointsData != null) {
                        if (_loc11_ != null && _loc11_.vipPointsData.points != _loc4_.vipPointsData.points) {
                            _loc6_ = true;
                        }
                        _loc11_ = _loc4_;
                    }
                    else if (_loc4_.chestData != null) {
                        if (_loc11_ != null && _loc11_.chestData != null) {
                            _loc7_ = true;
                        }
                        _loc11_ = _loc4_;
                    }
                    else if (_loc4_.gemRemovalData != null) {
                        if (_loc11_ != null && _loc11_.gemRemovalData != null && _loc11_.gemRemovalData.gemLevelTo != _loc4_.gemRemovalData.gemLevelTo) {
                            _loc8_ = true;
                        }
                        _loc11_ = _loc4_;
                    }
                    else if (_loc4_.boostData != null && _loc4_.boostData.speedUpCoefficient == 0) {
                        if (_loc11_ != null && _loc4_.boostData != null && _loc4_.boostData.speedUpCoefficient == 0) {
                            _loc9_ = true;
                        }
                        _loc11_ = _loc4_;
                    }
                    else if (_loc4_.boostData != null && _loc4_.boostData.speedUpCoefficient != 0) {
                        if (_loc11_ != null && _loc4_.boostData != null && _loc4_.boostData.speedUpCoefficient != 0) {
                            _loc10_ = true;
                        }
                        _loc11_ = _loc4_;
                    }
                }
            }
            if (!_loc6_ && !_loc5_ && !_loc8_ && !_loc7_) {
                for (_loc3_ in param1.itemsData.typeIdsDic) {
                    _loc4_ = StaticDataManager.blackMarketData.itemsById[_loc3_];
                    if (_loc4_ == null) {
                        continue;
                    }
                    if (_loc4_.vipActivatorData != null) {
                        _loc2_ = LocaleUtil.buildString("forms-formRoulette_VipActivator", _loc4_.vipActivatorData.durationSeconds / (60 * 60 * 24));
                    }
                    if (_loc4_.vipPointsData != null) {
                        _loc2_ = LocaleUtil.buildString("forms-formRoulette_VipPoints", _loc4_.vipPointsData.points);
                    }
                    if (_loc4_.chestData != null) {
                        if (_loc4_.chestData.gemLevelFrom != _loc4_.chestData.gemLevelTo) {
                            _loc2_ = LocaleUtil.buildString("forms-formRoulette_СhestItemRemovalWithCount", _loc4_.chestData.gemLevelFrom, _loc4_.chestData.gemLevelTo);
                        }
                        else {
                            _loc2_ = LocaleUtil.buildString("forms-formRoulette_СhestItemChestWithCount", _loc4_.chestData.gemLevelFrom);
                        }
                    }
                    if (_loc4_.gemRemovalData != null) {
                        if (_loc4_.gemRemovalData.gemLevelFrom == 1 && _loc4_.gemRemovalData.gemLevelTo == 4) {
                            _loc2_ = LocaleUtil.getText("forms-formRoulette_GemAlpha");
                        }
                        if (_loc4_.gemRemovalData.gemLevelFrom == 1 && _loc4_.gemRemovalData.gemLevelTo == 8) {
                            _loc2_ = LocaleUtil.getText("forms-formRoulette_GemBeta");
                        }
                        if (_loc4_.gemRemovalData.gemLevelFrom == 1 && _loc4_.gemRemovalData.gemLevelTo == 12) {
                            _loc2_ = LocaleUtil.getText("forms-formRoulette_GemGamma");
                        }
                    }
                    if (_loc4_.boostData != null) {
                        _loc2_ = LocaleUtil.buildString("forms-formRoulette_BoostForMin", _loc4_.boostData.timeSeconds / 60);
                    }
                    else if (_loc4_.resourcesData != null) {
                        _loc2_ = LocaleUtil.getText("forms-formBlackMarket_resources");
                    }
                    else if (_loc4_.resourcesBoostData != null) {
                        _loc2_ = LocaleUtil.getText("forms-formRoulette_BoostResourcesConsumption");
                    }
                    else if (_loc4_.sectorTeleportData != null) {
                        _loc2_ = LocaleUtil.getText("forms-formRoulette_sectorTeleport_all");
                    }
                    break;
                }
            }
            if (_loc5_) {
                _loc2_ = LocaleUtil.getText("forms-formBlackMarket-chestItemRenderer_labelNameActivate");
            }
            if (_loc9_) {
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_boosts");
            }
            if (_loc10_) {
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_teleportersHeader");
            }
            if (_loc6_) {
                _loc2_ = LocaleUtil.getText("forms-formBlackMarket-chestItemRenderer_labelNameVIP_Points");
            }
            if (_loc7_) {
                _loc2_ = LocaleUtil.getText("forms-formRoulette_СhestAll");
            }
            if (_loc8_) {
                _loc2_ = LocaleUtil.getText("forms-formRoulette_GemAll");
            }
        }
        return _loc2_;
    }

    private static function get isSaleAvailable_MK():Boolean {
        var _loc1_:Date = DateUtil.toUtc(_lastDiscountOpenTime);
        var _loc2_:Date = DateUtil.toUtc(ServerTimeManager.serverTimeNow);
        var _loc3_:Number = DateUtil.getDatePart(_loc2_).time - DateUtil.getDatePart(_loc1_).time;
        return _loc3_ >= OFFERS_INTERVAL;
    }

    private static function fillDiscountsByType():void {
        var _loc1_:DiscountOfferType = null;
        for each(_loc1_ in discountOfferTypes) {
            if (_loc1_ == null) {
                return;
            }
            switch (_loc1_.kind) {
                case DiscountOfferType.DISCOUNT_KIND_Drawings:
                    fillDiscountsByTypeDrawings(_loc1_);
                    continue;
                case DiscountOfferType.DISCOUNT_KIND_Buildings:
                    if (GameType.isTotalDomination) {
                        fillDiscountsByTypeBuildingsStandard(_loc1_);
                    }
                    else if (!GameType.isNords) {
                        fillDiscountsByTypeBuildings(_loc1_);
                    }
                    continue;
                case DiscountOfferType.DISCOUNT_KIND_Troops:
                    fillDiscountsByTypeTroops(_loc1_);
                    continue;
                default:
                    continue;
            }
        }
    }

    private static function fillDiscountsByTypeDrawings(param1:DiscountOfferType):void {
        var _loc2_:int = 0;
        var _loc3_:GeoSceneObject = null;
        var _loc4_:* = undefined;
        if (param1.drawingsData.all) {
            _loc2_ = UserManager.user.gameData.technologyCenter.technologies.length - 1;
            while (_loc2_ > 0) {
                _loc3_ = UserManager.user.gameData.technologyCenter.technologies[_loc2_] as GeoSceneObject;
                _allTypeIdsDic[_loc3_.objectType.id] = getCoefficient(param1);
                _loc2_--;
            }
        }
        else if (DictionaryUtil.lengthOf(param1.drawingsData.drawingIdsDic) > 0) {
            for (_loc4_ in param1.drawingsData.drawingIdsDic) {
                _allTypeIdsDic[_loc4_] = getCoefficient(param1);
            }
        }
    }

    private static function fillDiscountsByTypeBuildingsStandard(param1:DiscountOfferType):void {
        var _loc2_:Boolean = false;
        var _loc3_:GeoSceneObjectType = null;
        var _loc4_:* = undefined;
        var _loc5_:* = undefined;
        if (param1.buildingsData.allPerimeter) {
            for each(_loc3_ in StaticDataManager.types) {
                if (!_loc3_.isGroupKind(BuildingGroupId.HIDDEN) && !_loc3_.isRobot) {
                    _loc2_ = GameType.isMilitary && !_loc3_.isNotMilitaryBuilding && _loc3_.isPerimeterBuildings;
                    if (_loc3_.buildingInfo.groupId == param1.buildingsData.groupId && !_loc3_.isOre) {
                        if (!_loc3_.isDefensive && !_loc2_) {
                            _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                        }
                    }
                    if (_loc3_.isDefensive || _loc2_) {
                        _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                    }
                }
            }
        }
        else if (param1.buildingsData.groupId != -1) {
            for each(_loc3_ in StaticDataManager.types) {
                if (!_loc3_.isGroupKind(BuildingGroupId.HIDDEN) && !_loc3_.isRobot) {
                    _loc2_ = GameType.isMilitary && !_loc3_.isNotMilitaryBuilding && _loc3_.isPerimeterBuildings;
                    if (_loc3_.buildingInfo.groupId == param1.buildingsData.groupId && !_loc3_.isOre) {
                        if (!_loc3_.isDefensive && !_loc2_) {
                            _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                        }
                    }
                    if (param1.buildingsData.groupId == BuildingGroupId.DEFENSIVE) {
                        if (_loc3_.isDefensive || _loc2_) {
                            _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                        }
                    }
                }
            }
        }
        else if (param1.buildingsData.defensiveKind != -1) {
            for each(_loc3_ in StaticDataManager.types) {
                switch (param1.buildingsData.defensiveKind) {
                    case DefensiveKind.FLAG:
                        if (_loc3_.isFlag && _loc3_.id != BuildingTypeId.Robot1) {
                            _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                        }
                        continue;
                    case DefensiveKind.HOLIDAYS:
                        if (_loc3_.isHoliday && _loc3_.id != BuildingTypeId.Robot1) {
                            _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                        }
                        continue;
                    case DefensiveKind.DECOR_MILITARY:
                        if (_loc3_.isDecorativeBuilding && _loc3_.id != BuildingTypeId.Robot1) {
                            _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                        }
                        continue;
                    default:
                        continue;
                }
            }
        }
        else if (param1.buildingsData.slotKindId == -1) {
            if (param1.buildingsData.decorTypes != null && param1.buildingsData.decorTypes.length > 0) {
                for each(_loc3_ in StaticDataManager.types) {
                    for each(_loc4_ in param1.buildingsData.decorTypes) {
                        switch (_loc4_) {
                            case DecorTypeId.DECOR_TYPE_ID_All:
                                if (_loc3_.isDecorativeBuilding && _loc3_.id != BuildingTypeId.Robot1) {
                                    _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                                }
                                continue;
                            case DecorTypeId.DECOR_TYPE_ID_Miscellaneous:
                                if (_loc3_.isMisc && _loc3_.isDecorativeBuilding && _loc3_.id != BuildingTypeId.Robot1) {
                                    _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                                }
                                continue;
                            case DecorTypeId.DECOR_TYPE_ID_Flag:
                                if (_loc3_.isFlag && _loc3_.id != BuildingTypeId.Robot1) {
                                    _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                                }
                                continue;
                            case DecorTypeId.DECOR_TYPE_ID_Holidays:
                                if (_loc3_.isHoliday && _loc3_.id != BuildingTypeId.Robot1) {
                                    _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                                }
                                continue;
                            case DecorTypeId.DECOR_TYPE_ID_Military:
                                if (_loc3_.isDecorMilitary && _loc3_.id != BuildingTypeId.Robot1 && _loc3_.id != BuildingTypeId.RobotBoostResources) {
                                    _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                                }
                                continue;
                            default:
                                continue;
                        }
                    }
                }
            }
            else if (DictionaryUtil.lengthOf(param1.buildingsData.typeIdsDic) == 1) {
                for (_loc5_ in param1.buildingsData.typeIdsDic) {
                    _allTypeIdsDic[_loc5_] = getCoefficient(param1);
                }
            }
        }
    }

    private static function fillDiscountsByTypeBuildings(param1:DiscountOfferType):void {
        var _loc2_:Boolean = false;
        var _loc3_:GeoSceneObjectType = null;
        var _loc4_:* = undefined;
        if (param1.buildingsData.allPerimeter) {
            for each(_loc3_ in StaticDataManager.types) {
                if (_loc3_.buildingInfo != null && !_loc3_.isGroupKind(BuildingGroupId.HIDDEN) && !_loc3_.isRobot) {
                    _loc2_ = GameType.isMilitary && !_loc3_.isNotMilitaryBuilding && _loc3_.isPerimeterBuildings;
                    if (_loc3_.buildingInfo.groupId == param1.buildingsData.groupId && !_loc3_.isOre) {
                        if (!_loc3_.isDefensive && !_loc2_) {
                            _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                        }
                    }
                    if (_loc3_.isDefensive || _loc2_) {
                        _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                    }
                }
            }
        }
        else if (param1.buildingsData.groupId != -1) {
            if (BuildingGroupId.isDecor(param1.buildingsData.groupId)) {
                allDecor(param1);
            }
            else {
                for each(_loc3_ in StaticDataManager.types) {
                    if (_loc3_.buildingInfo != null && !_loc3_.isGroupKind(BuildingGroupId.HIDDEN) && !_loc3_.isRobot) {
                        _loc2_ = GameType.isMilitary && !_loc3_.isNotMilitaryBuilding && _loc3_.isPerimeterBuildings;
                        if (_loc3_.buildingInfo.groupId == param1.buildingsData.groupId && !_loc3_.isOre) {
                            if (!_loc3_.isDefensive && !_loc2_) {
                                _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                            }
                        }
                        if (param1.buildingsData.groupId == BuildingGroupId.DEFENSIVE) {
                            if (_loc3_.isDefensive || _loc2_) {
                                _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                            }
                        }
                    }
                }
            }
        }
        else if (param1.buildingsData.defensiveKind != -1) {
            allDecor(param1);
        }
        else if (param1.buildingsData.slotKindId == -1) {
            if (param1.buildingsData.decorTypes != null && param1.buildingsData.decorTypes.length > 0) {
                allDecor(param1);
            }
            else if (DictionaryUtil.lengthOf(param1.buildingsData.typeIdsDic) == 1) {
                for (_loc4_ in param1.buildingsData.typeIdsDic) {
                    _allTypeIdsDic[_loc4_] = getCoefficient(param1);
                }
            }
        }
    }

    private static function allDecor(param1:DiscountOfferType):void {
        var _loc2_:GeoSceneObjectType = null;
        var _loc3_:Boolean = false;
        for each(_loc2_ in StaticDataManager.types) {
            if (!(!_loc2_.isBuilding || _loc2_.buildingInfo.groupId == BuildingGroupId.HIDDEN)) {
                _loc3_ = GameType.isMilitary && (_loc2_.isRobot || _loc2_.isPerimeterBuildings) && !_loc2_.isNotMilitaryBuilding;
                if (_loc2_.isDecorativeBuilding && !_loc3_ && _loc2_.id != BuildingTypeId.Robot1) {
                    _allTypeIdsDic[_loc2_.id] = getCoefficient(param1);
                }
            }
        }
    }

    private static function fillDiscountsByTypeTroops(param1:DiscountOfferType):void {
        var _loc3_:GeoSceneObjectType = null;
        var _loc4_:* = undefined;
        var _loc2_:ArrayCustom = StaticDataManager.getAllUnits();
        if (param1.troopsData.all) {
            for each(_loc3_ in _loc2_) {
                if (_loc3_.id != TroopsTypeId.StrategyUnit10 && _loc3_.id != TroopsTypeId.StrategyUnit11) {
                    _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                }
            }
        }
        else if (param1.troopsData.allStrategies) {
            if (param1.troopsData.kindId != -1) {
                for each(_loc3_ in _loc2_) {
                    if (_loc3_.isStrategyUnit && _loc3_.troopsInfo.kindId == param1.troopsData.kindId) {
                        _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                    }
                }
            }
            else {
                for each(_loc3_ in _loc2_) {
                    if (_loc3_.isStrategyUnit && _loc3_.id != TroopsTypeId.StrategyUnit10 && _loc3_.id != TroopsTypeId.StrategyUnit11) {
                        _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                    }
                }
            }
        }
        else if (param1.troopsData.allGold) {
            if (param1.troopsData.kindId != -1) {
                switch (param1.troopsData.kindId) {
                    case TroopsKindId.ATTACKING:
                        for each(_loc3_ in _loc2_) {
                            if (_loc3_.isGold && _loc3_.troopsInfo.kindId == TroopsKindId.ATTACKING) {
                                _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                            }
                        }
                        break;
                    case TroopsKindId.DEFENSIVE:
                        for each(_loc3_ in _loc2_) {
                            if (_loc3_.isGold && _loc3_.troopsInfo.kindId == TroopsKindId.DEFENSIVE) {
                                _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                            }
                        }
                        break;
                    case TroopsKindId.RECON:
                        for each(_loc3_ in _loc2_) {
                            if (_loc3_.isGold && _loc3_.troopsInfo.kindId == TroopsKindId.RECON) {
                                _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                            }
                        }
                }
            }
            else {
                for each(_loc3_ in _loc2_) {
                    if (_loc3_.isGold) {
                        _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                    }
                }
            }
        }
        else if (param1.troopsData.kindId != -1) {
            for each(_loc3_ in _loc2_) {
                switch (param1.troopsData.kindId) {
                    case TroopsKindId.ATTACKING:
                        if (!_loc3_.isStrategyUnit && _loc3_.troopsInfo.kindId == TroopsKindId.ATTACKING) {
                            _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                        }
                        continue;
                    case TroopsKindId.DEFENSIVE:
                        if (!_loc3_.isStrategyUnit && _loc3_.troopsInfo.kindId == TroopsKindId.DEFENSIVE) {
                            _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                        }
                        continue;
                    case TroopsKindId.RECON:
                        if (!_loc3_.isStrategyUnit && _loc3_.troopsInfo.kindId == TroopsKindId.RECON) {
                            _allTypeIdsDic[_loc3_.id] = getCoefficient(param1);
                        }
                        continue;
                    default:
                        continue;
                }
            }
        }
        else if (param1.troopsData.groupId == -1) {
            if (DictionaryUtil.lengthOf(param1.troopsData.typeIdsDic) > 0) {
                for (_loc4_ in param1.troopsData.typeIdsDic) {
                    _allTypeIdsDic[_loc4_] = getCoefficient(param1);
                }
            }
        }
    }

    private static function comparator(param1:Number, param2:Number):int {
        if (param1 > param2) {
            return -1;
        }
        if (param1 < param2) {
            return 1;
        }
        return 0;
    }

    private static function removeItem(param1:uint):void {
        if (_activeDiscountOffers[param1]) {
            _activeDiscountOffers.splice(param1, 1);
            _discountOfferTypes.splice(param1, 1);
            _allTypeIdsDic = new Dictionary();
            fillDiscountsByType();
            _isSale = _activeDiscountOffers != null && _activeDiscountOffers.length > 0 && _discountOfferTypes != null && _discountOfferTypes.length > 0;
            events.dispatchEvent(new Event(ACTIVE_DISCOUNT_OFFERS_UPDATE));
        }
    }

    private static function time_tick(param1:Event):void {
        var _loc2_:uint = 0;
        if (!isSaleToday) {
            if (!GameType.isMilitary) {
                if (_lastDiscountOpenTime.time + TIME_TO_NEXT_SALE > ServerTimeManager.serverTimeNow.time) {
                    events.dispatchEvent(new Event(NEXT_DISCOUNT_TIME_CHANGED));
                }
                else {
                    isSaleToday = checkSaleToDay();
                    events.dispatchEvent(new Event(ACTIVE_DISCOUNT_OFFERS_UPDATE));
                }
            }
            else if (isSaleAvailable_MK) {
                isSaleToday = checkSaleToDay();
                openDiscountOffer();
            }
        }
        if (_isSale) {
            events.dispatchEvent(new Event(DISCOUNT_TIME_CHANGED));
            _loc2_ = 0;
            while (_loc2_ < _activeDiscountOffers.length) {
                if (_activeDiscountOffers[_loc2_] != null) {
                    if (ServerTimeManager.serverTimeNow.time > _activeDiscountOffers[_loc2_].validTill.time) {
                        removeItem(_loc2_);
                    }
                }
                _loc2_++;
            }
        }
    }

    public static function get events():EventDispatcher {
        if (_eventDispatcher == null) {
            _eventDispatcher = new EventDispatcher();
        }
        return _eventDispatcher;
    }

    public static function addEventListener(param1:String, param2:Function):void {
        events.addEventListener(param1, param2);
    }

    public static function removeEventListener(param1:String, param2:Function):void {
        events.removeEventListener(param1, param2);
    }

    public static function hasEventListener(param1:String):Boolean {
        return events.hasEventListener(param1);
    }
}
}
