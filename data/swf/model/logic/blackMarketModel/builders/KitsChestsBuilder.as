package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.logic.ServerManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.KitsChestsItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class KitsChestsBuilder implements IBlackMarketItemBuilder {


    public function KitsChestsBuilder() {
        super();
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        if (!GameType.isNords && !GameType.isElves && !GameType.isSparta && !GameType.isTotalDomination) {
            return null;
        }
        var _loc2_:KitsChestsItem = new KitsChestsItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.name = LocaleUtil.buildString("forms-blackMarketItems_kitsChests_name");
        _loc2_.description = LocaleUtil.buildString("forms-blackMarketItems_kitsChests_description");
        _loc2_.iconUrl = ServerManager.buildContentUrl("ui/awardIcons/blackMarket/kitsChests.png");
        return _loc2_;
    }
}
}
