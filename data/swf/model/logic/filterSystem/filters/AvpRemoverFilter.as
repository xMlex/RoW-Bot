package model.logic.filterSystem.filters {
import common.GameType;

import configs.Global;

import model.data.scenes.types.info.TroopsGroupId;
import model.logic.ServerTimeManager;
import model.logic.filterSystem.interfaces.IDataFilter;

public class AvpRemoverFilter implements IDataFilter {


    public function AvpRemoverFilter() {
        super();
    }

    public function filter(param1:Array):Array {
        var _loc2_:Array = null;
        var _loc3_:int = 0;
        if (GameType.isMilitary && Global.serverSettings.unit.avpSettings.expirationTime < ServerTimeManager.serverTimeNow) {
            _loc2_ = [];
            _loc3_ = 0;
            while (_loc3_ < param1.length) {
                if (param1[_loc3_].groupId != TroopsGroupId.AVP) {
                    _loc2_.push(param1[_loc3_]);
                }
                _loc3_++;
            }
            return _loc2_;
        }
        return param1;
    }
}
}
