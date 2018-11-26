package model.logic.buyExperience {
import configs.Global;

import model.logic.StaticDataManager;
import model.logic.UserManager;

public class BuyExperienceConfig {


    public function BuyExperienceConfig() {
        super();
    }

    public static function get ENABLED():Boolean {
        return Global.SALEABLE_EXPERIENCE_ENABLED && UserManager.user.gameData.account.level < StaticDataManager.levelData.maxLevel;
    }
}
}
