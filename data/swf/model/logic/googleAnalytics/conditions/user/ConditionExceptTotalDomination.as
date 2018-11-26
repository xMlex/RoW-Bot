package model.logic.googleAnalytics.conditions.user {
import common.GameType;

import model.logic.googleAnalytics.conditions.GAConditionBase;

public class ConditionExceptTotalDomination extends GAConditionBase {


    public function ConditionExceptTotalDomination() {
        super();
    }

    override public function get check():Boolean {
        return !GameType.isTotalDomination;
    }
}
}
