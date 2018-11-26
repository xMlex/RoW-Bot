package model.logic.skills.data {
public class SkillImprovementStatus {

    public static const ALLOWED:int = 0;

    public static const NOT_ENOUGH_SKILL_POINTS:int = 1;

    public static const IMPROVEMENT_IN_PROGRESS:int = 2;

    public static const REQUIRED_SKILL_MISSING:int = 3;

    public static const MAXIMUM_LEVEL_REACHED:int = 4;


    public function SkillImprovementStatus() {
        super();
    }
}
}
