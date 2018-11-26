package model.logic.googleAnalytics.conditions.user {
import integration.SocialNetworkIdentifier;

import model.logic.googleAnalytics.conditions.GAConditionBase;

public class ConditionOnlyVk extends GAConditionBase {


    public function ConditionOnlyVk() {
        super();
    }

    override public function get check():Boolean {
        return SocialNetworkIdentifier.isVK;
    }
}
}
