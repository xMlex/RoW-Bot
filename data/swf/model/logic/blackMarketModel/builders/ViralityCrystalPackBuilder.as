package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.logic.ServerManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ViralityCrystalPackItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class ViralityCrystalPackBuilder implements IBlackMarketItemBuilder {


    public function ViralityCrystalPackBuilder() {
        super();
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        if (!GameType.isNords) {
            return null;
        }
        var _loc2_:ViralityCrystalPackItem = new ViralityCrystalPackItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.name = LocaleUtil.getText("forms-formRoulette_CrystalPackage") + " (" + param1.resourcesData.resources.goldMoney.toString() + ")";
        _loc2_.goldMoneyBonus = param1.resourcesData.resources.goldMoney;
        _loc2_.iconUrl = ServerManager.buildContentUrl("ui/awardIcons/blackMarket/goldMoney.png");
        return _loc2_;
    }
}
}
