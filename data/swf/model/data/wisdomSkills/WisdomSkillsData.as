package model.data.wisdomSkills {
import Utils.Guard;

public class WisdomSkillsData {


    public var wisdomLevels:Object;

    public var maxLevel:int;

    private var _skillsById:Object;

    public function WisdomSkillsData() {
        this._skillsById = {};
        super();
    }

    public static function fromDto(param1:*):WisdomSkillsData {
        var _loc3_:WisdomLevel = null;
        var _loc4_:* = undefined;
        var _loc5_:WisdomLevel = null;
        var _loc2_:WisdomSkillsData = new WisdomSkillsData();
        if (param1.t != null) {
            _loc2_.wisdomLevels = {};
            _loc3_ = null;
            for (_loc4_ in param1.t) {
                _loc5_ = WisdomLevel.fromDto(param1.t[_loc4_]);
                _loc5_.level = _loc4_;
                _loc5_.previousLevel = _loc3_;
                _loc2_.wisdomLevels[_loc4_] = _loc5_;
                _loc2_.maxLevel = _loc4_;
                _loc2_.addWisdomLevelSkillsToDictionary(_loc5_);
                _loc3_ = _loc5_;
            }
        }
        return _loc2_;
    }

    public function getLevelByWisdomPoints(param1:int):int {
        var _loc4_:WisdomLevel = null;
        if (param1 >= this.wisdomLevels[this.maxLevel].wisdomPointsToAchieve) {
            return this.maxLevel;
        }
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        while (param1 >= _loc2_) {
            _loc4_ = this.wisdomLevels[++_loc3_];
            _loc2_ = _loc4_.wisdomPointsToAchieve;
        }
        return _loc3_ - 1;
    }

    public function getPointsToAchieveByLevel(param1:int):int {
        if (param1 > this.maxLevel) {
            return -1;
        }
        return WisdomLevel(this.wisdomLevels[param1]).wisdomPointsToAchieve;
    }

    public function getWisdomSkillById(param1:int):WisdomSkill {
        var _loc2_:WisdomSkill = this._skillsById[param1];
        Guard.againstNull(_loc2_);
        return _loc2_;
    }

    private function addWisdomLevelSkillsToDictionary(param1:WisdomLevel):void {
        if (!param1.hasAnySkills) {
            return;
        }
        this._skillsById[param1.firstSkill.id] = param1.firstSkill;
        if (param1.hasMultipleSkills) {
            this._skillsById[param1.secondSkill.id] = param1.secondSkill;
        }
    }
}
}
