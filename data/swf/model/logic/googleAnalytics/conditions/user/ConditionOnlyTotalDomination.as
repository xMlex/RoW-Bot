package model.logic.googleAnalytics.conditions.user {
import common.GameType;

import model.logic.googleAnalytics.conditions.GAConditionBase;

public class ConditionOnlyTotalDomination extends GAConditionBase {


    public function ConditionOnlyTotalDomination() {
        super();
    }

    override public function get check():Boolean {
        return GameType.isTotalDomination;
    }
}
}
