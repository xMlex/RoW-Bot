package model.logic.filterSystem.filters {
import model.data.User;
import model.data.users.technologies.TechnologyCenter;
import model.logic.UserManager;
import model.logic.filterSystem.dataProviders.IIDProvider;
import model.logic.filterSystem.interfaces.IDataFilter;

public class BlackCrystalTechFilter implements IDataFilter {


    public function BlackCrystalTechFilter() {
        super();
    }

    public function filter(param1:Array):Array {
        var _loc4_:IIDProvider = null;
        var _loc5_:User = null;
        var _loc6_:TechnologyCenter = null;
        var _loc2_:Array = [];
        var _loc3_:int = 0;
        while (_loc3_ < param1.length) {
            _loc4_ = param1[_loc3_] as IIDProvider;
            if (!_loc4_) {
                throw new Error();
            }
            _loc5_ = UserManager.user;
            _loc6_ = _loc5_.gameData.technologyCenter;
            if (!_loc6_.hasActiveTechnology(_loc4_.id, 1)) {
                _loc2_.push(_loc4_);
            }
            _loc3_++;
        }
        return _loc2_;
    }
}
}
