package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.BuildingUpgradeItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class BuildingUpgradeBuilder implements IBlackMarketItemBuilder {


    public function BuildingUpgradeBuilder() {
        super();
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        if (!GameType.isNords) {
            return null;
        }
        var _loc2_:BuildingUpgradeItem = new BuildingUpgradeItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.description = LocaleUtil.getText("forms-blackMarketItems_buildingUpgradeDescription");
        _loc2_.itemsCount = param1.packData.itemCount;
        return _loc2_;
    }
}
}
