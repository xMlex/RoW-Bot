package model.data.wisdomSkills {
import common.StringUtil;

import model.data.wisdomSkills.enums.WisdomSkillBonusType;

public class WisdomSkillBonusInfo {


    public var type:int;

    public var percent:int;

    public function WisdomSkillBonusInfo() {
        super();
    }

    public static function fromDto(param1:*):WisdomSkillBonusInfo {
        var _loc2_:WisdomSkillBonusInfo = new WisdomSkillBonusInfo();
        _loc2_.type = param1.t;
        _loc2_.percent = param1.p;
        return _loc2_;
    }

    public function get bonusSign():String {
        if (this.type == WisdomSkillBonusType.TROOPS_CONSUMPTION_BONUS) {
            return StringUtil.MINUS;
        }
        return StringUtil.PLUS;
    }
}
}
