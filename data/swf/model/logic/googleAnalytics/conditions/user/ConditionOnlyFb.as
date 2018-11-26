package model.logic.googleAnalytics.conditions.user {
import integration.SocialNetworkIdentifier;

import model.logic.googleAnalytics.conditions.GAConditionBase;

public class ConditionOnlyFb extends GAConditionBase {


    public function ConditionOnlyFb() {
        super();
    }

    override public function get check():Boolean {
        return SocialNetworkIdentifier.isFB;
    }
}
}
