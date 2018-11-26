package model.logic.occupation.normalization {
import configs.Global;

import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.logic.occupation.data.OccupationState;
import model.logic.occupation.data.UserOccupationData;
import model.logic.occupation.data.UserOccupationInfo;

public class OccupationNormalizable implements INormalizable {

    private static var _instance:OccupationNormalizable;


    public function OccupationNormalizable() {
        super();
    }

    public static function get instance():OccupationNormalizable {
        if (_instance == null) {
            _instance = new OccupationNormalizable();
        }
        return _instance;
    }

    private static function getCollectionStartTime(param1:UserOccupationInfo, param2:Date):Date {
        if (param1.state != OccupationState.COLLECTION_DELAY) {
            return null;
        }
        var _loc3_:Number = param1.occupationStartTime.time + Global.serverSettings.occupation.collectionStartDelayHours * 1000 * 60 * 60;
        return param2.time < _loc3_ ? null : new Date(_loc3_);
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc7_:UserOccupationInfo = null;
        if (!Global.serverSettings.occupation.enabled || param1.gameData.occupationData == null) {
            return null;
        }
        var _loc3_:UserOccupationInfo = null;
        var _loc4_:UserOccupationData = param1.gameData.occupationData;
        var _loc5_:UserOccupationInfo = _loc4_.ownOccupationInfo;
        var _loc6_:Date = null;
        if (_loc5_ != null) {
            _loc6_ = getCollectionStartTime(_loc5_, param2);
            if (_loc6_ != null && _loc6_ < param2) {
                param2 = _loc6_;
                _loc3_ = _loc5_;
            }
        }
        for each(_loc7_ in _loc4_.userOccupationInfos) {
            _loc6_ = getCollectionStartTime(_loc7_, param2);
            _loc7_.refreshCollectionState();
            if (!(_loc6_ == null || _loc6_ > param2)) {
                param2 = _loc6_;
                _loc3_ = _loc7_;
            }
        }
        return _loc3_ == null ? null : new NEventOccupationStartCollection(_loc3_, param2);
    }
}
}
