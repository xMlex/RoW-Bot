package model.logic.blackMarketModel.builders {
import common.GameType;

import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.TroopsTypeId;
import model.logic.StaticDataManager;

public class StrategyUnitBuilder extends UnitBuilder {


    public function StrategyUnitBuilder() {
        super();
    }

    override protected function buildIconUrl(param1:GeoSceneObjectType):String {
        var _loc2_:String = param1.getUrlForBlackMarket();
        if (GameType.isMilitary) {
            if (TroopsTypeId.isAvpStrategy(param1.id)) {
                _loc2_ = _loc2_.replace("_bm01", "_bm");
            }
            else {
                _loc2_ = _loc2_.replace("_bm01", "_bm02").replace(".jpg", ".png");
            }
        }
        if (GameType.isNords) {
            _loc2_ = param1.getUrlForBlackMarket().replace("_bm01", "_p").replace(".jpg", ".swf");
        }
        return _loc2_;
    }

    override protected function buildRequiredLevel(param1:GeoSceneObjectType):int {
        return StaticDataManager.blackMarketData.strategyTroopsMinimalUserLevel;
    }
}
}
