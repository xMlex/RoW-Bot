package model.logic.blackMarketModel.dataAdapters {
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.commands.sector.BuyBlackMarketOfferCmd;

public class DrawingAdapter {


    public function DrawingAdapter() {
        super();
    }

    public function adapt(param1:GeoSceneObjectType):BlackMarketItemRaw {
        var _loc2_:BlackMarketItemRaw = new BlackMarketItemRaw();
        _loc2_.id = param1.id;
        _loc2_.name = param1.name;
        _loc2_.price = BuyBlackMarketOfferCmd.getPrice(_loc2_.id + 100);
        _loc2_.geoSceneObjectType = param1;
        return _loc2_;
    }
}
}
