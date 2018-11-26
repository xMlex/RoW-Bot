package model.data.wisdomSkills {
public class WisdomSkillVisualData {


    public var description:LocalTexts;

    public function WisdomSkillVisualData() {
        super();
    }

    public static function fromDto(param1:*):WisdomSkillVisualData {
        var _loc2_:WisdomSkillVisualData = new WisdomSkillVisualData();
        _loc2_.description = LocalTexts.fromDto(param1.d);
        return _loc2_;
    }
}
}
