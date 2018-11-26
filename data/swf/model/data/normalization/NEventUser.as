package model.data.normalization {
import common.ArrayCustom;
import common.DateUtil;

import configs.Global;

import flash.utils.Dictionary;

import model.data.ResourceTypeId;
import model.data.Resources;
import model.data.User;
import model.data.UserGameData;
import model.data.effects.EffectData;
import model.data.effects.EffectSource;
import model.data.effects.EffectTypeId;
import model.data.locations.allianceCity.flags.enumeration.AllianceEffectBonusType;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.objects.info.BuildingObjInfo;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.SaleableLevelInfo;
import model.data.scenes.types.info.TroopsLevelInfo;
import model.data.scenes.types.info.TroopsTypeId;
import model.data.units.Unit;
import model.data.units.payloads.SupportTroops;
import model.data.users.UserAccount;
import model.data.users.acceleration.ConstructionData;
import model.data.users.acceleration.ResourceConsumptionBonusBoost;
import model.data.users.acceleration.enums.BoostSource;
import model.data.users.buildings.LocalStorageBuilding;
import model.data.users.buildings.Sector;
import model.data.users.troops.Troops;
import model.data.users.troops.TroopsOrderId;
import model.data.wisdomSkills.UserWisdomSkillsData;
import model.data.wisdomSkills.enums.WisdomSkillBonusType;
import model.logic.AllianceManager;
import model.logic.StaticDataManager;
import model.logic.UserStatsManager;
import model.logic.flags.BuffDebuffCalculate;
import model.logic.occupation.OccupationManager;
import model.logic.skills.SkillManager;
import model.logic.vip.VipManager;
import model.modules.allianceCity.logic.AllianceCityManager;

public class NEventUser implements INEvent {

    private static const MinAccountResourcesLimit:Resources = new Resources(int.MIN_VALUE, Number.MIN_VALUE, Number.MIN_VALUE, Number.MIN_VALUE, Number.MIN_VALUE);


    private var _time:Date;

    public function NEventUser(param1:Date) {
        super();
        this._time = param1;
    }

    private static function getTroopsSaleableLevelInfo(param1:GeoSceneObjectType):SaleableLevelInfo {
        var _loc2_:int = 0;
        if (param1.saleableInfo == null && param1.troopBaseParameters.antigen == 0) {
            _loc2_ = TroopsTypeId.ToRegular(param1.id);
            return StaticDataManager.getObjectType(_loc2_).saleableInfo.getLevelInfo(1);
        }
        return param1.saleableInfo.getLevelInfo(1);
    }

    public static function calculateSectorResources(param1:User, param2:Sector, param3:Date, param4:Boolean = false):* {
        var _loc12_:GeoSceneObject = null;
        var _loc13_:Resources = null;
        var _loc14_:Resources = null;
        var _loc15_:Array = null;
        var _loc16_:BuildingInfos = null;
        var _loc19_:* = undefined;
        var _loc20_:Resources = null;
        var _loc21_:Resources = null;
        var _loc22_:Resources = null;
        var _loc23_:Resources = null;
        var _loc24_:Resources = null;
        var _loc25_:LocalStorageBuilding = null;
        var _loc26_:Number = NaN;
        var _loc27_:Number = NaN;
        var _loc5_:Resources = getAdditionalAcceleration(param1);
        var _loc6_:Number = getMiningDegradationKoeff(param1, param3);
        var _loc7_:* = OccupationManager.getMiningCoefficient(param1);
        var _loc8_:Vector.<GeoSceneObject> = param2.getActiveBuildings();
        var _loc9_:Vector.<BuildingInfos> = new Vector.<BuildingInfos>();
        var _loc10_:Resources = new Resources();
        var _loc11_:Resources = new Resources();
        for each(_loc12_ in _loc8_) {
            _loc9_[_loc9_.length] = new BuildingInfos(_loc12_, _loc12_.getBuildingLevelInfo());
        }
        _loc13_ = new Resources();
        _loc14_ = new Resources(1, 1, 1, 1);
        _loc15_ = !param4 ? null : [];
        for each(_loc16_ in _loc9_) {
            if (!(_loc16_.building.buildingInfo != null && _loc16_.building.buildingInfo.broken)) {
                _loc20_ = _loc16_.info.miningAcceleration;
                if (_loc20_ != null) {
                    _loc14_.add(_loc20_);
                }
                _loc21_ = _loc16_.info.storageLimit;
                if (_loc21_ != null) {
                    _loc13_.add(_loc21_);
                }
            }
        }
        if (_loc5_) {
            _loc22_ = new Resources();
            _loc22_.titanite = 1 + _loc5_.titanite;
            _loc22_.uranium = 1 + _loc5_.uranium;
            _loc22_.money = 1 + _loc5_.money;
            _loc14_.accelerate(_loc22_);
        }
        var _loc17_:Resources = new Resources();
        var _loc18_:Resources = new Resources();
        for each(_loc19_ in _loc9_) {
            _loc23_ = _loc19_.info.resources;
            if (_loc23_ != null) {
                _loc23_ = _loc23_.clone();
                _loc23_ = Resources.accelerate(_loc23_, _loc14_);
                _loc10_.add(getConsumptionParts(_loc23_));
                if (!_loc23_.isNegative()) {
                    if (_loc7_.coeff != 1) {
                        if (_loc7_.typeId == ResourceTypeId.URANIUM) {
                            _loc23_.uranium = _loc23_.uranium * _loc7_.coeff;
                        }
                        else if (_loc7_.typeId == ResourceTypeId.TITANITE) {
                            _loc23_.titanite = _loc23_.titanite * _loc7_.coeff;
                        }
                    }
                    _loc23_.uranium = _loc23_.uranium * _loc6_;
                    _loc23_.titanite = _loc23_.titanite * _loc6_;
                }
                _loc24_ = getMiningParts(_loc23_);
                _loc11_.add(_loc24_);
                _loc17_.add(_loc23_);
                if (param4 && _loc19_.info.localStorageLimit != null) {
                    _loc25_ = new LocalStorageBuilding();
                    _loc25_.building = _loc19_.building;
                    _loc25_.miningPerHour = Resources.scale(_loc24_, Global.serverSettings.localStorage.localStorageFactor);
                    _loc25_.limit = _loc19_.info.localStorageLimit;
                    _loc15_.push(_loc25_);
                    _loc24_.scale(1 - Global.serverSettings.localStorage.localStorageFactor);
                    _loc23_.threshold(_loc24_);
                }
                _loc18_.add(_loc23_);
            }
        }
        if (_loc6_ == 0.25) {
            if (_loc11_.uranium > 200) {
                _loc26_ = _loc11_.uranium - 200;
                _loc11_.uranium = 200;
                _loc17_.uranium = _loc17_.uranium - _loc26_;
            }
            if (_loc11_.titanite > 200) {
                _loc27_ = _loc11_.titanite - 200;
                _loc11_.titanite = 200;
                _loc17_.titanite = _loc17_.titanite - _loc27_;
            }
        }
        return {
            "perHour": _loc17_,
            "limit": _loc13_,
            "buildingConsumption": _loc10_,
            "miningPerHour": _loc11_,
            "realPerHour": _loc18_,
            "localStorageBuildings": _loc15_
        };
    }

    private static function createBuffDebuffMiningBonus():Resources {
        var _loc1_:Resources = new Resources();
        var _loc2_:int = getBuffDebuffBonusByType(AllianceEffectBonusType.RESOURCES_TU_PRODUCTION_BOOST);
        var _loc3_:int = getBuffDebuffBonusByType(AllianceEffectBonusType.RESOURCES_M_PRODUCTION_BOOST);
        if (_loc2_ != 0) {
            _loc1_.titanite = _loc1_.titanite + _loc2_;
            _loc1_.uranium = _loc1_.uranium + _loc2_;
        }
        if (_loc3_ != 0) {
            _loc1_.money = _loc1_.money + _loc3_;
        }
        return _loc1_;
    }

    private static function createWisdomSkillsMiningBonus(param1:User):Resources {
        var _loc2_:Resources = new Resources();
        var _loc3_:UserWisdomSkillsData = param1.gameData.wisdomSkillsData;
        var _loc4_:int = _loc3_.getActiveBonusPercentByType(WisdomSkillBonusType.URANIUM_PRODUCTION);
        var _loc5_:int = _loc3_.getActiveBonusPercentByType(WisdomSkillBonusType.TITANIT_PRODUCTION);
        var _loc6_:int = _loc3_.getActiveBonusPercentByType(WisdomSkillBonusType.CREDITS_PRODUCTION);
        var _loc7_:int = _loc3_.getActiveBonusPercentByType(WisdomSkillBonusType.ALL_RESOURCES_PRODUCTION);
        if (_loc4_ != 0) {
            _loc2_.uranium = _loc2_.uranium + _loc4_;
        }
        if (_loc5_ != 0) {
            _loc2_.titanite = _loc2_.titanite + _loc5_;
        }
        if (_loc6_ != 0) {
            _loc2_.money = _loc2_.money + _loc6_;
        }
        if (_loc7_ != 0) {
            _loc2_.uranium = _loc2_.uranium + _loc7_;
            _loc2_.titanite = _loc2_.titanite + _loc7_;
            _loc2_.money = _loc2_.money + _loc7_;
        }
        return _loc2_;
    }

    private static function getBuffDebuffBonusByType(param1:int):Number {
        return BuffDebuffCalculate.getBonusValueByType(AllianceManager.currentAlliance.gameData.tacticsData.activeEffects, param1);
    }

    private static function getMiningDegradationKoeff(param1:User, param2:Date):Number {
        var _loc3_:int = (DateUtil.getDatePart(param2).time - DateUtil.getDatePart(param1.gameData.commonData.lastVisitTime).time) / (1000 * 60 * 60 * 24);
        if (_loc3_ <= 2) {
            return 1;
        }
        if (_loc3_ == 3) {
            return 0.75;
        }
        if (_loc3_ == 4) {
            return 0.5;
        }
        return 0.25;
    }

    public static function calculateTroopsResources(param1:User):Resources {
        var _loc4_:Unit = null;
        var _loc5_:SupportTroops = null;
        var _loc2_:UserGameData = param1.gameData;
        var _loc3_:Troops = new Troops();
        _loc3_.addTroops(_loc2_.troopsData.troops);
        for each(_loc4_ in _loc2_.worldData.units) {
            if (_loc4_.troopsPayload != null && _loc4_.StatePendingDepartureBack == null && _loc4_.troopsPayload.order != TroopsOrderId.MissileStrike) {
                if (_loc4_.OwnerUserId == param1.id) {
                    _loc3_.addTroops(_loc4_.troopsPayload.troops);
                }
                else {
                    _loc5_ = _loc4_.troopsPayload.getSupportTroops(param1.id);
                    if (_loc5_) {
                        _loc3_.addTroops(_loc5_.troops);
                    }
                }
            }
        }
        return calculateTroopsResources2(param1, _loc3_);
    }

    public static function calculatePureTroopsResources(param1:Troops):Resources {
        var _loc3_:* = undefined;
        var _loc4_:GeoSceneObjectType = null;
        var _loc5_:int = 0;
        var _loc6_:Resources = null;
        var _loc2_:Resources = new Resources();
        if (param1) {
            for (_loc3_ in param1.countByType) {
                _loc4_ = StaticDataManager.getObjectType(_loc3_);
                _loc5_ = param1.countByType[_loc3_];
                _loc6_ = _loc4_.troopBaseParameters.resources;
                if (_loc6_ != null) {
                    _loc2_.add(Resources.scale(_loc6_, _loc5_));
                }
            }
        }
        return _loc2_;
    }

    public static function calculatePureTroopsResourcesByTroopsDictionary(param1:Dictionary):Resources {
        var _loc3_:* = undefined;
        var _loc4_:GeoSceneObjectType = null;
        var _loc5_:int = 0;
        var _loc6_:Resources = null;
        var _loc2_:Resources = new Resources();
        if (param1) {
            for (_loc3_ in param1) {
                _loc4_ = StaticDataManager.getObjectType(_loc3_);
                _loc5_ = param1[_loc3_].count;
                _loc6_ = _loc4_.troopBaseParameters.resources;
                if (_loc6_ != null) {
                    _loc2_.add(Resources.scale(_loc6_, _loc5_));
                }
            }
        }
        return _loc2_;
    }

    public static function calculateTroopsResources2(param1:User, param2:Troops):Resources {
        var _loc3_:Resources = calculatePureTroopsResources(param2);
        return applyConsumptionBonuses(param1, _loc3_);
    }

    public static function applyConsumptionBonuses(param1:User, param2:Resources):Resources {
        var _loc9_:int = 0;
        var _loc10_:Array = null;
        var _loc11_:ResourceConsumptionBonusBoost = null;
        var _loc3_:UserGameData = param1.gameData;
        var _loc4_:Resources = param2.clone();
        if (_loc3_.effectData.isActiveEffectBySource(EffectTypeId.GppTroopsCreditsConsumptionBonus, EffectSource.GiftPointsProgram)) {
            return new Resources();
        }
        var _loc5_:Number = 0;
        if (_loc3_.artifactData != null) {
            _loc5_ = _loc3_.artifactData.GetResourcesConsumptionBonus();
        }
        if (_loc3_.skillData != null) {
            _loc5_ = _loc5_ + SkillManager.GetResourcesConsumptionBonus(param1);
        }
        var _loc6_:ConstructionData = param1.gameData.constructionData;
        _loc5_ = _loc5_ + _loc6_.consumptionBonusPercent;
        _loc4_.scale(1 - _loc5_ / 100);
        if (_loc6_.consumptionBonusPercents != null) {
            for each(_loc9_ in _loc6_.consumptionBonusPercents) {
                _loc4_.scale(1 - _loc9_ / 100);
            }
        }
        if (Global.CONSUMPTION_BOOSTS_ENABLED) {
            _loc10_ = _loc6_.getActiveConsumptionBonusBoosts(BoostSource.All);
            for each(_loc11_ in _loc10_) {
                _loc4_.scale(1 - _loc11_.boostPercentage / 100);
            }
        }
        var _loc7_:int = AllianceCityManager.getResourceConsumptionBonus(param1);
        if (_loc7_ > 0) {
            _loc4_.scale(1 - _loc7_ / 100);
        }
        var _loc8_:int = _loc3_.wisdomSkillsData.getActiveBonusPercentByType(WisdomSkillBonusType.TROOPS_CONSUMPTION_BONUS);
        if (_loc8_ > 0) {
            _loc4_.scale(1 - _loc8_ / 100);
        }
        return _loc4_;
    }

    private static function getAdditionalAcceleration(param1:User):Resources {
        var _loc5_:Resources = null;
        var _loc6_:Resources = null;
        var _loc7_:Resources = null;
        var _loc2_:Resources = param1.gameData.constructionData.getResourceMiningBoost();
        if (_loc2_ == null) {
            _loc2_ = new Resources();
        }
        if (param1.gameData.artifactData != null) {
            _loc5_ = param1.gameData.artifactData.GetResourceMiningBonus();
            _loc5_.scale(0.01);
            _loc2_.add(_loc5_);
        }
        var _loc3_:Resources = VipManager.getMiningAcc(param1);
        _loc3_.scale(0.01);
        _loc2_.add(_loc3_);
        var _loc4_:EffectData = param1.gameData.effectData;
        if (_loc4_) {
            _loc2_.add(_loc4_.getResourceMiningBoost());
        }
        if (AllianceManager.currentAlliance && AllianceManager.currentAlliance.gameData.tacticsData && AllianceManager.currentAlliance.gameData.tacticsData.hasActiveEffects && !AllianceManager.isAllianceTrialPeriod()) {
            _loc6_ = createBuffDebuffMiningBonus();
            _loc6_.scale(0.01);
            _loc2_.add(_loc6_);
        }
        if (Global.WISDOM_SKILLS_ENABLED) {
            _loc7_ = createWisdomSkillsMiningBonus(param1);
            _loc7_.scale(0.01);
            _loc2_.add(_loc7_);
        }
        return _loc2_;
    }

    private static function getConsumptionParts(param1:Resources):Resources {
        var _loc2_:Resources = param1.clone();
        if (_loc2_.goldMoney > 0) {
            _loc2_.goldMoney = 0;
        }
        if (_loc2_.money > 0) {
            _loc2_.money = 0;
        }
        if (_loc2_.uranium > 0) {
            _loc2_.uranium = 0;
        }
        if (_loc2_.titanite > 0) {
            _loc2_.titanite = 0;
        }
        return _loc2_;
    }

    private static function getMiningParts(param1:Resources):Resources {
        var _loc2_:Resources = param1.clone();
        if (_loc2_.goldMoney < 0) {
            _loc2_.goldMoney = 0;
        }
        if (_loc2_.money < 0) {
            _loc2_.money = 0;
        }
        if (_loc2_.uranium < 0) {
            _loc2_.uranium = 0;
        }
        if (_loc2_.titanite < 0) {
            _loc2_.titanite = 0;
        }
        return _loc2_;
    }

    public function get time():Date {
        return this._time;
    }

    public function process(param1:User, param2:Date):void {
        if (param2 > this._time) {
            this._time = param2;
        }
        this.preProcess(param1, param2);
        this.normalizeResources(param1, param2);
        this.postProcess(param1, param2);
    }

    protected function preProcess(param1:User, param2:Date):void {
    }

    protected function postProcess(param1:User, param2:Date):void {
    }

    private function normalizeResources(param1:User, param2:Date):void {
        var _loc3_:UserGameData = null;
        var _loc7_:Resources = null;
        var _loc11_:Number = NaN;
        var _loc17_:Number = NaN;
        var _loc18_:Number = NaN;
        var _loc19_:* = undefined;
        var _loc20_:GeoSceneObjectType = null;
        var _loc21_:int = 0;
        var _loc22_:Number = NaN;
        var _loc23_:GeoSceneObjectType = null;
        var _loc24_:TroopsLevelInfo = null;
        var _loc25_:SaleableLevelInfo = null;
        var _loc26_:Resources = null;
        var _loc27_:int = 0;
        var _loc28_:Resources = null;
        var _loc29_:LocalStorageBuilding = null;
        var _loc30_:Resources = null;
        var _loc31_:BuildingObjInfo = null;
        var _loc32_:LocalStorageBuilding = null;
        var _loc33_:Resources = null;
        var _loc34_:Resources = null;
        _loc3_ = param1.gameData;
        var _loc4_:UserAccount = _loc3_.account;
        var _loc5_:* = calculateSectorResources(param1, _loc3_.sector, this.time, Global.serverSettings.localStorage.enabled);
        var _loc6_:Resources = _loc5_.perHour;
        _loc7_ = _loc5_.limit;
        var _loc8_:Resources = calculateTroopsResources(param1);
        var _loc9_:Array = !Global.serverSettings.localStorage.enabled ? null : _loc5_.localStorageBuildings;
        var _loc10_:Resources = !Global.serverSettings.localStorage.enabled ? _loc6_ : _loc5_.realPerHour;
        _loc6_.add(_loc8_);
        if (Global.serverSettings.localStorage.enabled) {
            _loc10_.add(_loc8_);
        }
        if (_loc7_.uranium == 0) {
            _loc7_.uranium = 1000;
        }
        if (_loc7_.titanite == 0) {
            _loc7_.titanite = 1000;
        }
        if (_loc7_.money == 0) {
            _loc7_.money = 1000;
        }
        if (_loc7_.biochips == 0) {
            _loc7_.biochips = 1000;
        }
        _loc7_.goldMoney = Number.MAX_VALUE;
        _loc7_.blackCrystals = Number.MAX_VALUE;
        _loc7_.avpMoney = Number.MAX_VALUE;
        _loc7_.constructionItems = Number.MAX_VALUE;
        _loc11_ = StaticDataManager.additionalStorage;
        _loc7_.uranium = _loc7_.uranium + _loc11_;
        _loc7_.titanite = _loc7_.titanite + _loc11_;
        _loc7_.money = _loc7_.money + _loc11_;
        _loc7_.biochips = _loc7_.biochips + _loc11_;
        var _loc12_:Troops = _loc3_.troopsData.troops;
        var _loc13_:ArrayCustom = null;
        var _loc14_:Number = new Number(this._time.time - param2.time) / (60 * 60 * 1000);
        var _loc15_:Resources = new Resources();
        while (_loc14_ > 0) {
            _loc17_ = 0;
            if (_loc4_.resources.money > 0) {
                _loc17_ = _loc10_.money >= 0 ? Number(Number.MAX_VALUE) : Number(_loc4_.resources.money / -_loc10_.money);
            }
            if (Global.ALLOW_TROOPS_STARVATION_ENABLED) {
                _loc17_ = _loc14_;
            }
            if (_loc17_ <= 0) {
                if (_loc13_ == null) {
                    _loc13_ = new ArrayCustom();
                    for (_loc19_ in _loc3_.troopsData.troops.countByType) {
                        if (_loc19_ != TroopsTypeId.CyborgUnit1 && !TroopsTypeId.isAvp(_loc19_)) {
                            _loc20_ = StaticDataManager.getObjectType(_loc19_);
                            _loc21_ = 0;
                            _loc22_ = _loc20_.troopsInfo.diePriority;
                            while (_loc21_ < _loc13_.length && _loc13_[_loc21_].troopsInfo.diePriority < _loc22_) {
                                _loc21_++;
                            }
                            _loc13_.addItemAt(_loc20_, _loc21_);
                        }
                    }
                }
                if (_loc13_.length == 0) {
                    _loc17_ = Number.MAX_VALUE;
                }
                else {
                    _loc23_ = _loc13_[0];
                    _loc24_ = _loc23_.troopBaseParameters;
                    _loc25_ = getTroopsSaleableLevelInfo(_loc23_);
                    _loc26_ = Resources.scale(_loc25_.price.biochips > 0 ? new Resources(0, _loc25_.price.biochips, _loc25_.price.biochips, _loc25_.price.biochips) : _loc25_.price, 0.5);
                    _loc26_.goldMoney = _loc26_.goldMoney * 0;
                    if (_loc26_.money == 0) {
                        _loc26_.money = -_loc23_.troopBaseParameters.resources.money;
                    }
                    if (_loc26_.money == 0) {
                        _loc26_.money = -_loc23_.troopBaseParameters.resources.money;
                    }
                    _loc27_ = _loc26_.money == 0 ? int(int.MAX_VALUE) : int(int(Math.ceil(-_loc4_.resources.money / _loc26_.money)));
                    if (_loc27_ == 0) {
                        _loc27_ = 1;
                    }
                    if (_loc27_ > _loc12_.countByType[_loc23_.id]) {
                        _loc27_ = _loc12_.countByType[_loc23_.id];
                    }
                    _loc12_.countByType[_loc23_.id] = _loc12_.countByType[_loc23_.id] - _loc27_;
                    if (_loc12_.countByType[_loc23_.id] == 0) {
                        delete _loc12_.countByType[_loc23_.id];
                        _loc13_.removeItemAt(0);
                    }
                    _loc26_.scale(_loc27_);
                    _loc4_.resources.add(_loc26_);
                    _loc10_.money = _loc10_.money - _loc27_ * _loc24_.resources.money;
                    _loc6_.money = _loc6_.money - _loc27_ * _loc24_.resources.money;
                    _loc3_.troopsData.troops.dirtyNormalized = true;
                }
            }
            _loc18_ = _loc17_ < _loc14_ ? Number(_loc17_) : Number(_loc14_);
            if (_loc18_ > 0) {
                _loc28_ = Resources.scale(_loc10_, _loc18_);
                if (Global.serverSettings.localStorage.enabled) {
                    for each(_loc29_ in _loc9_) {
                        if (_loc29_.limit != null) {
                            _loc30_ = Resources.scale(_loc29_.miningPerHour, _loc18_);
                            _loc31_ = _loc29_.building.buildingInfo;
                            if (_loc31_.localStorage == null) {
                                _loc31_.localStorage = new Resources();
                            }
                            _loc31_.localStorage.add(_loc30_);
                            _loc15_.add(_loc30_);
                        }
                    }
                }
                _loc4_.resources.add(_loc28_);
                if (_loc28_.money < 0) {
                    _loc28_.money = 0;
                }
                _loc15_.add(_loc28_);
                _loc14_ = _loc14_ - _loc17_;
            }
        }
        var _loc16_:Resources = _loc4_.resources.clone();
        _loc4_.resources.threshold2(MinAccountResourcesLimit, _loc7_);
        if (Global.serverSettings.localStorage.enabled) {
            for each(_loc32_ in _loc9_) {
                _loc33_ = _loc32_.building.buildingInfo.localStorage;
                if (_loc33_ != null) {
                    _loc34_ = _loc33_.clone();
                    _loc33_.threshold2(Resources.Zero, _loc32_.limit);
                    if (_loc34_.capacity() > _loc33_.capacity()) {
                        _loc34_.substract(_loc33_);
                        if (_loc34_.money > 0) {
                            _loc15_.money = _loc15_.money - _loc34_.money;
                        }
                        if (_loc34_.uranium > 0) {
                            _loc15_.uranium = _loc15_.uranium - _loc34_.uranium;
                        }
                        if (_loc34_.titanite > 0) {
                            _loc15_.titanite = _loc15_.titanite - _loc34_.titanite;
                        }
                    }
                }
            }
        }
        if (_loc16_.capacity() > _loc4_.resources.capacity()) {
            _loc16_.substract(_loc4_.resources);
            if (_loc16_.money > 0) {
                _loc15_.money = _loc15_.money - _loc16_.money;
            }
            if (_loc16_.uranium > 0) {
                _loc15_.uranium = _loc15_.uranium - _loc16_.uranium;
            }
            if (_loc16_.titanite > 0) {
                _loc15_.titanite = _loc15_.titanite - _loc16_.titanite;
            }
        }
        UserStatsManager.minedResources(param1, _loc15_);
        _loc4_.resourcesPerHour = _loc6_;
        _loc4_.resourcesLimit = _loc7_;
        _loc4_.resourcesConsumedByTroops = _loc8_;
        _loc4_.resourcesConsumedByBuildings = _loc5_.buildingConsumption;
        _loc4_.miningPerHour = _loc5_.miningPerHour;
    }
}
}

import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.info.BuildingLevelInfo;

class BuildingInfos {


    public var building:GeoSceneObject;

    public var info:BuildingLevelInfo;

    function BuildingInfos(param1:GeoSceneObject, param2:BuildingLevelInfo) {
        super();
        this.building = param1;
        this.info = param2;
    }
}
