package model.logic.blackMarketModel.providers {
import common.ArrayCustom;

import model.logic.StaticDataManager;
import model.logic.blackMarketModel.interfaces.IRawItemsProvider;

public class BlackMarketItemsProvider implements IRawItemsProvider {


    public function BlackMarketItemsProvider() {
        super();
    }

    public function getRawItems():ArrayCustom {
        return StaticDataManager.blackMarketData.items;
    }
}
}
