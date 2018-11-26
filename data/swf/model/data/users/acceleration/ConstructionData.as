package model.data.users.acceleration {
import common.ArrayCustom;
import common.DateUtil;
import common.DictionaryUtil;
import common.GameType;
import common.queries.util.query;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.data.ResourceTypeId;
import model.data.Resources;
import model.data.User;
import model.data.UserGameData;
import model.data.acceleration.types.BoostTypeId;
import model.data.acceleration.types.ResourceConsumptionBonusBoostType;
import model.data.acceleration.types.ResourceMiningBoostType;
import model.data.effects.EffectData;
import model.data.normalization.INConstructible;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.data.normalization.Normalizer;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.objects.info.BuildingObjInfo;
import model.data.scenes.objects.info.ConstructionObjInfo;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.ArtifactTypeInfo;
import model.data.scenes.types.info.BuildingLevelInfo;
import model.data.scenes.types.info.BuildingTypeId;
import model.data.scenes.types.info.BuildingTypeInfo;
import model.data.scenes.types.info.SaleableTypeInfo;
import model.data.scenes.types.info.TroopsTypeId;
import model.data.units.Unit;
import model.data.units.payloads.TradingPayload;
import model.data.users.acceleration.accelerationBehavior.AccelerationBehaviorStandard;
import model.data.users.acceleration.accelerationBehavior.AccelerationBehaviorTechnology;
import model.data.users.buildings.Sector;
import model.data.users.trading.TradingOffer;
import model.data.users.troops.TroopsOrder;
import model.data.wisdomSkills.enums.WisdomSkillBonusType;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.resourcesConversion.data.ResourcesConversionJob;
import model.logic.resourcesConversion.data.UserResourcesConversionData;
import model.logic.skills.SkillManager;
import model.modules.dragonAbilities.data.Ability;

public class ConstructionData extends ObservableObject implements INormalizable {

    public static const CLASS_NAME:String = "ConstructionData";

    public static const CONSTRUCTION_WORKERS_CHANGED:String = CLASS_NAME + "ConstructionWorkersChanged";

    public static const AVAILABLE_WORKERS_CHANGED:String = CLASS_NAME + "AvailableWorkersChanged";

    public static const CONSUMPTION_CHANGED:String = CLASS_NAME + "ConsumptionChanged";

    public static const CONSTRUCTION_ADDITIONAL_WORKERS_CHANGED:String = CLASS_NAME + "ConstructionAdditionalWorkersChanged";

    public static const ADDITIONAL_INVENTORY_DESTROYER_CHANGED:String = CLASS_NAME + "additionalInventoryDestroyerChanged";

    public static const ADDITIONAL_RESEARCHER_CHANGED:String = CLASS_NAME + "AdditionalResearcherChanged";

    public static const RESOURCES_CONSUMPTION_CHANGED:String = CLASS_NAME + "ResourcesConsumptionChanged";

    public static const RESOURCES_BOOST_CHANGED:String = CLASS_NAME + "ResourcesBoostChanged";

    private static var accelerationBehavior:AccelerationBehaviorStandard;


    private var _constructionWorkersChanged:Boolean;

    private var _constructionAdditionalWorkersChanged:Boolean;

    private var _additionalInventoryDestroyerChanged:Boolean;

    private var _additionalResearcherChanged:Boolean;

    private var _additionalWorkersUsed:Boolean;

    private var _availableWorkersChanged:Boolean;

    private var _resourceConsumptionChangedDirty:Boolean;

    private var _resourcesBoostChanged:Boolean;

    private var _consumptionChanged:Boolean;

    public var workersUsed:int = -1;

    public var troopsAcceleration:Dictionary;

    public var buildingAcceleration:Number;

    public var researchAcceleration:Number;

    public var numberOfAllies:int;

    public var caravanQuantity:int;

    public var caravanCapacityPercent:int;

    public var caravanCapacity:Number;

    public var caravanCapacityPercentBoost:int;

    public var caravanSpeedPercent:int;

    public var caravanSpeed:Number;

    public var resourceMiningBoosts:ArrayCustom;

    public var resourceConsumptionBonusBoosts:ArrayCustom;

    public var resourceMiningBoostAutoRenewal:Boolean;

    public var resourceMiningBoostAutoRenewalMoney:Boolean;

    public var resourceMiningBoostAutoRenewalTitanite:Boolean;

    public var resourceMiningBoostAutoRenewalUranium:Boolean;

    public var resourceConsumptionBonusBoostAutoRenewal:Boolean;

    public var buildTrooperFaster:Boolean;

    public var buildDogFaster:Boolean;

    public var buildReconFaster:Boolean;

    public var hasDiscountForBuildingRobot:Boolean;

    public var constructionWorkersCount:int;

    public var consumptionBonusPercent:Number;

    public var consumptionBonusPercents:Dictionary;

    public var currentRepariRobotsCount:Number;

    public var freeTechnologiesResearched:Boolean;

    public var additionalWorkersExpireDateTimes:ArrayCustom;

    public var troopsQueueHoursLimit:Dictionary;

    public var extraSectorDefenceBonus:Number;

    public var extraSectorDefenceGlobalBonus:Number;

    public var bioplasmConversionAcceleration:Number;

    public var dragonAbilitiesResearchAcceleration:Number;

    public var dragonHitsRefreshTimeAcceleration:Number;

    public var itemsPowderingAcceleration:Number;

    public var itemsDustBonus:Number;

    public var additionalResearchersExpireDateTimes:ArrayCustom;

    public var additionalInventoryDestroyerExpireDateTimes:ArrayCustom;

    public var allianceBonusWindowShownToday:Boolean;

    public var builtConsulateAlertShownToday:Boolean;

    public function ConstructionData() {
        super();
    }

    public static function getFinishTimeWithoutEffectBonus(param1:INConstructible, param2:Date):Date {
        var _loc5_:Date = null;
        var _loc7_:Number = NaN;
        var _loc8_:Number = NaN;
        var _loc9_:Number = NaN;
        var _loc3_:GeoSceneObjectType = param1.objectType;
        var _loc4_:Number = 0;
        var _loc6_:Date = param1.constructionObjInfo.constructionFinishTime;
        if (_loc3_.buildingInfo != null) {
            _loc4_ = UserManager.user.gameData.effectData.getBuildingAcceleration();
            if (_loc4_) {
                _loc7_ = ConstructionData.getBuildingAcc(UserManager.user.gameData);
                if (_loc6_) {
                    _loc5_ = getFinishConstructionTimeWithAcceleration(_loc6_, _loc7_, _loc7_ - _loc4_, param2);
                }
            }
        }
        else if (_loc3_.troopsInfo != null) {
            _loc4_ = UserManager.user.gameData.effectData.getTroopsAcceleration()[_loc3_.id];
            if (_loc4_) {
                _loc8_ = 100 / (100 + _loc4_);
                _loc5_ = getCorrectFinishTime(_loc6_.time, _loc8_, param2);
            }
        }
        else if (_loc3_.technologyInfo != null) {
            _loc4_ = UserManager.user.gameData.effectData.getResearchAcceleration();
            if (_loc4_) {
                _loc9_ = ConstructionData.getResearchAcc(UserManager.user.gameData);
                if (_loc6_) {
                    _loc5_ = getFinishConstructionTimeWithAcceleration(_loc6_, _loc9_, _loc9_ - _loc4_, param2);
                }
            }
        }
        if (_loc4_ == 0) {
            _loc5_ = _loc6_;
        }
        return _loc5_;
    }

    private static function getFinishConstructionTimeWithAcceleration(param1:Date, param2:Number, param3:Number, param4:Date):Date {
        var _loc5_:Number = (100 + param3) / (100 + param2);
        return getCorrectFinishTime(param1.time, _loc5_, param4);
    }

    public static function getFinishAbilityTimeWithoutEffectBonus(param1:Ability, param2:Date):Date {
        var _loc3_:Date = null;
        var _loc5_:Number = NaN;
        var _loc4_:Number = UserManager.user.gameData.effectData.getDragonAbilitiesResearchAcceleration();
        if (_loc4_ == 0) {
            _loc3_ = param1.constructionObjInfo.constructionFinishTime;
        }
        else if (param1.constructionObjInfo.constructionFinishTime) {
            _loc5_ = 100 / (100 + _loc4_);
            _loc3_ = getCorrectFinishTime(param1.constructionObjInfo.constructionFinishTime.time, _loc5_, param2);
        }
        return _loc3_;
    }

    private static function correctFinishTime(param1:INConstructible, param2:Number, param3:Date):void {
        var _loc4_:Number = param1.constructionObjInfo.constructionFinishTime.time;
        param1.constructionObjInfo.constructionFinishTime = getCorrectFinishTime(_loc4_, param2, param3);
    }

    private static function getCorrectFinishTime(param1:Number, param2:Number, param3:Date):Date {
        var _loc4_:Date = new Date(param3.time + (param1 - param3.time) * (1 / param2));
        return Normalizer.normalizeTime(_loc4_);
    }

    private static function getTroopsQueueHoursLimit(param1:UserGameData):Dictionary {
        var _loc3_:GeoSceneObject = null;
        var _loc4_:BuildingObjInfo = null;
        var _loc5_:int = 0;
        var _loc6_:BuildingLevelInfo = null;
        var _loc7_:Dictionary = null;
        var _loc8_:* = null;
        var _loc9_:Number = NaN;
        var _loc2_:Dictionary = new Dictionary();
        for each(_loc3_ in param1.sector.sectorScene.sceneObjects) {
            _loc4_ = _loc3_.buildingInfo;
            _loc5_ = _loc3_.getLevel();
            if (!(_loc4_ == null || _loc5_ == 0)) {
                _loc6_ = _loc3_.objectType.buildingInfo.getLevelInfo(_loc5_);
                _loc7_ = _loc6_.troopsQueueHoursLimit;
                if (_loc7_ != null) {
                    for (_loc8_ in _loc7_) {
                        _loc9_ = _loc7_[_loc8_];
                        if (_loc2_[_loc8_] != null) {
                            _loc2_[_loc8_] = _loc2_[_loc8_] + _loc9_;
                        }
                        else {
                            _loc2_[_loc8_] = _loc9_;
                        }
                    }
                }
            }
        }
        return _loc2_.length == 0 ? null : _loc2_;
    }

    private static function getTroopsAcc(param1:UserGameData):Dictionary {
        var _loc3_:GeoSceneObjectType = null;
        var _loc4_:GeoSceneObject = null;
        var _loc5_:Dictionary = null;
        var _loc6_:* = undefined;
        var _loc7_:Dictionary = null;
        var _loc8_:* = undefined;
        var _loc9_:BuildingObjInfo = null;
        var _loc10_:int = 0;
        var _loc11_:BuildingLevelInfo = null;
        var _loc12_:* = undefined;
        var _loc13_:ArtifactTypeInfo = null;
        var _loc14_:Number = NaN;
        var _loc15_:int = 0;
        var _loc16_:Number = NaN;
        var _loc17_:int = 0;
        var _loc18_:Dictionary = null;
        var _loc19_:Number = NaN;
        var _loc2_:Dictionary = new Dictionary();
        for each(_loc3_ in StaticDataManager.types) {
            if (_loc3_.troopsInfo != null) {
                _loc2_[_loc3_.id] = 0;
            }
        }
        for each(_loc4_ in param1.sector.sectorScene.sceneObjects) {
            _loc9_ = _loc4_.buildingInfo;
            _loc10_ = _loc4_.getLevel();
            if (!(_loc9_ == null || _loc10_ == 0)) {
                _loc11_ = _loc4_.objectType.buildingInfo.getLevelInfo(_loc4_.getLevel());
                if (_loc11_.troopsAcceleration != null) {
                    for (_loc12_ in _loc11_.troopsAcceleration) {
                        _loc2_[_loc12_] = Number(_loc11_.troopsAcceleration[_loc12_]);
                    }
                }
            }
        }
        _loc5_ = param1.artifactData.getBonusesByAffectedTypes();
        for (_loc6_ in _loc5_) {
            _loc13_ = _loc5_[_loc6_];
            if (!isNaN(_loc13_.constructionSpeedBonus)) {
                _loc14_ = _loc13_.constructionSpeedBonus;
                _loc15_ = _loc6_;
                if (_loc2_[_loc15_] != null) {
                    _loc2_[_loc15_] = _loc2_[_loc15_] + _loc14_;
                }
                else {
                    _loc2_[_loc15_] = _loc14_;
                }
            }
        }
        _loc7_ = SkillManager.GetTroopsTrainingBonus(param1);
        for (_loc8_ in _loc7_) {
            _loc16_ = _loc7_[_loc8_];
            _loc17_ = _loc8_;
            if (_loc2_[_loc17_] != null) {
                _loc2_[_loc17_] = _loc2_[_loc17_] + _loc16_;
            }
            else {
                _loc2_[_loc17_] = _loc16_;
            }
        }
        if (param1.effectData) {
            _loc18_ = param1.effectData.getTroopsAcceleration();
            for (_loc8_ in _loc18_) {
                _loc19_ = _loc18_[_loc8_];
                _loc17_ = _loc8_;
                if (_loc2_[_loc17_] != null) {
                    _loc2_[_loc17_] = _loc2_[_loc17_] + _loc19_;
                }
                else {
                    _loc2_[_loc17_] = _loc19_;
                }
            }
        }
        return _loc2_;
    }

    private static function getMiningAcc(param1:UserGameData):Resources {
        var _loc3_:GeoSceneObject = null;
        var _loc4_:BuildingTypeInfo = null;
        var _loc5_:BuildingLevelInfo = null;
        var _loc2_:Resources = Resources.FromTUM(0, 0, 0);
        for each(_loc3_ in param1.sector.sectorScene.sceneObjects) {
            _loc4_ = _loc3_.objectType.buildingInfo;
            if (!(_loc4_ == null || _loc3_.buildingInProgress)) {
                _loc5_ = _loc3_.objectType.buildingInfo.getLevelInfo(_loc3_.getLevel());
                if (_loc5_.miningAcceleration != null) {
                    _loc2_.add(_loc5_.miningAcceleration);
                }
            }
        }
        return _loc2_;
    }

    private static function getBuildingAcc(param1:UserGameData):Number {
        var gameData:UserGameData = param1;
        var buildingAcceleration:Number = sumAcceleration(function (param1:BuildingLevelInfo):int {
            return param1.buildingAcceleration;
        }, gameData.sector);
        if (gameData.effectData != null) {
            buildingAcceleration = buildingAcceleration + gameData.effectData.getBuildingAcceleration();
        }
        if (gameData.wisdomSkillsData != null) {
            buildingAcceleration = buildingAcceleration + gameData.wisdomSkillsData.getActiveBonusPercentByType(WisdomSkillBonusType.CONSTRUCTION_ACCELERATION);
        }
        return buildingAcceleration;
    }

    private static function getResearchAcc(param1:UserGameData):Number {
        var gameData:UserGameData = param1;
        var acceleration:Number = Number(sumAcceleration(function (param1:BuildingLevelInfo):int {
            return param1.researchAcceleration;
        }, gameData.sector));
        if (gameData.artifactData != null) {
            acceleration = acceleration + gameData.artifactData.GetTechnologyResearchSpeedBonus();
        }
        if (gameData.skillData != null) {
            acceleration = acceleration + SkillManager.GetTechnologyResearchSpeedBonus(gameData);
        }
        if (gameData.effectData != null) {
            acceleration = acceleration + gameData.effectData.getResearchAcceleration();
        }
        if (gameData.wisdomSkillsData != null) {
            acceleration = acceleration + gameData.wisdomSkillsData.getActiveBonusPercentByType(WisdomSkillBonusType.RESEARCH_ACCELERATION);
        }
        return acceleration;
    }

    private static function getNumberOfAllies(param1:UserGameData):int {
        var gameData:UserGameData = param1;
        return sumAcceleration(function (param1:BuildingLevelInfo):int {
            return param1.numberOfAllies;
        }, gameData.sector);
    }

    private static function getCaravanQuantity(param1:UserGameData):int {
        return accelerationBehavior.getCaravanQuantity(param1);
    }

    private static function getCaravanCapacity(param1:UserGameData):int {
        return accelerationBehavior.getCaravanCapacity(param1);
    }

    private static function getCaravanSpeedPercent(param1:UserGameData):Number {
        return accelerationBehavior.getCaravanSpeedPercent(param1);
    }

    private static function getConsumptionBonusPercent(param1:UserGameData):Number {
        var gameData:UserGameData = param1;
        return sumAcceleration2(function (param1:BuildingLevelInfo):Number {
            return param1.consumptionBonusPercent;
        }, gameData.sector);
    }

    private static function getConsumptionBonusPercents(param1:UserGameData):Dictionary {
        var _loc3_:GeoSceneObject = null;
        var _loc4_:BuildingTypeInfo = null;
        var _loc5_:int = 0;
        var _loc6_:BuildingLevelInfo = null;
        var _loc7_:* = undefined;
        var _loc8_:* = 0;
        var _loc9_:Dictionary = null;
        var _loc10_:int = 0;
        var _loc11_:* = undefined;
        var _loc2_:Dictionary = new Dictionary();
        for each(_loc3_ in param1.sector.sectorScene.sceneObjects) {
            _loc4_ = _loc3_.objectType.buildingInfo;
            _loc5_ = _loc3_.getLevel();
            if (!(_loc4_ == null || _loc5_ == 0)) {
                _loc6_ = _loc3_.objectType.buildingInfo.getLevelInfo(_loc5_);
                if (!(_loc6_ == null || _loc6_.consumptionBonusPercentsWithType == null)) {
                    for (_loc8_ in _loc6_.consumptionBonusPercentsWithType) {
                        _loc9_ = _loc6_.consumptionBonusPercentsWithType[_loc7_];
                        _loc10_ = 0;
                        for (_loc11_ in _loc9_) {
                            _loc10_ = _loc10_ + _loc9_[_loc11_];
                        }
                        if (_loc10_ > 0) {
                            if (_loc2_[_loc8_] == null) {
                                _loc2_[_loc8_] = 0;
                            }
                            _loc2_[_loc8_] = _loc2_[_loc8_] + _loc10_;
                        }
                    }
                }
            }
        }
        return !!DictionaryUtil.isEmptyDictionary(_loc2_) ? null : _loc2_;
    }

    private static function getCurrentRepairRobotsCount(param1:UserGameData):Number {
        return param1.constructionData.currentRepariRobotsCount;
    }

    private static function sumAcceleration(param1:Function, param2:Sector):int {
        var _loc4_:GeoSceneObject = null;
        var _loc5_:BuildingTypeInfo = null;
        var _loc6_:int = 0;
        var _loc7_:BuildingLevelInfo = null;
        var _loc3_:int = 0;
        for each(_loc4_ in param2.sectorScene.sceneObjects) {
            _loc5_ = _loc4_.objectType.buildingInfo;
            _loc6_ = _loc4_.getLevel();
            if (!(_loc5_ == null || _loc6_ == 0)) {
                _loc7_ = _loc4_.objectType.buildingInfo.getLevelInfo(_loc6_);
                _loc3_ = _loc3_ + param1(_loc7_);
            }
        }
        return _loc3_;
    }

    private static function sumAcceleration2(param1:Function, param2:Sector):Number {
        var _loc4_:GeoSceneObject = null;
        var _loc5_:BuildingTypeInfo = null;
        var _loc6_:int = 0;
        var _loc7_:BuildingLevelInfo = null;
        var _loc3_:Number = 0;
        for each(_loc4_ in param2.sectorScene.sceneObjects) {
            _loc5_ = _loc4_.objectType.buildingInfo;
            _loc6_ = _loc4_.getLevel();
            if (!(_loc5_ == null || _loc6_ == 0)) {
                _loc7_ = _loc4_.objectType.buildingInfo.getLevelInfo(_loc6_);
                _loc3_ = _loc3_ + param1(_loc7_);
            }
        }
        return _loc3_;
    }

    private static function getOrdersByTypeId(param1:Array, param2:int):Array {
        var _loc4_:TroopsOrder = null;
        var _loc3_:Array = new Array();
        for each(_loc4_ in param1) {
            if (_loc4_.typeId == param2) {
                _loc3_.push(_loc4_);
            }
        }
        return _loc3_;
    }

    private static function getNextExpiredAdditionalHelper(param1:ArrayCustom, param2:Date):int {
        if (param1 == null || param1.length == 0) {
            return -1;
        }
        var _loc3_:int = 0;
        while (_loc3_ < param1.length) {
            if (param1[_loc3_] < param2) {
                return _loc3_;
            }
            _loc3_++;
        }
        return -1;
    }

    public static function fromDto(param1:*):ConstructionData {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc5_:* = undefined;
        var _loc2_:ConstructionData = new ConstructionData();
        _loc2_.buildingAcceleration = param1.b;
        _loc2_.researchAcceleration = param1.r;
        _loc2_.numberOfAllies = param1.a;
        _loc2_.caravanQuantity = param1.q;
        _loc2_.caravanCapacityPercent = param1.p;
        _loc2_.caravanCapacity = param1.c;
        _loc2_.caravanCapacityPercentBoost = param1.pb;
        _loc2_.caravanSpeedPercent = param1.x;
        _loc2_.caravanSpeed = param1.s;
        _loc2_.troopsAcceleration = new Dictionary();
        if (param1.t != null) {
            for (_loc4_ in param1.t) {
                _loc2_.troopsAcceleration[_loc4_] = param1.t[_loc4_];
            }
        }
        _loc2_.troopsQueueHoursLimit = new Dictionary();
        if (param1.j != null) {
            for (_loc5_ in param1.j) {
                _loc2_.troopsQueueHoursLimit[_loc5_] = param1.j[_loc5_];
            }
        }
        _loc2_.resourceMiningBoosts = ResourceMiningBoost.fromDtos(param1.m);
        _loc2_.resourceConsumptionBonusBoosts = ResourceConsumptionBonusBoost.fromDtos(param1.rc);
        _loc2_.resourceMiningBoostAutoRenewal = param1.mr == null ? true : Boolean(param1.mr);
        _loc2_.resourceMiningBoostAutoRenewalMoney = param1.cr == null ? true : Boolean(param1.cr);
        _loc2_.resourceMiningBoostAutoRenewalTitanite = param1.tr == null ? true : Boolean(param1.tr);
        _loc2_.resourceMiningBoostAutoRenewalUranium = param1.ur == null ? true : Boolean(param1.ur);
        _loc2_.resourceConsumptionBonusBoostAutoRenewal = param1.br == null ? true : Boolean(param1.br);
        _loc2_.buildTrooperFaster = param1.f == null ? false : Boolean(param1.f);
        _loc2_.buildDogFaster = param1.d == null ? false : Boolean(param1.d);
        _loc2_.buildReconFaster = param1.e == null ? false : Boolean(param1.e);
        _loc2_.hasDiscountForBuildingRobot = Boolean(param1.i);
        _loc2_.constructionWorkersCount = param1.w == null ? 0 : int(param1.w);
        _loc2_.consumptionBonusPercent = param1.k == null ? Number(0) : Number(param1.k);
        _loc2_.currentRepariRobotsCount = param1.y;
        _loc2_.freeTechnologiesResearched = param1.u == null ? false : Boolean(param1.u);
        for each(_loc3_ in param1.aw) {
            if (!_loc2_.additionalWorkersExpireDateTimes) {
                _loc2_.additionalWorkersExpireDateTimes = new ArrayCustom();
            }
            _loc2_.additionalWorkersExpireDateTimes.push(new Date(_loc3_));
        }
        if (param1.ar) {
            for each(_loc3_ in param1.ar) {
                if (!_loc2_.additionalResearchersExpireDateTimes) {
                    _loc2_.additionalResearchersExpireDateTimes = new ArrayCustom();
                }
                _loc2_.additionalResearchersExpireDateTimes.push(new Date(_loc3_));
            }
        }
        if (param1.ad) {
            for each(_loc3_ in param1.ad) {
                if (!_loc2_.additionalInventoryDestroyerExpireDateTimes) {
                    _loc2_.additionalInventoryDestroyerExpireDateTimes = new ArrayCustom();
                }
                _loc2_.additionalInventoryDestroyerExpireDateTimes.push(new Date(_loc3_));
            }
        }
        _loc2_.allianceBonusWindowShownToday = param1.ah;
        return _loc2_;
    }

    public function get constructionWorkersChanged():Boolean {
        return this._constructionWorkersChanged;
    }

    public function set constructionWorkersChanged(param1:Boolean):void {
        this._constructionWorkersChanged = param1;
        if (this._constructionWorkersChanged) {
            this.workersUsed = -1;
        }
    }

    public function get constructionAdditionalWorkersChanged():Boolean {
        return this._constructionAdditionalWorkersChanged;
    }

    public function set constructionAdditionalWorkersChanged(param1:Boolean):void {
        this._constructionAdditionalWorkersChanged = param1;
    }

    public function get additionalInventoryDestroyerChanged():Boolean {
        return this._additionalInventoryDestroyerChanged;
    }

    public function set additionalInventoryDestroyerChanged(param1:Boolean):void {
        this._additionalInventoryDestroyerChanged = param1;
    }

    public function get additionalResearcherChanged():Boolean {
        return this._additionalResearcherChanged;
    }

    public function set additionalResearcherChanged(param1:Boolean):void {
        this._additionalResearcherChanged = param1;
    }

    public function get additionalWorkersUsed():Boolean {
        return this.workersUsed >= this.constructionWorkersCount;
    }

    public function get availableWorkersChanged():Boolean {
        return this._availableWorkersChanged;
    }

    public function set availableWorkersChanged(param1:Boolean):void {
        this._availableWorkersChanged = param1;
        if (this._availableWorkersChanged) {
            this.workersUsed = -1;
        }
    }

    public function get resourceConsumptionChangedDirty():Boolean {
        return this._resourceConsumptionChangedDirty;
    }

    public function set resourceConsumptionChangedDirty(param1:Boolean):void {
        this._resourceConsumptionChangedDirty = param1;
    }

    public function get resourcesBoostChanged():Boolean {
        return this._resourcesBoostChanged;
    }

    public function set resourcesBoostChanged(param1:Boolean):void {
        this._resourcesBoostChanged = param1;
    }

    public function get consumptionChanged():Boolean {
        return this._consumptionChanged;
    }

    public function set consumptionChanged(param1:Boolean):void {
        this._consumptionChanged = param1;
    }

    public function dispatchEvents():void {
        if (this.consumptionChanged) {
            this.consumptionChanged = false;
            dispatchEvent(CONSUMPTION_CHANGED);
        }
        if (this._resourceConsumptionChangedDirty) {
            this._resourceConsumptionChangedDirty = false;
            dispatchEvent(RESOURCES_CONSUMPTION_CHANGED);
        }
        if (this._resourcesBoostChanged) {
            this._resourcesBoostChanged = false;
            dispatchEvent(RESOURCES_BOOST_CHANGED);
        }
        if (this.additionalInventoryDestroyerChanged) {
            this.additionalInventoryDestroyerChanged = false;
            dispatchEvent(ADDITIONAL_INVENTORY_DESTROYER_CHANGED);
        }
        if (this.additionalResearcherChanged) {
            this.additionalResearcherChanged = false;
            dispatchEvent(ADDITIONAL_RESEARCHER_CHANGED);
        }
        if (!this.constructionWorkersChanged && !this.availableWorkersChanged) {
            return;
        }
        if (this.constructionWorkersChanged) {
            this.constructionWorkersChanged = false;
            dispatchEvent(CONSTRUCTION_WORKERS_CHANGED);
        }
        if (this.constructionAdditionalWorkersChanged) {
            this.constructionAdditionalWorkersChanged = false;
            dispatchEvent(CONSTRUCTION_ADDITIONAL_WORKERS_CHANGED);
        }
        if (this.availableWorkersChanged) {
            this.availableWorkersChanged = false;
            dispatchEvent(AVAILABLE_WORKERS_CHANGED);
        }
    }

    public function initAcceleration(param1:UserGameData):void {
        if (accelerationBehavior == null) {
            accelerationBehavior = this.createTradeGateBehavior();
        }
        this.troopsAcceleration = getTroopsAcc(param1);
        this.buildingAcceleration = getBuildingAcc(param1);
        this.researchAcceleration = getResearchAcc(param1);
        this.dragonAbilitiesResearchAcceleration = this.getAbilitiesAcc(param1);
        this.bioplasmConversionAcceleration = this.getBioplasmConvesionAcc(param1);
        this.dragonHitsRefreshTimeAcceleration = this.getHitsAcc(param1);
        this.itemsPowderingAcceleration = this.getPowderingAcc(param1);
        this.itemsDustBonus = this.getDustAcc(param1);
        this.numberOfAllies = getNumberOfAllies(param1);
        this.caravanQuantity = getCaravanQuantity(param1);
        this.caravanCapacityPercent = this.getCaravanCapacityPercent(param1);
        var _loc2_:int = StaticDataManager.caravanCapacity + this.sumTechnologyAcceleration(param1);
        this.caravanCapacity = Math.ceil(_loc2_ * ((100 + this.caravanCapacityPercent) / 100));
        this.caravanSpeedPercent = getCaravanSpeedPercent(param1);
        this.caravanSpeed = StaticDataManager.caravanSpeed * ((100 + this.caravanSpeedPercent) / 100);
        this.consumptionBonusPercent = getConsumptionBonusPercent(param1);
        this.consumptionBonusPercents = getConsumptionBonusPercents(param1);
        this.currentRepariRobotsCount = getCurrentRepairRobotsCount(param1);
        this.updateSectorDefenceBonus(param1);
    }

    private function sumTechnologyAcceleration(param1:UserGameData):int {
        return !!GameType.isNords ? int(accelerationBehavior.getCaravanCapacity(param1)) : 0;
    }

    private function createTradeGateBehavior():AccelerationBehaviorStandard {
        if (GameType.isNords) {
            return new AccelerationBehaviorTechnology();
        }
        return new AccelerationBehaviorStandard();
    }

    public function validateCaravans(param1:User, param2:TradingPayload):Boolean {
        return this.getFreeCaravansCount(param1) >= this.getCaravanUsage(param2);
    }

    public function validateCaravans2(param1:User, param2:TradingOffer):Boolean {
        return this.getFreeCaravansCount(param1) >= this.getCaravanUsage2(param2);
    }

    public function getFreeCaravansCount(param1:User):int {
        var _loc4_:TradingOffer = null;
        var _loc5_:Number = NaN;
        var _loc6_:Unit = null;
        var _loc2_:int = this.caravanQuantity;
        if (_loc2_ == 0) {
            return 0;
        }
        var _loc3_:int = 0;
        for each(_loc4_ in param1.gameData.tradingCenter.offers) {
            _loc3_ = _loc3_ + _loc4_.offerInfo.numberOfCaravans;
        }
        _loc5_ = param1.id;
        for each(_loc6_ in param1.gameData.worldData.units) {
            if (_loc6_.OwnerUserId == _loc5_ && _loc6_.tradingPayload != null) {
                _loc3_ = _loc3_ + _loc6_.tradingPayload.numberOfCaravans;
            }
        }
        return _loc2_ - _loc3_;
    }

    public function getCaravanUsage(param1:TradingPayload):int {
        if (param1.drawingPart != null) {
            return 1;
        }
        if (param1.resources != null) {
            return this.getCaravanUsage3(param1.resources);
        }
        return 0;
    }

    public function getCaravanUsage2(param1:TradingOffer):int {
        if (param1.offerInfo.drawingPart != null) {
            return 1;
        }
        if (param1.offerInfo.resources != null) {
            return this.getCaravanUsage3(param1.offerInfo.resources);
        }
        return 0;
    }

    public function getCaravanUsage3(param1:Resources):int {
        return this.getCaravanUsage4(param1.getAny());
    }

    public function getCaravanUsage4(param1:Number):int {
        if (param1 == 0) {
            return 0;
        }
        var _loc2_:int = Math.ceil(param1 / this.caravanCapacity);
        return _loc2_;
    }

    public function setConstructionPeriod(param1:INConstructible, param2:Date):void {
        if (param1.constructionObjInfo == null) {
            param1.constructionObjInfo = new ConstructionObjInfo();
        }
        param1.constructionObjInfo.constructionStartTime = param2;
        param1.constructionObjInfo.constructionFinishTime = this.getConstructionFinishedTime(param1);
    }

    public function getConstructionTicks(param1:INConstructible):Number {
        var _loc2_:Number = this.getDefaultTicks(param1);
        if (_loc2_ > 0) {
            if (GameType.isNords && param1.objectType.technologyInfo && param1.constructionObjInfo.level == 0) {
                _loc2_ = _loc2_ * 1000;
            }
            else {
                _loc2_ = this.getConstructionTicksWithBonus(param1, _loc2_);
            }
        }
        return _loc2_;
    }

    public function getConstructionTicksWithoutBonuses(param1:INConstructible):Number {
        var _loc2_:int = this.getDefaultTicks(param1);
        if (_loc2_ > 0) {
            if (GameType.isNords && param1.objectType.technologyInfo && param1.constructionObjInfo.level == 0) {
                _loc2_ = _loc2_ * 1000;
            }
        }
        return _loc2_;
    }

    public function getConstructionTicksWithoutEffects(param1:INConstructible):Number {
        var _loc2_:Number = this.getDefaultTicks(param1);
        if (_loc2_ > 0) {
            if (GameType.isNords && param1.objectType.technologyInfo && param1.constructionObjInfo.level == 0) {
                _loc2_ = _loc2_ * 1000;
            }
            else {
                _loc2_ = this.getConstructionTicksWithoutEffectsBonus(param1, _loc2_);
            }
        }
        return _loc2_;
    }

    private function getConstructionTicksWithBonus(param1:INConstructible, param2:Number):Number {
        var _loc3_:Number = this.getAcceleration(param1);
        return this.getConstructionTicksWithBonusAcceleration(param2, _loc3_);
    }

    private function getConstructionTicksWithoutEffectsBonus(param1:INConstructible, param2:Number):Number {
        var _loc3_:Number = this.getAcceleration(param1);
        if (_loc3_ > 0) {
            _loc3_ = _loc3_ - this.getEffectsBonuses(param1);
        }
        return this.getConstructionTicksWithBonusAcceleration(param2, _loc3_);
    }

    private function getConstructionTicksWithBonusAcceleration(param1:Number, param2:Number):Number {
        var _loc4_:Number = NaN;
        if (!StaticDataManager.bonusReducesTime) {
            _loc4_ = param2 / 100 + 1;
            return param1 * 1000 / _loc4_;
        }
        var _loc3_:Number = (100 - param2) / 100;
        return param1 * 1000 * _loc3_;
    }

    public function getSectorDefenceBonus():Number {
        var _loc1_:Number = UserManager.user.gameData.sector.defensivePoints;
        var _loc2_:Number = _loc1_ + _loc1_ * (this.extraSectorDefenceBonus / 100);
        var _loc3_:Number = !!UserManager.user.gameData.sectorSkinsData ? Number(UserManager.user.gameData.sectorSkinsData.getCitySkinDefencePower() * 100) : Number(0);
        var _loc4_:Number = UserManager.user.gameData.getDefenceBonusPoints();
        var _loc5_:Number = _loc2_ + _loc4_ + _loc3_;
        var _loc6_:Number = _loc5_ + _loc5_ * (this.extraSectorDefenceGlobalBonus / 100);
        return _loc6_;
    }

    public function getBioplasmConversionTimeSecond(param1:Number):Number {
        return this.getConstructionTicksWithBonusAcceleration(param1, this.bioplasmConversionAcceleration) / 1000;
    }

    public function getDragonAbilitiesResearchAcceleration(param1:Number):Number {
        return this.getConstructionTicksWithBonusAcceleration(param1, this.dragonAbilitiesResearchAcceleration) / 1000;
    }

    public function getItemsPowderingTimeSeconds(param1:Number):Number {
        return this.getConstructionTicksWithBonusAcceleration(param1, this.itemsPowderingAcceleration) / 1000;
    }

    public function getItemsDustCount(param1:Number):int {
        var _loc2_:Number = (100 + this.itemsDustBonus) / 100;
        return param1 * _loc2_;
    }

    private function getConstructionFinishedTime(param1:INConstructible):Date {
        if (param1.constructionObjInfo == null || param1.constructionObjInfo.constructionStartTime == null) {
            return null;
        }
        var _loc2_:SaleableTypeInfo = param1.objectType.saleableInfo;
        var _loc3_:int = param1.constructionObjInfo.level;
        if (_loc3_ >= _loc2_.levelsCount) {
            return null;
        }
        var _loc4_:Number = this.getConstructionTicks(param1);
        var _loc5_:Date = new Date(param1.constructionObjInfo.constructionStartTime.time + _loc4_);
        return Normalizer.normalizeTime(_loc5_);
    }

    public function supposedConstructionFinishedTime(param1:INConstructible):Date {
        var _loc3_:int = 0;
        var _loc4_:Number = NaN;
        var _loc5_:Date = null;
        var _loc6_:Date = null;
        if (param1.constructionObjInfo == null) {
            return null;
        }
        var _loc2_:SaleableTypeInfo = param1.objectType.saleableInfo;
        if (_loc2_) {
            _loc3_ = param1.constructionObjInfo.level;
            if (_loc3_ >= _loc2_.levelsCount) {
                return null;
            }
            _loc4_ = this.getConstructionTicks(param1);
            _loc5_ = ServerTimeManager.serverTimeNow;
            _loc6_ = new Date(_loc5_.time + _loc4_);
            return Normalizer.normalizeTime(_loc6_);
        }
        return null;
    }

    public function updateAcceleration(param1:UserGameData, param2:Date):void {
        var _loc3_:Number = getBuildingAcc(param1);
        var _loc4_:Number = getResearchAcc(param1);
        var _loc5_:Dictionary = getTroopsAcc(param1);
        var _loc6_:Number = this.getAbilitiesAcc(param1);
        var _loc7_:Number = this.getBioplasmConvesionAcc(param1);
        var _loc8_:Number = this.getHitsAcc(param1);
        var _loc9_:Number = this.getPowderingAcc(param1);
        this.updateBuildings(param1, _loc3_, param2);
        this.updateTechnologies(param1, _loc4_, param2);
        this.updateTroopsOrders(param1, _loc5_, param2);
        this.updateAbilities(param1, _loc6_, param2);
        this.updateBioplasmConversion(param1, _loc7_, param2);
        this.updateDragonHits(param1, _loc8_, param2);
        this.updatePowderingSpeed(param1, _loc9_, param2);
        this.buildingAcceleration = _loc3_;
        this.researchAcceleration = _loc4_;
        this.troopsAcceleration = _loc5_;
        this.dragonAbilitiesResearchAcceleration = _loc6_;
        this.bioplasmConversionAcceleration = _loc7_;
        this.dragonHitsRefreshTimeAcceleration = _loc8_;
        this.itemsPowderingAcceleration = _loc9_;
        this.numberOfAllies = getNumberOfAllies(param1);
        var _loc10_:Boolean = false;
        var _loc11_:int = this.caravanQuantity;
        this.caravanQuantity = getCaravanQuantity(param1);
        if (_loc11_ != this.caravanQuantity) {
            _loc10_ = true;
        }
        this.caravanCapacityPercent = this.getCaravanCapacityPercent(param1);
        var _loc12_:Dictionary = getTroopsQueueHoursLimit(param1);
        this.troopsQueueHoursLimit = _loc12_ == null ? this.troopsQueueHoursLimit : _loc12_;
        var _loc13_:Number = this.caravanCapacity;
        this.caravanCapacity = Math.round(StaticDataManager.caravanCapacity * ((100 + this.caravanCapacityPercent) / 100));
        if (_loc13_ != this.caravanCapacity) {
            _loc10_ = true;
        }
        this.caravanSpeedPercent = getCaravanSpeedPercent(param1);
        var _loc14_:Number = this.caravanSpeed;
        this.caravanSpeed = StaticDataManager.caravanSpeed * ((100 + this.caravanSpeedPercent) / 100);
        if (_loc14_ != this.caravanSpeed) {
            _loc10_ = true;
        }
        if (_loc10_) {
            param1.raiseCaravanLimitsChanged();
        }
        this.consumptionBonusPercent = getConsumptionBonusPercent(param1);
        this.consumptionBonusPercents = getConsumptionBonusPercents(param1);
        this.currentRepariRobotsCount = getCurrentRepairRobotsCount(param1);
        this.itemsDustBonus = this.getDustAcc(param1);
        this.updateSectorDefenceBonus(param1);
    }

    private function updateBuildings(param1:UserGameData, param2:Number, param3:Date):void {
        var _loc5_:GeoSceneObject = null;
        if (param2 == this.buildingAcceleration) {
            return;
        }
        var _loc4_:Number = (100 + param2) / (100 + this.buildingAcceleration);
        for each(_loc5_ in param1.sector.sectorScene.sceneObjects) {
            if (_loc5_.buildingInProgress) {
                correctFinishTime(_loc5_, _loc4_, param3);
            }
        }
    }

    private function updateTechnologies(param1:UserGameData, param2:Number, param3:Date):void {
        var _loc5_:GeoSceneObject = null;
        if (param2 == this.researchAcceleration) {
            return;
        }
        var _loc4_:Number = (100 + param2) / (100 + this.researchAcceleration);
        for each(_loc5_ in param1.technologyCenter.technologies) {
            if (_loc5_.buildingInProgress) {
                correctFinishTime(_loc5_, _loc4_, param3);
            }
        }
    }

    private function updateAbilities(param1:UserGameData, param2:Number, param3:Date):void {
        var _loc5_:Ability = null;
        var _loc6_:Number = NaN;
        if (param2 == this.dragonAbilitiesResearchAcceleration) {
            return;
        }
        var _loc4_:Number = (100 + param2) / (100 + this.dragonAbilitiesResearchAcceleration);
        for each(_loc5_ in param1.dragonData.abilities) {
            if (_loc5_.inProgress) {
                _loc6_ = _loc5_.constructionObjInfo.constructionFinishTime.time;
                _loc5_.constructionObjInfo.constructionFinishTime = getCorrectFinishTime(_loc6_, _loc4_, param3);
            }
        }
    }

    private function updateBioplasmConversion(param1:UserGameData, param2:Number, param3:Date):void {
        if (param2 == this.bioplasmConversionAcceleration) {
            return;
        }
        var _loc4_:Number = (100 + param2) / (100 + this.bioplasmConversionAcceleration);
        var _loc5_:ResourcesConversionJob = UserResourcesConversionData.getActiveJobByType(ResourceTypeId.BIOCHIPS);
        if (_loc5_) {
            _loc5_.conversionFinishTime = getCorrectFinishTime(_loc5_.conversionFinishTime.time, _loc4_, param3);
        }
    }

    private function updateDragonHits(param1:UserGameData, param2:Number, param3:Date):void {
        if (param2 == this.dragonHitsRefreshTimeAcceleration || param1.dragonData.hitsRefreshTime == null) {
            return;
        }
        var _loc4_:Number = (100 + param2) / (100 + this.dragonHitsRefreshTimeAcceleration);
        var _loc5_:Number = param1.dragonData.hitsRefreshTime.time;
        param1.dragonData.hitsRefreshTime = getCorrectFinishTime(_loc5_, _loc4_, param3);
    }

    private function updateTroopsOrders(param1:UserGameData, param2:Dictionary, param3:Date):void {
        var _loc6_:* = undefined;
        var _loc7_:Number = NaN;
        var _loc8_:Number = NaN;
        var _loc9_:TroopsOrder = null;
        var _loc4_:Dictionary = param1.constructionData.troopsAcceleration;
        var _loc5_:Array = param1.troopsData.troopsFactory.getOrdersInProgress();
        for (_loc6_ in param2) {
            _loc7_ = _loc4_[_loc6_];
            _loc8_ = (100 + param2[_loc6_]) / (100 + _loc7_);
            for each(_loc9_ in getOrdersByTypeId(_loc5_, _loc6_)) {
                correctFinishTime(_loc9_, _loc8_, param3);
            }
        }
    }

    private function updatePowderingSpeed(param1:UserGameData, param2:Number, param3:Date):void {
        var _loc5_:GeoSceneObject = null;
        var _loc6_:Number = NaN;
        if (param2 == this.itemsPowderingAcceleration || param1.inventoryData == null) {
            return;
        }
        var _loc4_:Number = (100 + param2) / (100 + this.itemsPowderingAcceleration);
        for each(_loc5_ in param1.inventoryData.inventoryItemsById) {
            if (_loc5_.buildingInProgress) {
                _loc6_ = _loc5_.constructionInfo.constructionFinishTime.time;
                _loc5_.constructionInfo.constructionFinishTime = getCorrectFinishTime(_loc6_, _loc4_, param3);
            }
        }
        param1.inventoryData.inventoryItemsBySlotId = param1.inventoryData.updateInventoryItemsBySlotId();
    }

    private function getAcceleration(param1:INConstructible):Number {
        var _loc2_:Number = 0;
        var _loc3_:GeoSceneObjectType = param1.objectType;
        if (_loc3_.buildingInfo != null) {
            _loc2_ = this.buildingAcceleration;
        }
        else if (_loc3_.troopsInfo != null) {
            _loc2_ = this.troopsAcceleration[_loc3_.id];
        }
        else if (_loc3_.technologyInfo != null) {
            _loc2_ = this.researchAcceleration;
        }
        else if (_loc3_.saleableInfo != null) {
            _loc2_ = this.itemsPowderingAcceleration;
        }
        return _loc2_;
    }

    private function getEffectsBonuses(param1:INConstructible):Number {
        var _loc2_:Number = 0;
        var _loc3_:GeoSceneObjectType = param1.objectType;
        var _loc4_:EffectData = UserManager.user.gameData.effectData;
        if (_loc4_ != null) {
            if (_loc3_.buildingInfo != null) {
                _loc2_ = _loc4_.getBuildingAcceleration();
            }
            else if (_loc3_.troopsInfo != null) {
                _loc2_ = _loc4_.getTroopsAcceleration()[_loc3_.id];
            }
            else if (_loc3_.technologyInfo != null) {
                _loc2_ = _loc4_.getResearchAcceleration();
            }
        }
        return !!isNaN(_loc2_) ? Number(0) : Number(_loc2_);
    }

    private function getAbilitiesAcc(param1:UserGameData):Number {
        var _loc2_:Number = 0;
        if (param1.effectData) {
            _loc2_ = _loc2_ + param1.effectData.getDragonAbilitiesResearchAcceleration();
        }
        return _loc2_;
    }

    private function getBioplasmConvesionAcc(param1:UserGameData):Number {
        var _loc2_:Number = 0;
        if (param1.effectData) {
            _loc2_ = _loc2_ + param1.effectData.getBioplasmConversionAcceleration();
        }
        return _loc2_;
    }

    private function getHitsAcc(param1:UserGameData):Number {
        var _loc2_:Number = 0;
        if (param1.effectData) {
            _loc2_ = _loc2_ + param1.effectData.getDragonHitRefreshTimeAcceleration();
        }
        return _loc2_;
    }

    private function getPowderingAcc(param1:UserGameData):Number {
        var _loc2_:Number = 0;
        if (param1.effectData) {
            _loc2_ = _loc2_ + param1.effectData.getItemPowderingAcceleration();
        }
        return _loc2_;
    }

    private function getDustAcc(param1:UserGameData):Number {
        var _loc2_:Number = 0;
        if (param1.effectData) {
            _loc2_ = _loc2_ + param1.effectData.getItemsDustBonus();
        }
        return _loc2_;
    }

    private function updateSectorDefenceBonus(param1:UserGameData):void {
        this.extraSectorDefenceBonus = 0;
        this.extraSectorDefenceGlobalBonus = 0;
        if (param1.effectData) {
            this.extraSectorDefenceBonus = this.extraSectorDefenceBonus + param1.effectData.getSectorDefenceBonus();
            this.extraSectorDefenceGlobalBonus = this.extraSectorDefenceGlobalBonus + param1.effectData.getSectorDefenceGlobalBonus();
        }
    }

    private function getCaravanCapacityPercent(param1:UserGameData):int {
        return accelerationBehavior.getCaravanCapacityPercent(param1);
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc3_:* = this.getNextFinishedResourceMiningBoost(param2);
        var _loc4_:ResourceMiningBoost = _loc3_.boost;
        var _loc5_:* = this.getNextFinishedResourceConsumptionBonusBoost(_loc3_.time);
        var _loc6_:ResourceConsumptionBonusBoost = _loc5_.boost;
        var _loc7_:int = getNextExpiredAdditionalHelper(this.additionalWorkersExpireDateTimes, _loc3_.time);
        var _loc8_:int = getNextExpiredAdditionalHelper(this.additionalResearchersExpireDateTimes, _loc3_.time);
        var _loc9_:int = getNextExpiredAdditionalHelper(this.additionalInventoryDestroyerExpireDateTimes, _loc3_.time);
        if (_loc9_ != -1) {
            return new NEventAdditionalInventoryDestroyerExpired(_loc9_, param2);
        }
        if (_loc8_ != -1) {
            return new NEventAdditionalResearcherExpired(_loc7_, param2);
        }
        if (_loc7_ != -1) {
            return new NEventAdditionalWorkerExpired(_loc7_, param2);
        }
        if (_loc6_ != null) {
            param2 = _loc5_.time;
            return new NEventConsumptionBonusBoostFinished(_loc6_, param2);
        }
        if (_loc4_ != null) {
            param2 = _loc3_.time;
            return new NEventBoostFinished(_loc4_, param2);
        }
        return null;
    }

    private function getNextFinishedResourceMiningBoost(param1:Date):* {
        var _loc4_:ResourceMiningBoost = null;
        var _loc5_:Date = null;
        var _loc2_:ResourceMiningBoost = null;
        var _loc3_:Date = new Date(param1);
        for each(_loc4_ in this.resourceMiningBoosts) {
            _loc5_ = _loc4_.until;
            if (!(_loc5_ == null || _loc5_ > param1)) {
                _loc2_ = _loc4_;
                param1 = _loc5_;
            }
        }
        return {
            "boost": _loc2_,
            "time": param1
        };
    }

    private function getNextFinishedResourceConsumptionBonusBoost(param1:Date):* {
        var _loc4_:ResourceConsumptionBonusBoost = null;
        var _loc5_:Date = null;
        var _loc2_:ResourceConsumptionBonusBoost = null;
        var _loc3_:Date = new Date(param1);
        for each(_loc4_ in this.resourceConsumptionBonusBoosts) {
            _loc5_ = _loc4_.until;
            if (!(_loc5_ == null || _loc5_ > param1)) {
                _loc2_ = _loc4_;
                param1 = _loc5_;
            }
        }
        return {
            "boost": _loc2_,
            "time": param1
        };
    }

    public function addResourceMiningBoost(param1:Date, param2:ResourceMiningBoostType):ResourceMiningBoost {
        if (this.getResourceBoost(param2.boostTypeId) != null) {
            throw new Error("Boost is already added");
        }
        var _loc3_:ResourceMiningBoost = new ResourceMiningBoost();
        _loc3_.typeId = param2.boostTypeId;
        _loc3_.boostPercentage = param2.percentage;
        _loc3_.until = param1;
        this.resourceMiningBoosts.addItem(_loc3_);
        return _loc3_;
    }

    public function addOrProlongResourceMiningBoost(param1:Number, param2:ResourceMiningBoostType, param3:int):ResourceMiningBoost {
        var _loc4_:ResourceMiningBoost = this.getResourceBoost(param2.boostTypeId);
        if (_loc4_ == null) {
            _loc4_ = new ResourceMiningBoost();
            this.resourceMiningBoosts.addItem(_loc4_);
        }
        if (_loc4_.boostPercentage == param3) {
            return this.prolongResourceMiningBoost(param1, param2);
        }
        _loc4_.typeId = param2.boostTypeId;
        _loc4_.boostPercentage = param3;
        _loc4_.until = new Date(ServerTimeManager.serverTimeNow.time + param1);
        this._resourcesBoostChanged = true;
        return _loc4_;
    }

    public function prolongResourceMiningBoost(param1:Number, param2:ResourceMiningBoostType):ResourceMiningBoost {
        var _loc3_:ResourceMiningBoost = this.getResourceBoost(param2.boostTypeId);
        var _loc4_:Date = new Date(_loc3_.until.time + param1);
        _loc3_.until = _loc4_;
        this._resourcesBoostChanged = true;
        return _loc3_;
    }

    public function addOrProlongBoostMoneyConsumption(param1:Number, param2:int):ResourceConsumptionBonusBoost {
        var _loc3_:ResourceConsumptionBonusBoost = this.getActiveConsumptionBonusBoost();
        if (_loc3_ == null) {
            _loc3_ = new ResourceConsumptionBonusBoost();
            this.resourceConsumptionBonusBoosts.addItem(_loc3_);
        }
        if (_loc3_.boostPercentage == param2) {
            return this.prolongBoostMoneyConsumption(param1);
        }
        _loc3_.boostPercentage = param2;
        _loc3_.until = new Date(ServerTimeManager.serverTimeNow.time + param1);
        this.resourceConsumptionChangedDirty = true;
        return _loc3_;
    }

    public function prolongBoostMoneyConsumption(param1:Number):ResourceConsumptionBonusBoost {
        var _loc2_:ResourceConsumptionBonusBoost = this.getActiveConsumptionBonusBoost();
        var _loc3_:Date = new Date(_loc2_.until.time + param1);
        _loc2_.until = _loc3_;
        this.resourceConsumptionChangedDirty = true;
        return _loc2_;
    }

    public function addResourceConsumptionBonusBoost(param1:Date, param2:ResourceConsumptionBonusBoostType):ResourceConsumptionBonusBoost {
        if (this.getResourceBoost(param2.boostTypeId) != null) {
            throw new Error("Boost is already added");
        }
        var _loc3_:ResourceConsumptionBonusBoost = new ResourceConsumptionBonusBoost();
        _loc3_.typeId = param2.boostTypeId;
        _loc3_.boostPercentage = param2.percentage;
        _loc3_.until = param1;
        this.resourceConsumptionBonusBoosts.addItem(_loc3_);
        return _loc3_;
    }

    public function removeResourceConsumptionBonusBoost():void {
        this.resourceConsumptionBonusBoosts.removeAll();
    }

    public function getResourceBoost(param1:int):ResourceMiningBoost {
        var _loc4_:ResourceMiningBoost = null;
        var _loc2_:int = this.resourceMiningBoosts.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = this.resourceMiningBoosts[_loc3_];
            if (_loc4_.typeId == param1) {
                return _loc4_;
            }
            _loc3_++;
        }
        return null;
    }

    public function getTotalResourceBoostTimeByType(param1:int):Number {
        var _loc2_:Number = NaN;
        if (this.getResourceBoost(param1) != null) {
            _loc2_ = DateUtil.getCountdownUntil(ServerTimeManager.serverTimeNow, this.getResourceBoost(param1).until).toSeconds();
        }
        else {
            _loc2_ = 0;
        }
        return _loc2_;
    }

    public function getResourceMiningBoost():Resources {
        var _loc3_:ResourceMiningBoost = null;
        var _loc4_:Number = NaN;
        var _loc1_:Resources = StaticDataManager.freeTechnologiesResearchedMiningBonusCoeff;
        var _loc2_:Resources = this.resourceMiningBoosts.length > 0 || this.freeTechnologiesResearched && _loc1_ ? new Resources() : null;
        while (true) {
            loop0:
                    for each(_loc3_ in this.resourceMiningBoosts) {
                        _loc4_ = _loc3_.boostPercentage / 100;
                        switch (_loc3_.typeId) {
                            case BoostTypeId.RESOURCES_TITANITE:
                                _loc2_.titanite = _loc2_.titanite + _loc4_;
                                continue;
                            case BoostTypeId.RESOURCES_URANIUM:
                                _loc2_.uranium = _loc2_.uranium + _loc4_;
                                continue;
                            case BoostTypeId.RESOURCES_MONEY:
                                _loc2_.money = _loc2_.money + _loc4_;
                                continue;
                            default:
                                break loop0;
                        }
                    }
            if (this.freeTechnologiesResearched && _loc1_) {
                _loc2_.add(_loc1_);
            }
            return _loc2_;
        }
        throw new Error("BoostTypeId is out of range");
    }

    public function getActiveConsumptionBonusBoost(param1:int = 1):ResourceConsumptionBonusBoost {
        var boostSource:int = param1;
        return query(this.resourceConsumptionBonusBoosts).firstOrDefault(function (param1:ResourceConsumptionBonusBoost):Boolean {
            return param1.source == -1 || (boostSource & param1.source) == param1.source;
        });
    }

    public function getActiveConsumptionBonusBoosts(param1:int):Array {
        var boostSource:int = param1;
        return query(this.resourceConsumptionBonusBoosts).where(function (param1:ResourceConsumptionBonusBoost):Boolean {
            return param1.source == -1 || (boostSource & param1.source) == param1.source;
        }).toArray();
    }

    public function getGroupQueueTime(param1:int):int {
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        var _loc2_:Array = UserManager.user.gameData.troopsData.troopsFactory.getOrders(param1);
        var _loc3_:Date = ServerTimeManager.serverTimeNow;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        while (_loc5_ < _loc2_.length) {
            _loc6_ = _loc2_[_loc5_].pendingCount;
            if (_loc2_[_loc5_].constructionInfo.constructionFinishTime != null) {
                _loc6_--;
                _loc4_ = _loc4_ + (_loc2_[_loc5_].constructionInfo.constructionFinishTime.time - _loc3_.time) / 1000;
            }
            _loc7_ = UserManager.user.gameData.constructionData.getConstructionTicks(_loc2_[_loc5_]) / 1000 * _loc6_;
            _loc4_ = _loc4_ + _loc7_;
            _loc5_++;
        }
        return _loc4_;
    }

    public function getUnitConstractionTime(param1:GeoSceneObject, param2:int):int {
        var _loc3_:int = UserManager.user.gameData.constructionData.getConstructionTicks(param1);
        return _loc3_ / 1000 * param2;
    }

    public function getGroupQueueLimit(param1:int):int {
        var _loc2_:* = undefined;
        for each(_loc2_ in this.troopsQueueHoursLimit) {
            if (_loc2_ == param1) {
                return _loc2_;
            }
        }
        return -1;
    }

    private function getDefaultTicks(param1:INConstructible):Number {
        var _loc2_:SaleableTypeInfo = param1.objectType.saleableInfo;
        var _loc3_:int = param1.constructionObjInfo.level;
        if (!_loc2_ || _loc3_ >= _loc2_.levelsCount) {
            return 0;
        }
        var _loc4_:int = 0;
        if ((param1.objectType.id == TroopsTypeId.AirUnit1 || param1.objectType.id == TroopsTypeId.AirUnit1Gold) && this.buildReconFaster) {
            _loc4_ = !!GameType.isMilitary ? 10 : 300;
        }
        else if ((param1.objectType.id == TroopsTypeId.InfantryUnit1 || param1.objectType.id == TroopsTypeId.InfantryUnit1Gold) && this.buildTrooperFaster || (param1.objectType.id == TroopsTypeId.InfantryUnit2 || param1.objectType.id == TroopsTypeId.InfantryUnit2Gold) && this.buildDogFaster) {
            _loc4_ = !!GameType.isTotalDomination ? 10 : !!GameType.isNords ? 6 : 15;
        }
        else {
            _loc4_ = _loc2_.getLevelInfo(_loc3_ + 1).constructionSeconds;
        }
        var _loc5_:Boolean = GameType.isTotalDomination || GameType.isMilitary;
        if (_loc5_ && (param1.objectType.id == BuildingTypeId.Bank || param1.objectType.id == BuildingTypeId.Warehouse) && UserManager.user.gameData.sector.getBuildingsCount(param1.objectType.id) > 1) {
            _loc4_ = _loc4_ * StaticDataManager.bankAndWarehousePriceAndTimeCoef;
        }
        return _loc4_;
    }
}
}
