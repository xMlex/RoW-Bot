package model.logic.googleAnalytics.conditions.user {
import model.logic.UserManager;
import model.logic.googleAnalytics.conditions.GAConditionBase;

public class ConditionOnlyNewUser extends GAConditionBase {


    public function ConditionOnlyNewUser() {
        super();
    }

    override public function get check():Boolean {
        return UserManager._isNewUser;
    }
}
}
