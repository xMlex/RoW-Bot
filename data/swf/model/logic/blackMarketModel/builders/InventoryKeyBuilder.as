package model.logic.blackMarketModel.builders {
import common.GameType;

import model.logic.ServerManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.InventoryKeyItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class InventoryKeyBuilder implements IBlackMarketItemBuilder {


    public function InventoryKeyBuilder() {
        super();
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        if (GameType.isMilitary || GameType.isPirates) {
            return null;
        }
        var _loc2_:InventoryKeyItem = new InventoryKeyItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.rareness = param1.inventoryKeyData.rareness;
        _loc2_.requiredTechnologyId = param1.inventoryKeyData.requiredTechnologyId;
        _loc2_.iconUrl = ServerManager.buildContentUrl(param1.iconUrl);
        _loc2_.saleProhibited = param1.saleProhibited;
        return _loc2_;
    }
}
}
