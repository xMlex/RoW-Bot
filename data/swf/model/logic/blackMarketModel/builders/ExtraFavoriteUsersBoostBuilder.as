package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import integration.SocialNetworkIdentifier;

import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ExtraFavoriteUsersBoostItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.StubDiscountContext;

public class ExtraFavoriteUsersBoostBuilder implements IBlackMarketItemBuilder {


    public function ExtraFavoriteUsersBoostBuilder() {
        super();
    }

    protected function fillLocaleData(param1:BlackMarketItemBase):void {
        param1.name = LocaleUtil.getText("forms-formBlackMarket_labelTitleNotes");
        param1.fullName = param1.name;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:ExtraFavoriteUsersBoostItem = new ExtraFavoriteUsersBoostItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.boostValue = param1.favoriteUsersBoostType.boostValue;
        var _loc3_:int = GameType.isTotalDomination && SocialNetworkIdentifier.isVK || GameType.isSparta || GameType.isNords ? 250 : 200;
        _loc2_.description = LocaleUtil.buildString("forms-formBlackMarket_labelDescriptionNotes", _loc3_);
        _loc2_.discountContext = new StubDiscountContext();
        _loc2_.iconUrl = new RewardUrl("notes").build(RewardUrl.BM, RewardUrl.PNG);
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
