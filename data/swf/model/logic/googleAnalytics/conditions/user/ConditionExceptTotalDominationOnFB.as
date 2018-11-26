package model.logic.googleAnalytics.conditions.user {
import common.GameType;

import integration.SocialNetworkIdentifier;

import model.logic.googleAnalytics.conditions.GAConditionBase;

public class ConditionExceptTotalDominationOnFB extends GAConditionBase {


    public function ConditionExceptTotalDominationOnFB() {
        super();
    }

    override public function get check():Boolean {
        return !(GameType.isTotalDomination && SocialNetworkIdentifier.isFB);
    }
}
}
