package model.data.scenes.types.info {
import common.ArrayCustom;
import common.DictionaryUtil;

import flash.utils.Dictionary;

import model.data.Resources;

public class BuildingLevelInfo {


    public var protectedResources:Resources;

    public var resources:Resources;

    public var storageLimit:Resources;

    public var localStorageLimit:Resources;

    public var miningAcceleration:Resources;

    public var troopsAcceleration:Dictionary;

    public var buildingAcceleration:int;

    public var researchAcceleration:int;

    public var numberOfAllies:int;

    public var caravanQuantity:int;

    public var caravanCapacityPercent:int;

    public var caravanSpeed:int;

    public var defenceBonusPoints:int;

    public var defenceIntelligencePoints:int;

    public var mineRadarRadius:int;

    public var cyborgsPerDay:int;

    public var troopsTypeId:int;

    public var repairSeconds:int;

    public var consumptionBonusPercent:Number;

    public var consumptionBonusPercentsWithType:Object;

    public var gemCraftLevelLimit:int;

    public var freeLossesRessurectionPercentAttack:Number;

    public var freeLossesRessurectionPercentDefence:Number;

    public var troopsQueueHoursLimit:Dictionary;

    public var allianceHelpMaxMembersAbleToRespond:int;

    public var allianceHelpMaxConstructionBoostSeconds:int;

    public var isAdditionalLevel:Boolean;

    public var paidResurrectionBonusPercents:Number;

    public var buildingsLimitBonus:Object;

    public var experienceBonus:Number;

    public var troopsMoveToBunker:Array;

    public var locationsOccupationBonus:int;

    public var troopsAttackBonusGlobal:int;

    public var troopsDefenceBonusGlobal:int;

    public var battleExperienceBonusPercents:Object;

    public var dynamicResMiningSpeedBonusPercent:Resources;

    public var repairBoostAllowed:Boolean;

    public function BuildingLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):BuildingLevelInfo {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc5_:* = undefined;
        var _loc6_:* = undefined;
        var _loc2_:BuildingLevelInfo = new BuildingLevelInfo();
        _loc2_.resources = Resources.fromDto(param1.r);
        _loc2_.protectedResources = Resources.fromDto(param1.p);
        _loc2_.storageLimit = Resources.fromDto(param1.s);
        _loc2_.localStorageLimit = Resources.fromDto(param1.l);
        _loc2_.miningAcceleration = Resources.fromDto(param1.a);
        _loc2_.buildingAcceleration = param1.c == null ? 0 : int(param1.c);
        _loc2_.researchAcceleration = param1.d == null ? 0 : int(param1.d);
        _loc2_.numberOfAllies = param1.e == null ? 0 : int(param1.e);
        _loc2_.caravanQuantity = param1.f == null ? 0 : int(param1.f);
        _loc2_.caravanCapacityPercent = param1.g == null ? 0 : int(param1.g);
        _loc2_.caravanSpeed = param1.h == null ? 0 : int(param1.h);
        _loc2_.defenceBonusPoints = param1.x == null ? 0 : int(param1.x);
        _loc2_.defenceIntelligencePoints = param1.y == null ? 0 : int(param1.y);
        _loc2_.cyborgsPerDay = param1.z == null ? 0 : int(param1.z);
        _loc2_.troopsTypeId = param1.w == null ? 0 : int(param1.w);
        _loc2_.repairSeconds = param1.t == null ? 0 : int(param1.t);
        _loc2_.gemCraftLevelLimit = param1.i == null ? 0 : int(param1.i);
        _loc2_.freeLossesRessurectionPercentAttack = param1.u == null ? Number(0) : Number(param1.u);
        _loc2_.freeLossesRessurectionPercentDefence = param1.ud == null ? Number(0) : Number(param1.ud);
        _loc2_.locationsOccupationBonus = param1.mo == null ? 0 : int(param1.mo);
        if (param1.rr != null) {
            _loc2_.mineRadarRadius = param1.rr == null ? 0 : int(param1.rr);
        }
        _loc2_.troopsAcceleration = DictionaryUtil.fromDto(param1.b);
        _loc2_.troopsQueueHoursLimit = DictionaryUtil.fromDto(param1.j);
        _loc2_.allianceHelpMaxMembersAbleToRespond = param1.mh;
        _loc2_.allianceHelpMaxConstructionBoostSeconds = param1.ms;
        _loc2_.isAdditionalLevel = param1.v == null ? false : Boolean(param1.v);
        _loc2_.consumptionBonusPercent = param1.k != null ? Number(param1.k) : Number(0);
        if (param1.kpb != null) {
            _loc2_.consumptionBonusPercentsWithType = {};
            for (_loc3_ in param1.kpb) {
                _loc2_.consumptionBonusPercentsWithType[_loc3_] = new Dictionary();
                _loc4_ = param1.kpb[_loc3_];
                _loc2_.consumptionBonusPercentsWithType[_loc3_][_loc4_.k] = _loc4_.v;
            }
        }
        _loc2_.paidResurrectionBonusPercents = param1.pr;
        if (param1.blb != null) {
            _loc2_.buildingsLimitBonus = {};
            for (_loc5_ in param1.blb) {
                if (param1.blb[_loc5_] > 0) {
                    _loc2_.buildingsLimitBonus[_loc5_] = param1.blb[_loc5_];
                }
            }
        }
        _loc2_.experienceBonus = param1.eb == null ? Number(0) : Number(param1.eb);
        if (param1.tm != null) {
            _loc2_.troopsMoveToBunker = [].concat(param1.tm);
        }
        _loc2_.dynamicResMiningSpeedBonusPercent = Resources.fromDto(param1.dr);
        _loc2_.troopsAttackBonusGlobal = param1.ta == null ? 0 : int(param1.ta);
        _loc2_.troopsDefenceBonusGlobal = param1.td == null ? 0 : int(param1.td);
        if (param1.xp != null) {
            _loc2_.battleExperienceBonusPercents = {};
            for (_loc6_ in param1.xp) {
                _loc2_.battleExperienceBonusPercents[_loc6_] = param1.xp[_loc6_];
            }
        }
        _loc2_.repairBoostAllowed = param1.rb;
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

    public function getConsumptionBonusByType(param1:int):Number {
        var _loc3_:* = undefined;
        var _loc2_:Number = 0;
        if (this.consumptionBonusPercentsWithType != null) {
            for each(_loc3_ in this.consumptionBonusPercentsWithType) {
                if (_loc3_[param1] != null && _loc3_[param1] > 0) {
                    _loc2_ = _loc2_ + _loc3_[param1];
                }
            }
        }
        return _loc2_;
    }
}
}
