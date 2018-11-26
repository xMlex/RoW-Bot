package model.logic.blackMarketModel.dataAdapters {
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.BlackMarketTroopsType;
import model.logic.StaticDataManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;

public class UnitAdapter {


    public function UnitAdapter() {
        super();
    }

    public function adapt(param1:BlackMarketTroopsType):BlackMarketItemRaw {
        var _loc2_:GeoSceneObjectType = StaticDataManager.getObjectType(param1.troopsTypeId);
        if (!_loc2_) {
            return null;
        }
        var _loc3_:BlackMarketItemRaw = new BlackMarketItemRaw();
        _loc3_.id = param1.troopsTypeId;
        _loc3_.troopsType = param1;
        _loc3_.price = param1.price;
        _loc3_.geoSceneObjectType = _loc2_;
        return _loc3_;
    }
}
}
