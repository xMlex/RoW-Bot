package model.data.users.troops {
import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.logic.ServerTimeManager;
import model.logic.UserManager;

public class UserTroopsNormalizable implements INormalizable {

    private static var _instance:UserTroopsNormalizable;


    public function UserTroopsNormalizable() {
        super();
    }

    public static function get instance():UserTroopsNormalizable {
        if (_instance == null) {
            _instance = new UserTroopsNormalizable();
        }
        return _instance;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc5_:TroopsTierObjLevelInfo = null;
        var _loc6_:* = null;
        var _loc3_:Array = [];
        var _loc4_:UserTroopsData = UserManager.user.gameData.troopsData;
        if (_loc4_ == null || _loc4_.tiersLevelInfoByTierId == null) {
            return null;
        }
        for (_loc6_ in _loc4_.tiersLevelInfoByTierId) {
            _loc5_ = _loc4_.tiersLevelInfoByTierId[_loc6_];
            if (_loc5_.inProgress) {
                _loc5_.constructionInfo.updatePercentage(param2);
                _loc5_.dirty = true;
                if (_loc5_.constructionInfo.constructionFinishTime.time <= ServerTimeManager.serverTimeNow.time) {
                    _loc3_.push(_loc6_);
                }
            }
        }
        return _loc3_.length == 0 ? null : new NEventTroopsTierUpgradeFinished(_loc3_, param2);
    }
}
}
