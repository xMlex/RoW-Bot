package model.logic.skills.normalization {
import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.logic.skills.data.Skill;

public class SkillNormalizable implements INormalizable {

    private static var _instance:SkillNormalizable;


    public function SkillNormalizable() {
        super();
    }

    public static function get instance():SkillNormalizable {
        if (_instance == null) {
            _instance = new SkillNormalizable();
        }
        return _instance;
    }

    private static function getSkillFinishedTime(param1:Skill, param2:Date):Date {
        if (param1.constructionInfo.constructionStartTime == null) {
            return null;
        }
        param1.constructionInfo.updatePercentage(param2);
        param1.dirtyNormalized = true;
        return param1.constructionInfo.constructionFinishTime;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc3_:* = this.getNextFinishedSkill(param1, param2);
        var _loc4_:Skill = _loc3_.skill;
        param2 = _loc3_.time;
        return _loc4_ == null ? null : new NEventSkillFinished(_loc4_, param2);
    }

    private function getNextFinishedSkill(param1:User, param2:Date):* {
        var _loc5_:Skill = null;
        var _loc6_:Date = null;
        var _loc3_:Skill = null;
        var _loc4_:Date = new Date(param2);
        for each(_loc5_ in param1.gameData.skillData.skills) {
            _loc6_ = getSkillFinishedTime(_loc5_, _loc4_);
            if (!(_loc6_ == null || _loc6_ > param2)) {
                _loc3_ = _loc5_;
                param2 = _loc6_;
            }
        }
        return {
            "skill": _loc3_,
            "time": param2
        };
    }
}
}
