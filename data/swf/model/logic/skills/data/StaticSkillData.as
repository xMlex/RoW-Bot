package model.logic.skills.data {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.data.Resources;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.skills.SkillManager;

public class StaticSkillData {


    public var skillTypes:ArrayCustom;

    public var pointsDiscardPriceByAttempt:ArrayCustom;

    public var skillPointsPerLevel:Array;

    private var _skillTypeById:Dictionary;

    public function StaticSkillData() {
        super();
    }

    public static function fromDto(param1:*):StaticSkillData {
        var _loc3_:SkillType = null;
        var _loc4_:* = undefined;
        var _loc2_:StaticSkillData = new StaticSkillData();
        _loc2_.skillTypes = SkillType.fromDtos(param1.s);
        if (param1.p != null) {
            _loc2_.skillPointsPerLevel = [];
            for (_loc4_ in param1.p) {
                _loc2_.skillPointsPerLevel.push({
                    "level": _loc4_,
                    "value": param1.p[_loc4_]
                });
            }
            _loc2_.skillPointsPerLevel.sortOn("level", Array.NUMERIC);
        }
        fillRequiredLevels(_loc2_.skillTypes);
        _loc2_.pointsDiscardPriceByAttempt = Resources.fromDtos(param1.d);
        _loc2_._skillTypeById = new Dictionary();
        for each(_loc3_ in _loc2_.skillTypes) {
            _loc2_._skillTypeById[_loc3_.id] = _loc3_;
        }
        return _loc2_;
    }

    private static function fillRequiredLevels(param1:ArrayCustom):void {
        var _loc2_:SkillType = null;
        var _loc3_:RequiredSkill = null;
        SkillManager.requiredSkillLevelByType = new Dictionary();
        for each(_loc2_ in param1) {
            for each(_loc3_ in _loc2_.requiredSkills) {
                if (!(SkillManager.requiredSkillLevelByType[_loc3_.skillTypeId] > 0 && _loc3_.requiredLevel <= SkillManager.requiredSkillLevelByType[_loc3_.skillTypeId])) {
                    SkillManager.requiredSkillLevelByType[_loc3_.skillTypeId] = _loc3_.requiredLevel;
                }
            }
        }
    }

    public function getSkillType(param1:int):SkillType {
        return this._skillTypeById[param1];
    }

    public function getDiscardPrice():Resources {
        var _loc1_:int = UserManager.user.gameData.skillData.pointDiscardsCount;
        var _loc2_:ArrayCustom = StaticDataManager.skillData.pointsDiscardPriceByAttempt;
        return _loc1_ >= _loc2_.length ? _loc2_[_loc2_.length - 1] : _loc2_[_loc1_];
    }
}
}
