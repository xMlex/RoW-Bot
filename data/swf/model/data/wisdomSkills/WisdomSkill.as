package model.data.wisdomSkills {
public class WisdomSkill {


    public var id:int;

    public var visualData:WisdomSkillVisualData;

    public var dependedSkillId:int;

    public var parentLevel:WisdomLevel;

    private var _providedBonuses:Array;

    public function WisdomSkill() {
        this._providedBonuses = [];
        super();
    }

    public static function fromDto(param1:*):WisdomSkill {
        var _loc2_:WisdomSkill = new WisdomSkill();
        _loc2_.id = param1.i;
        _loc2_.visualData = param1.v != null ? WisdomSkillVisualData.fromDto(param1.v) : null;
        _loc2_.setBonusData(param1);
        return _loc2_;
    }

    public function get hasMultipleBonuses():Boolean {
        return this._providedBonuses.length > 1;
    }

    public function get firstBonus():WisdomSkillBonusInfo {
        return this._providedBonuses[0];
    }

    public function get secondBonus():WisdomSkillBonusInfo {
        return this._providedBonuses[1];
    }

    public function get hasDependedSkill():Boolean {
        return this.dependedSkillId != 0;
    }

    private function setBonusData(param1:*):void {
        var _loc2_:* = undefined;
        if (param1.b != null) {
            for each(_loc2_ in param1.b) {
                this._providedBonuses.push(WisdomSkillBonusInfo.fromDto(_loc2_));
            }
        }
    }
}
}
