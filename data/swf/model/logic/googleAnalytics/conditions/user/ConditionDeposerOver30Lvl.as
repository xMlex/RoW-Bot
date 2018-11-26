package model.logic.googleAnalytics.conditions.user {
import model.logic.UserManager;
import model.logic.googleAnalytics.conditions.GAConditionBase;

public class ConditionDeposerOver30Lvl extends GAConditionBase {


    public function ConditionDeposerOver30Lvl() {
        super();
    }

    override public function get check():Boolean {
        return UserManager.user.gameData.account.level > 30 && UserManager.user.gameData.statsData.isDepositor;
    }
}
}
