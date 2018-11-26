package model.logic.filterSystem.filters {
import model.logic.UserManager;
import model.logic.filterSystem.interfaces.IDataFilter;

public class VipPointsFilter implements IDataFilter {


    public function VipPointsFilter() {
        super();
    }

    public function filter(param1:Array):Array {
        var _loc2_:int = UserManager.user.gameData.vipData.vipLevel;
        var _loc3_:Array = [];
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            if (UserManager.user.gameData.vipData && _loc2_ < 10) {
                _loc3_.push(param1[_loc4_]);
            }
            _loc4_++;
        }
        return _loc3_;
    }
}
}
