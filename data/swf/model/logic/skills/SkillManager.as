package model.logic.skills {
import common.ArrayCustom;
import common.localization.LocaleUtil;

import flash.utils.Dictionary;

import model.data.User;
import model.data.UserGameData;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.skills.data.DiscardPointsStatus;
import model.logic.skills.data.RequiredSkill;
import model.logic.skills.data.Skill;
import model.logic.skills.data.SkillEffectTypeId;
import model.logic.skills.data.SkillImprovementStatus;
import model.logic.skills.data.SkillType;
import model.logic.skills.data.UserSkillData;

public class SkillManager {

    public static var requiredSkillLevelByType:Dictionary;

    public static var discardDict:Dictionary = new Dictionary();

    private static var _nodes:ArrayCustom;


    public function SkillManager() {
        super();
    }

    public static function getSkill(param1:UserSkillData, param2:int):Skill {
        var _loc3_:Skill = null;
        for each(_loc3_ in param1.skills) {
            if (_loc3_.typeId == param2) {
                return _loc3_;
            }
        }
        return null;
    }

    public static function getImproveStatus(param1:User, param2:int):int {
        var _loc5_:Skill = null;
        var _loc6_:SkillType = null;
        var _loc7_:RequiredSkill = null;
        var _loc8_:Skill = null;
        var _loc3_:UserSkillData = param1.gameData.skillData;
        var _loc4_:Skill = SkillManager.getSkill(_loc3_, param2);
        if (_loc4_ == null || _loc4_.constructionInfo.level == 0 && _loc4_.constructionInfo.constructionStartTime == null) {
            _loc6_ = StaticDataManager.skillData.getSkillType(param2);
            if (_loc6_.requiredSkills != null && _loc6_.requiredSkills.length > 0) {
                for each(_loc7_ in _loc6_.requiredSkills) {
                    _loc8_ = SkillManager.getSkill(_loc3_, _loc7_.skillTypeId);
                    if (_loc8_ == null || _loc8_.constructionInfo.level < _loc7_.requiredLevel) {
                        return SkillImprovementStatus.REQUIRED_SKILL_MISSING;
                    }
                }
            }
        }
        else if (_loc4_.constructionInfo.level >= StaticDataManager.skillData.getSkillType(_loc4_.typeId).levelInfos.length) {
            return SkillImprovementStatus.MAXIMUM_LEVEL_REACHED;
        }
        for each(_loc5_ in _loc3_.skills) {
            if (_loc5_.constructionInfo.constructionStartTime != null) {
                return SkillImprovementStatus.IMPROVEMENT_IN_PROGRESS;
            }
        }
        if (_loc3_.skillPoints == 0) {
            return SkillImprovementStatus.NOT_ENOUGH_SKILL_POINTS;
        }
        return SkillImprovementStatus.ALLOWED;
    }

    public static function GetTroopsTrainingBonus(param1:UserGameData):Dictionary {
        var _loc3_:Skill = null;
        var _loc4_:SkillType = null;
        var _loc5_:Number = NaN;
        var _loc6_:int = 0;
        var _loc2_:Dictionary = new Dictionary();
        if (param1.skillData == null) {
            return _loc2_;
        }
        for each(_loc3_ in param1.skillData.skills) {
            if (_loc3_.constructionInfo.level != 0) {
                _loc4_ = StaticDataManager.skillData.getSkillType(_loc3_.typeId);
                if (!(_loc4_.effectTypeId != SkillEffectTypeId.TROOPS_TRAINING_SPEED || _loc4_.affectedTypes == null || _loc4_.affectedTypes.length == 0)) {
                    _loc5_ = _loc4_.levelInfos[_loc3_.constructionInfo.level - 1].effectValue;
                    for each(_loc6_ in _loc4_.affectedTypes) {
                        if (_loc2_[_loc6_] == null) {
                            _loc2_[_loc6_] = _loc5_;
                        }
                        else {
                            _loc2_[_loc6_] = _loc2_[_loc6_] + _loc5_;
                        }
                    }
                }
            }
        }
        return _loc2_;
    }

    public static function GetResourcesConsumptionBonus(param1:User):Number {
        return GetBonus(param1.gameData, SkillEffectTypeId.TROOPS_RESOURCES_CONSUMPTION);
    }

    public static function GetTechnologyResearchSpeedBonus(param1:UserGameData):Number {
        return GetBonus(param1, SkillEffectTypeId.TECHNOLOGY_RESEARCH_SPEED);
    }

    public static function GetBuildingRepairSpeedBonus(param1:UserGameData):Number {
        return GetBonus(param1, SkillEffectTypeId.BUILDINGS_REPAIR_SPEED);
    }

    public static function GetOccupiedLocationsNumberBonus(param1:UserGameData):int {
        return GetBonus(param1, SkillEffectTypeId.OCCUPIED_LOCATIONS_LIMIT);
    }

    public static function GetCyborgsCountBonus(param1:UserGameData):Number {
        return GetBonus(param1, SkillEffectTypeId.CYBORGS_COUNT);
    }

    public static function GetMutationCostBonus(param1:UserGameData):Number {
        return GetBonus(param1, SkillEffectTypeId.MUTATION_COST);
    }

    public static function GetExperienceBonus(param1:UserGameData):Number {
        return GetBonus(param1, SkillEffectTypeId.BATTLE_EXPERIENCE);
    }

    public static function GetRobberyBonus(param1:UserGameData):Number {
        return GetBonus(param1, SkillEffectTypeId.ADDITIONAL_ROBBERY);
    }

    private static function GetBonus(param1:UserGameData, param2:int):Number {
        var _loc4_:Skill = null;
        var _loc3_:Number = 0;
        for each(_loc4_ in param1.skillData.skills) {
            if (!(_loc4_.constructionInfo.level == 0 || _loc4_.type.effectTypeId != param2)) {
                _loc3_ = _loc3_ + _loc4_.type.levelInfos[_loc4_.constructionInfo.level - 1].effectValue;
            }
        }
        return _loc3_;
    }

    public static function GetTroopsMovementSpeedBonus(param1:User, param2:Array = null):Dictionary {
        var _loc4_:Skill = null;
        var _loc5_:Number = NaN;
        var _loc6_:int = 0;
        var _loc3_:Dictionary = new Dictionary();
        if (param2 == null) {
            param2 = StaticDataManager.getAllUnitTypeIds();
        }
        for each(_loc4_ in param1.gameData.skillData.skills) {
            if (!(_loc4_.constructionInfo.level == 0 || _loc4_.type.effectTypeId != SkillEffectTypeId.TROOPS_MOVEMENT_SPEED || _loc4_.type.affectedTypes == null || _loc4_.type.affectedTypes.length == 0)) {
                _loc5_ = _loc4_.type.levelInfos[_loc4_.constructionInfo.level - 1].effectValue;
                for each(_loc6_ in param2) {
                    if (_loc4_.type.affectedTypes.contains(_loc6_)) {
                        if (_loc3_[_loc6_] == null) {
                            _loc3_[_loc6_] = _loc5_;
                        }
                        else {
                            _loc3_[_loc6_] = _loc3_[_loc6_] + _loc5_;
                        }
                    }
                }
            }
        }
        return _loc3_;
    }

    public static function onLevelUp(param1:User, param2:int):void {
        var _loc3_:int = param1.gameData.account.level;
        if (param2 >= _loc3_) {
            return;
        }
        var _loc4_:int = 0;
        var _loc5_:int = param2 + 1;
        while (_loc5_ <= _loc3_) {
            _loc4_ = _loc4_ + getPointsByUserLevel(_loc5_);
            _loc5_++;
        }
        if (_loc4_ > 0) {
            param1.gameData.skillData.skillPoints = param1.gameData.skillData.skillPoints + _loc4_;
            param1.gameData.skillData.dirty = true;
        }
    }

    public static function getDiscardStatus(param1:User, param2:Dictionary):int {
        var _loc4_:* = undefined;
        var _loc5_:Dictionary = null;
        var _loc6_:Skill = null;
        var _loc7_:* = undefined;
        var _loc8_:* = undefined;
        var _loc9_:int = 0;
        var _loc10_:Skill = null;
        var _loc11_:int = 0;
        var _loc12_:int = 0;
        var _loc13_:ArrayCustom = null;
        var _loc14_:RequiredSkill = null;
        var _loc3_:UserSkillData = param1.gameData.skillData;
        for (_loc4_ in param2) {
            _loc9_ = param2[_loc4_];
            _loc10_ = SkillManager.getSkill(_loc3_, _loc4_);
            if (_loc10_ == null) {
                return DiscardPointsStatus.SKILL_NOT_FOUND;
            }
            if (_loc10_.constructionInfo.constructionStartTime != null) {
                return DiscardPointsStatus.COULD_NOT_DISCARD_POINTS_FROM_IMPROVING_SKILL;
            }
            if (_loc9_ <= 0 || _loc10_.constructionInfo.level < _loc9_) {
                return DiscardPointsStatus.WRONG_POINTS_AMOUNT_TO_DISCARD;
            }
        }
        _loc5_ = new Dictionary();
        for each(_loc6_ in _loc3_.skills) {
            if (_loc6_.constructionInfo.level > 0 || _loc6_.constructionInfo.constructionStartTime != null) {
                _loc5_[_loc6_.typeId] = {
                    "level": _loc6_.constructionInfo.level,
                    "isUpgrading": _loc6_.constructionInfo.constructionStartTime != null
                };
            }
        }
        for (_loc7_ in param2) {
            _loc11_ = param2[_loc7_];
            _loc12_ = _loc5_[_loc7_].level;
            _loc12_ = _loc12_ - _loc11_;
            if (_loc12_ == 0 && !_loc5_[_loc7_].isUpgrading) {
                delete _loc5_[_loc7_];
            }
            else {
                _loc5_[_loc7_].level = _loc12_;
            }
        }
        for (_loc8_ in _loc5_) {
            _loc13_ = StaticDataManager.skillData.getSkillType(_loc8_).requiredSkills;
            if (!(_loc13_ == null || _loc13_.length == 0)) {
                for each(_loc14_ in _loc13_) {
                    if (_loc5_[_loc14_.skillTypeId] == null) {
                        return DiscardPointsStatus.DISCARD_WILL_BREAK_SKILL_DEPENDENCIES;
                    }
                    if (_loc5_[_loc14_.skillTypeId].level < _loc14_.requiredLevel) {
                        return DiscardPointsStatus.DISCARD_WILL_BREAK_SKILL_DEPENDENCIES;
                    }
                }
            }
        }
        return DiscardPointsStatus.ALLOWED;
    }

    public static function getDiscardDictLength():int {
        var _loc2_:* = undefined;
        var _loc1_:int = 0;
        for (_loc2_ in discardDict) {
            _loc1_ = _loc1_ + discardDict[_loc2_];
        }
        return _loc1_;
    }

    public static function get nodes():ArrayCustom {
        var _loc1_:SkillType = null;
        if (_nodes) {
            return _nodes;
        }
        _nodes = new ArrayCustom();
        for each(_loc1_ in StaticDataManager.skillData.skillTypes) {
            _nodes.addItem({
                "skillType": _loc1_,
                "skill": SkillManager.getSkill(UserManager.user.gameData.skillData, _loc1_.id),
                "nodeLevel": 0
            });
        }
        return _nodes;
    }

    public static function hasUpgradingSkills():Boolean {
        var _loc1_:Skill = null;
        for each(_loc1_ in UserManager.user.gameData.skillData.skills) {
            if (_loc1_.constructionInfo.constructionStartTime != null) {
                return true;
            }
        }
        return false;
    }

    public static function hasAnySkillToUpgrade():Boolean {
        var _loc1_:Skill = null;
        for each(_loc1_ in UserManager.user.gameData.skillData.skills) {
            if (_loc1_.constructionInfo.level < _loc1_.type.levelInfos.length) {
                return true;
            }
        }
        return false;
    }

    public static function hasLearnedSkills():Boolean {
        var _loc1_:Skill = null;
        for each(_loc1_ in UserManager.user.gameData.skillData.skills) {
            if (_loc1_.improvementStatus != SkillImprovementStatus.REQUIRED_SKILL_MISSING) {
                return true;
            }
        }
        return false;
    }

    public static function hasAnyLearnedSkills():Boolean {
        var _loc1_:Skill = null;
        for each(_loc1_ in UserManager.user.gameData.skillData.skills) {
            if (_loc1_.constructionInfo.level > 0) {
                return true;
            }
        }
        return false;
    }

    public static function getPointsByUserLevel(param1:int):int {
        var _loc2_:Object = null;
        if (param1 >= 5) {
            for each(_loc2_ in StaticDataManager.skillData.skillPointsPerLevel) {
                if (param1 <= _loc2_.level) {
                    return _loc2_.value;
                }
            }
        }
        return 0;
    }

    public static function getEffectSign(param1:int):String {
        switch (param1) {
            case SkillEffectTypeId.TROOPS_TRAINING_SPEED:
                return "+";
            case SkillEffectTypeId.TROOPS_MOVEMENT_SPEED:
                return "+";
            case SkillEffectTypeId.TROOPS_RESOURCES_CONSUMPTION:
                return "-";
            case SkillEffectTypeId.TECHNOLOGY_RESEARCH_SPEED:
                return "+";
            case SkillEffectTypeId.CYBORGS_COUNT:
                return "+";
            case SkillEffectTypeId.BUILDINGS_REPAIR_SPEED:
                return "+";
            case SkillEffectTypeId.OCCUPIED_LOCATIONS_LIMIT:
                return "+";
            case SkillEffectTypeId.MUTATION_COST:
                return "-";
            case SkillEffectTypeId.BATTLE_EXPERIENCE:
                return "+";
            case SkillEffectTypeId.NONE:
                return "";
            default:
                return "";
        }
    }

    public static function getEffectUnit(param1:int):String {
        switch (param1) {
            case SkillEffectTypeId.TROOPS_TRAINING_SPEED:
                return "%";
            case SkillEffectTypeId.TROOPS_MOVEMENT_SPEED:
                return "%";
            case SkillEffectTypeId.TROOPS_RESOURCES_CONSUMPTION:
                return "%";
            case SkillEffectTypeId.TECHNOLOGY_RESEARCH_SPEED:
                return "%";
            case SkillEffectTypeId.CYBORGS_COUNT:
                return LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-items");
            case SkillEffectTypeId.BUILDINGS_REPAIR_SPEED:
                return "%";
            case SkillEffectTypeId.OCCUPIED_LOCATIONS_LIMIT:
                return LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-items");
            case SkillEffectTypeId.MUTATION_COST:
                return "%";
            case SkillEffectTypeId.BATTLE_EXPERIENCE:
                return "%";
            case SkillEffectTypeId.NONE:
                return "";
            default:
                return "";
        }
    }
}
}
