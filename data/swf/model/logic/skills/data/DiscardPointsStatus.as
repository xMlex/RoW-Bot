package model.logic.skills.data {
public class DiscardPointsStatus {

    public static const ALLOWED:int = 0;

    public static const SKILL_NOT_FOUND:int = 1;

    public static const COULD_NOT_DISCARD_POINTS_FROM_IMPROVING_SKILL:int = 2;

    public static const WRONG_POINTS_AMOUNT_TO_DISCARD:int = 3;

    public static const DISCARD_WILL_BREAK_SKILL_DEPENDENCIES:int = 4;


    public function DiscardPointsStatus() {
        super();
    }
}
}
