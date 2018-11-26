package model.logic.blackMarketModel.dataAdapters {
import model.data.Resources;
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;

public class BuildingAdapter {


    public function BuildingAdapter() {
        super();
    }

    public function adapt(param1:int):BlackMarketItemRaw {
        var _loc2_:GeoSceneObjectType = StaticDataManager.getObjectType(param1);
        if (!_loc2_) {
            return null;
        }
        var _loc3_:BlackMarketItemRaw = new BlackMarketItemRaw();
        _loc3_.id = param1;
        _loc3_.name = _loc2_.name;
        _loc3_.price = Resources.fromGoldMoney(_loc2_.saleableInfo.getLevelInfo(1).price.goldMoney);
        _loc3_.iconUrl = _loc2_.getUrlForShop();
        _loc3_.geoSceneObjectType = _loc2_;
        return _loc3_;
    }
}
}
