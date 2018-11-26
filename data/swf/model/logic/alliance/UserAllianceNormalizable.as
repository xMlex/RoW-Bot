package model.logic.alliance {
import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.data.normalization.NEventUser;
import model.logic.StaticDataManager;
import model.logic.UserManager;

public class UserAllianceNormalizable implements INormalizable {

    private static var _instance:UserAllianceNormalizable;


    public function UserAllianceNormalizable() {
        super();
    }

    public static function get instance():UserAllianceNormalizable {
        if (_instance == null) {
            _instance = new UserAllianceNormalizable();
        }
        return _instance;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        if (param1.gameData.allianceData == null || !param1.gameData.allianceData.isInAlliance || param1.gameData.allianceData.joinDate == null) {
            return null;
        }
        var _loc3_:Date = new Date(UserManager.user.gameData.allianceData.joinDate.time + StaticDataManager.allianceData.trialPeriodHours * 60 * 60 * 1000);
        if (param1.gameData.normalizationTime < _loc3_ && _loc3_ <= param2) {
            return new NEventUser(_loc3_);
        }
        return null;
    }
}
}
