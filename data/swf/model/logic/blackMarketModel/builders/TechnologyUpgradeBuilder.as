package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.logic.ServerManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.enums.BlackMarketPackType;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.TechnologyUpgradeItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class TechnologyUpgradeBuilder implements IBlackMarketItemBuilder {


    public function TechnologyUpgradeBuilder() {
        super();
    }

    protected function buildImageUrl(param1:TechnologyUpgradeItem):String {
        if (param1.isHighLevel) {
            return ServerManager.buildContentUrl("ui/awardIcons/blackMarket/upgrade2_big_" + param1.itemsCount + ".png");
        }
        return ServerManager.buildContentUrl("ui/awardIcons/blackMarket/upgrade1_big_" + param1.itemsCount + ".png");
    }

    protected function buildDescription(param1:TechnologyUpgradeItem):String {
        if (param1.isHighLevel) {
            return LocaleUtil.getText("forms-blackMarketItems_technologyHigherLevelUpgradeDescription");
        }
        return LocaleUtil.getText("forms-blackMarketItems_technologyUpgradeDescription");
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        if (!GameType.isNords) {
            return null;
        }
        var _loc2_:TechnologyUpgradeItem = new TechnologyUpgradeItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.isHighLevel = param1.packData.packType == BlackMarketPackType.UPGRADE_TECHNOLOGY_02;
        _loc2_.itemsCount = param1.packData.itemCount;
        _loc2_.description = this.buildDescription(_loc2_);
        _loc2_.iconUrl = this.buildImageUrl(_loc2_);
        return _loc2_;
    }
}
}
