package model.logic.googleAnalytics.conditions.user {
import common.GameType;

import model.logic.googleAnalytics.conditions.GAConditionBase;

public class ConditionMilitaryOrElves extends GAConditionBase {


    public function ConditionMilitaryOrElves() {
        super();
    }

    override public function get check():Boolean {
        return GameType.isElves || GameType.isMilitary;
    }
}
}
