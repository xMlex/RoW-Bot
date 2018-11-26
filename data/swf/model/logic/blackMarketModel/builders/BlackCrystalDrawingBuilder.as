package model.logic.blackMarketModel.builders {
import common.GameType;

import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.core.BlackCrystalDrawingItem;
import model.logic.blackMarketModel.core.DrawingItem;

public class BlackCrystalDrawingBuilder extends DrawingBuilder {


    public function BlackCrystalDrawingBuilder() {
        super();
    }

    override protected function createItem():DrawingItem {
        return new BlackCrystalDrawingItem();
    }

    override protected function buildIconUrl(param1:BlackMarketItemRaw):String {
        var _loc2_:String = "";
        var _loc3_:GeoSceneObjectType = StaticDataManager.getObjectType(StaticDataManager.getDependentTroops(param1.geoSceneObjectType)[0]);
        if (GameType.isTotalDomination) {
            _loc2_ = _loc3_.getUrlForShop();
        }
        else if (GameType.isPirates) {
            _loc2_ = _loc3_.getUrlForBlackMarketSmall();
        }
        else if (GameType.isSparta) {
            _loc2_ = _loc3_.getUrlForShop().replace(".jpg", ".png");
        }
        else if (GameType.isMilitary || GameType.isElves) {
            _loc2_ = _loc3_.getUrlForBlackMarketSmall().replace(".jpg", ".png");
        }
        return _loc2_;
    }
}
}
