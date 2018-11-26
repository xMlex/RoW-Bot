package model.logic.blackMarketModel.dataAdapters {
import model.data.SectorSkinType;
import model.logic.ServerManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;

public class SkinTypeAdapter {


    public function SkinTypeAdapter() {
        super();
    }

    public function adapt(param1:SectorSkinType):BlackMarketItemRaw {
        if (param1.id == 1) {
            return null;
        }
        if (param1.isTemporary) {
            return null;
        }
        var _loc2_:BlackMarketItemRaw = new BlackMarketItemRaw();
        _loc2_.id = param1.id * 10000;
        _loc2_.name = param1.name;
        _loc2_.iconUrl = ServerManager.buildContentUrl(param1.urlShop);
        _loc2_.price = param1.price;
        _loc2_.sectorSkinType = param1;
        _loc2_.newUntil = param1.newUntil;
        return _loc2_;
    }
}
}
