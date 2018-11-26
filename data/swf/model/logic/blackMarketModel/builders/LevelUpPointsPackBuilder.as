package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.data.ResourceTypeId;
import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ResourcePackItem;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.StubDiscountContext;

public class LevelUpPointsPackBuilder implements IBlackMarketItemBuilder {

    private static const ITEM_NAME:String = LocaleUtil.getText("forms-common_levelUpPoints");

    private static const ITEM_HELP_TEXT:String = LocaleUtil.getText("forms-formBlackMarket_levelUpPoints_toolTip");


    public function LevelUpPointsPackBuilder() {
        super();
    }

    private static function buildImageUrl(param1:int):String {
        return new BMIRewardUrl(param1).build(RewardUrl.BM, RewardUrl.PNG);
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:ResourcePackItem = new ResourcePackItem();
        _loc2_.id = param1.id;
        _loc2_.itemType = BlackMarketItemType.LEVEL_UP_POINTS;
        _loc2_.price = param1.price;
        _loc2_.newUntil = param1.newUntil;
        _loc2_.saleProhibited = param1.saleProhibited;
        _loc2_.name = ITEM_NAME;
        _loc2_.helpText = ITEM_HELP_TEXT;
        _loc2_.iconUrl = buildImageUrl(_loc2_.id);
        if (_loc2_.price == null) {
            _loc2_.discountContext = new StubDiscountContext();
        }
        _loc2_.levelUpPoints = param1.levelUpPointsData.levelUpPoints;
        _loc2_.type = ResourceTypeId.LEVEL_UP_POINTS;
        _loc2_.fullName = param1.name + " (" + param1.levelUpPointsData.levelUpPoints + ")";
        return _loc2_;
    }
}
}
