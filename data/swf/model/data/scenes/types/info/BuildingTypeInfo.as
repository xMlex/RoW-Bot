package model.data.scenes.types.info {
import Utils.Guard;

import common.ArrayCustom;
import common.DictionaryUtil;
import common.GameType;
import common.ObjectUtil;
import common.StringUtil;
import common.localization.LocaleUtil;

import configs.Global;

import model.data.Resources;
import model.data.UserGameData;
import model.data.effects.EffectItem;
import model.data.effects.EffectTypeId;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.buildingBonuses.BuildingBonusTypeId;
import model.data.scenes.types.info.buildingBonuses.BuildingSpecialBonusTypeId;
import model.data.wisdomSkills.enums.WisdomSkillBonusType;
import model.logic.StaticDataManager;
import model.logic.UserManager;

public class BuildingTypeInfo {


    public var levelInfos:ArrayCustom;

    public var groupId:int;

    public var defensiveKind:int;

    public var height:int;

    public var slotKindId:int;

    public var decorType:int;

    public var canBeBroken:Boolean;

    public var canBeDeleted:Boolean;

    public var canRepairedByOwnerOnly:Boolean;

    public var notApplyBonusForBuilding:Boolean;

    public var boostIsNotAllowed:Boolean;

    public var cancelIsNotAllowed:Boolean;

    public function BuildingTypeInfo() {
        super();
    }

    public static function getCaravanCapacityPercent():int {
        var _loc3_:BuildingLevelInfo = null;
        var _loc1_:int = 0;
        var _loc2_:GeoSceneObject = UserManager.user.gameData.sector.getBuildings(BuildingTypeId.ChamberOfCommerce, 1)[0] as GeoSceneObject;
        if (_loc2_) {
            _loc1_ = _loc2_.getLevel();
        }
        var _loc4_:GeoSceneObjectType = StaticDataManager.getObjectType(BuildingTypeId.ChamberOfCommerce);
        _loc3_ = _loc4_.buildingInfo.levelInfos.getItemAt(_loc1_ - 1) as BuildingLevelInfo;
        return _loc3_ && _loc3_.caravanCapacityPercent != 0 ? int(_loc3_.caravanCapacityPercent) : 0;
    }

    private static function get financialCorpBonusName():String {
        if (Global.FINANCIAL_CORPORATION_BONUS_ENABLED) {
            return LocaleUtil.getText("forms-resbuildings_troops_resources_consumption_info");
        }
        return LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-bonus");
    }

    private static function addWithNullCheck(param1:Array, param2:SpecialBonusData):void {
        Guard.againstNull(param2);
        if (param2 != null) {
            param1.push(param2);
        }
    }

    public static function fromDto(param1:*):BuildingTypeInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:BuildingTypeInfo = new BuildingTypeInfo();
        _loc2_.levelInfos = BuildingLevelInfo.fromDtos(param1.lc);
        _loc2_.groupId = param1.g;
        _loc2_.defensiveKind = param1.k == null ? -1 : int(param1.k);
        _loc2_.height = param1.h;
        _loc2_.slotKindId = param1.s;
        _loc2_.decorType = param1.t == null ? 0 : int(param1.t);
        _loc2_.canBeBroken = param1.b;
        _loc2_.canBeDeleted = param1.d;
        _loc2_.canRepairedByOwnerOnly = param1.o;
        _loc2_.boostIsNotAllowed = param1.n;
        _loc2_.cancelIsNotAllowed = param1.c;
        _loc2_.notApplyBonusForBuilding = param1.l;
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

    public function get isFunctional():Boolean {
        return BuildingGroupId.isFunctional(this.groupId);
    }

    public function getBonus(param1:int, param2:int, param3:Boolean = false):Object {
        var _loc8_:Resources = null;
        var _loc9_:* = undefined;
        var _loc10_:* = undefined;
        var _loc11_:* = undefined;
        if (this.levelInfos.length < param1) {
            return null;
        }
        var _loc4_:BuildingLevelInfo = this.getLevelInfo(param1);
        if (_loc4_ == null) {
            return null;
        }
        var _loc5_:Resources = _loc4_.resources;
        var _loc6_:Resources = _loc4_.storageLimit;
        var _loc7_:Resources = _loc4_.miningAcceleration;
        if (_loc4_.buildingAcceleration != 0 || param2 == BuildingTypeId.Senate) {
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-buildingSpeed"),
                "value": StringUtil.PLUS + _loc4_.buildingAcceleration.toString() + "%",
                "resources": null,
                "postValue": ""
            };
        }
        if (_loc5_ != null && (_loc5_.money > 0 || _loc5_.uranium > 0 || _loc5_.titanite > 0)) {
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-produces"),
                "value": "",
                "resources": _loc5_,
                "postValue": (!!GameType.isMilitary ? LocaleUtil.getText("forms-FormCommandCenter-OccupiedSectorControlItemRenderer_in_hour") : "")
            };
        }
        if (_loc4_.mineRadarRadius != 0 || param2 == BuildingTypeId.IndustrialRadar) {
            if (GameType.isTotalDomination) {
                return {
                    "name": LocaleUtil.getText("forms-formRadar_grouopRadar_search_radius"),
                    "value": "" + _loc4_.mineRadarRadius.toString() + " " + LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-km"),
                    "resources": null,
                    "postValue": ""
                };
            }
            return {
                "name": LocaleUtil.getText("forms-formRadar_grouopRadar_search_radius"),
                "value": "" + (_loc4_.mineRadarRadius / 10).toString() + " " + LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-km"),
                "resources": null,
                "postValue": ""
            };
        }
        if (_loc4_.caravanQuantity != 0) {
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-caravans"),
                "value": _loc4_.caravanQuantity.toString() + " " + LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-items"),
                "resources": null,
                "postValue": ""
            };
        }
        if (_loc4_.freeLossesRessurectionPercentAttack != 0) {
            return {
                "name": LocaleUtil.buildString("model-data-scenes-types-info-buildingTypeInfo-freeLossesRessurectionPercent", _loc4_.freeLossesRessurectionPercentAttack.toString()),
                "value": "+" + _loc4_.freeLossesRessurectionPercentAttack.toString() + "%",
                "resources": null,
                "postValue": ""
            };
        }
        if (_loc4_.caravanCapacityPercent != 0) {
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-caravanCapacity"),
                "value": "+" + _loc4_.caravanCapacityPercent.toString() + "%",
                "resources": null,
                "postValue": ""
            };
        }
        if (_loc4_.caravanSpeed != 0) {
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-caravanSpeed"),
                "value": "+" + _loc4_.caravanSpeed.toString() + "%",
                "resources": null,
                "postValue": ""
            };
        }
        if (_loc4_.defenceBonusPoints != 0) {
            return {
                "name": (!!GameType.isNords ? LocaleUtil.getText("controls-resourses-bottomPanel_toolTip2_title") + ": " : LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-defence") + ": "),
                "value": "+" + _loc4_.defenceBonusPoints.toString(),
                "resources": null,
                "postValue": ""
            };
        }
        if (_loc4_.defenceIntelligencePoints != 0) {
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-defenceFromIntelligence"),
                "value": "+" + _loc4_.defenceIntelligencePoints.toString(),
                "resources": null,
                "postValue": ""
            };
        }
        if (_loc4_.numberOfAllies != 0) {
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-alliesMax"),
                "value": "" + _loc4_.numberOfAllies.toString() + "",
                "resources": null,
                "postValue": ""
            };
        }
        if (param2 == BuildingTypeId.IndustrialSyndicate && !GameType.isNords) {
            if (_loc4_.locationsOccupationBonus > 0) {
                return {
                    "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-additionalLocation"),
                    "value": "+" + (_loc4_.locationsOccupationBonus * 100 + "%" + " (+" + LocaleUtil.buildString("forms-ProgressGlobalMissionsControl_my_collection_people", _loc4_.locationsOccupationBonus) + ")"),
                    "resources": null,
                    "postValue": ""
                };
            }
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-additionalLocation"),
                "value": "+" + ((param1 - 1) * 20).toString() + "%",
                "resources": null,
                "postValue": ""
            };
        }
        if (param2 == BuildingTypeId.Bunker) {
            _loc8_ = _loc4_.protectedResources.clone();
            this.addBunkerCapacityBonus(_loc8_);
            return {
                "name": LocaleUtil.getText("forms_Bunker_resources_capacity"),
                "value": "",
                "resources": _loc8_,
                "postValue": ""
            };
        }
        if (_loc4_.researchAcceleration != 0) {
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-researchSpeed"),
                "value": "+" + _loc4_.researchAcceleration.toString() + "%",
                "resources": null,
                "postValue": ""
            };
        }
        if (_loc6_ != null && (_loc6_.money > 0 || _loc6_.uranium > 0 || _loc6_.titanite > 0)) {
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-containingCapacity"),
                "value": "",
                "resources": _loc6_,
                "postValue": ""
            };
        }
        if (_loc7_ != null && (_loc7_.money > 0 || _loc7_.uranium > 0 || _loc7_.titanite > 0)) {
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-bonus"),
                "value": "",
                "resources": new Resources(0, _loc7_.money * 100, _loc7_.uranium * 100, _loc7_.titanite * 100),
                "postValue": "%"
            };
        }
        if (param2 == BuildingTypeId.RobotBoostResources && GameType.isMilitary) {
            return {
                "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-bonus"),
                "value": "",
                "resources": _loc5_,
                "postValue": ""
            };
        }
        if (param2 == BuildingTypeId.FinancialCorporation) {
            return {
                "name": financialCorpBonusName,
                "value": Math.round(_loc4_.consumptionBonusPercent),
                "resources": null,
                "postValue": "%"
            };
        }
        if (_loc4_.troopsQueueHoursLimit != null && !DictionaryUtil.isEmptyDictionary(_loc4_.troopsQueueHoursLimit)) {
            for (_loc9_ in _loc4_.troopsQueueHoursLimit) {
                return {
                    "name": LocaleUtil.getText("form-building_control_unit_learning_speed"),
                    "value": _loc4_.troopsQueueHoursLimit[_loc9_].toString(),
                    "resources": null,
                    "postValue": " " + LocaleUtil.getText("utils-common-dateUtils-hous")
                };
            }
        }
        else if (_loc4_.troopsAcceleration != null && !DictionaryUtil.isEmptyDictionary(_loc4_.troopsAcceleration)) {
            for (_loc10_ in _loc4_.troopsAcceleration) {
                return {
                    "name": LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-troopsAcceleration"),
                    "value": "+" + _loc4_.troopsAcceleration[_loc10_].toString() + "%",
                    "resources": null,
                    "postValue": ""
                };
            }
        }
        else if (_loc4_.battleExperienceBonusPercents != null && !ObjectUtil.isEmpty(_loc4_.battleExperienceBonusPercents)) {
            for (_loc11_ in _loc4_.battleExperienceBonusPercents) {
                return {
                    "name": LocaleUtil.buildString("model-data-scenes-types-info-buildingTypeInfo-battleExperienceBonusPercents", TroopsGroupId.GetNameByGroupId(_loc11_)),
                    "value": "+" + _loc4_.battleExperienceBonusPercents[_loc11_].toString() + "%",
                    "resources": null,
                    "postValue": ""
                };
            }
        }
        if (param2 == BuildingTypeId.BuildingIdGemsLab) {
            return {
                "name": LocaleUtil.getText("controls-common-upgrade-bonesGemsLabel"),
                "value": _loc4_.gemCraftLevelLimit.toString(),
                "resources": null,
                "postValue": ""
            };
        }
        return null;
    }

    public function getSpecialBonuses(param1:int, param2:IBonusViewBuilderFactory, param3:int):Array {
        if (this.levelInfos.length < param1) {
            return null;
        }
        var _loc4_:BuildingLevelInfo = this.getLevelInfo(param1);
        if (_loc4_ == null) {
            return null;
        }
        var _loc5_:Array = [];
        if (_loc4_.experienceBonus > 0) {
            addWithNullCheck(_loc5_, param2.build(BuildingSpecialBonusTypeId.SPECIAL_EXPERIENCE, _loc4_));
        }
        if (_loc4_.paidResurrectionBonusPercents > 0) {
            addWithNullCheck(_loc5_, param2.build(BuildingSpecialBonusTypeId.SPECIAL_PAID_RESURRECTION, _loc4_));
        }
        if (_loc4_.troopsMoveToBunker && _loc4_.troopsMoveToBunker.length > 0) {
            addWithNullCheck(_loc5_, param2.build(BuildingSpecialBonusTypeId.SPECIAL_TROOPS_MOVE_TO_BUNKER, _loc4_));
        }
        if (_loc4_.buildingsLimitBonus && !ObjectUtil.isEmpty(_loc4_.buildingsLimitBonus)) {
            addWithNullCheck(_loc5_, param2.build(BuildingSpecialBonusTypeId.SPECIAL_BUILDINGS_LIMIT, _loc4_));
        }
        if (_loc4_.troopsAttackBonusGlobal > 0) {
            addWithNullCheck(_loc5_, param2.build(BuildingSpecialBonusTypeId.SPECIAL_TROOPS_ATTACK, _loc4_));
        }
        if (_loc4_.troopsDefenceBonusGlobal > 0) {
            addWithNullCheck(_loc5_, param2.build(BuildingSpecialBonusTypeId.SPECIAL_TROOPS_DEFENCE, _loc4_));
        }
        if (_loc4_.getConsumptionBonusByType(BuildingBonusTypeId.SPECIAL) > 0) {
            addWithNullCheck(_loc5_, param2.build(BuildingSpecialBonusTypeId.SPECIAL_CONSUMPTION_BONUS_PERCENT, _loc4_));
        }
        if (_loc4_.defenceBonusPoints > 0) {
            addWithNullCheck(_loc5_, param2.build(BuildingSpecialBonusTypeId.SPECIAL_DEFENCE_BONUS_POINTS, _loc4_));
        }
        if (_loc4_.dynamicResMiningSpeedBonusPercent != null) {
            addWithNullCheck(_loc5_, param2.build(BuildingSpecialBonusTypeId.SPECIAL_DYNAMIC_RES_MINING_SPEED, _loc4_));
        }
        return _loc5_;
    }

    public function getLevelInfo(param1:int):BuildingLevelInfo {
        return this.levelInfos.getItemAt(param1 - 1) as BuildingLevelInfo;
    }

    public function getCurrentLevelInfo(param1:int):BuildingLevelInfo {
        return this.levelInfos[param1];
    }

    private function addBunkerCapacityBonus(param1:Resources):Resources {
        var _loc3_:int = 0;
        var _loc4_:EffectItem = null;
        if (!Global.serverSettings.unit.bunkerLimitsRobbery) {
            return param1;
        }
        var _loc2_:UserGameData = UserManager.user.gameData;
        if (Global.WISDOM_SKILLS_ENABLED) {
            _loc3_ = _loc2_.wisdomSkillsData.getActiveBonusPercentByType(WisdomSkillBonusType.BUNKER_RESOURCES_CAPACITY);
            if (_loc3_ > 0) {
                param1.scale(1 + _loc3_ / 100);
            }
        }
        if (_loc2_.effectData.isActiveEffect(EffectTypeId.GppBunkerResourceCapacityBonus)) {
            _loc4_ = _loc2_.effectData.getFirstActiveEffect(EffectTypeId.GppBunkerResourceCapacityBonus);
            if (_loc4_.activeState.power > 0) {
                param1.scale(1 + _loc4_.activeState.power / 100);
            }
        }
        return param1.roundAll();
    }
}
}
