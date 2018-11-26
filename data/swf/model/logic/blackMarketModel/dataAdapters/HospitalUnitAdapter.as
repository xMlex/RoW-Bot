package model.logic.blackMarketModel.dataAdapters {
import model.data.scenes.types.GeoSceneObjectType;
import model.data.users.troops.Troops;
import model.logic.StaticDataManager;
import model.logic.UnitResurrectionHelper;
import model.logic.blackMarketItems.BlackMarketItemRaw;

public class HospitalUnitAdapter {


    public function HospitalUnitAdapter() {
        super();
    }

    public function adapt(param1:int, param2:int):BlackMarketItemRaw {
        var _loc3_:GeoSceneObjectType = StaticDataManager.getObjectType(param1);
        var _loc4_:BlackMarketItemRaw = new BlackMarketItemRaw();
        _loc4_.id = param1;
        _loc4_.name = _loc3_.name;
        _loc4_.geoSceneObjectType = _loc3_;
        _loc4_.troopsCount = param2;
        var _loc5_:Troops = new Troops();
        _loc5_.countByType[param1] = 1;
        _loc4_.price = UnitResurrectionHelper.getFullPrice(_loc5_);
        return _loc4_;
    }
}
}
