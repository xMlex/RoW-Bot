package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.NanopodItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.StubDiscountContext;

public class NanopodBuilder implements IBlackMarketItemBuilder {


    public function NanopodBuilder() {
        super();
    }

    protected function buildIconUrl():String {
        var _loc1_:String = !!GameType.isTotalDomination ? RewardUrl.MEDIUM : RewardUrl.BM;
        var _loc2_:String = GameType.isTotalDomination || GameType.isElves ? RewardUrl.JPEG : RewardUrl.PNG;
        return new RewardUrl("nanopod").build(_loc1_, _loc2_);
    }

    protected function fillLocaledata(param1:BlackMarketItemBase):void {
        param1.name = LocaleUtil.getText("resourcesControl_nanopods");
        param1.fullName = param1.name;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:NanopodItem = new NanopodItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.description = LocaleUtil.getText("forms-formBlackMarket_labelDescriptionSkillPoint");
        _loc2_.discountContext = new StubDiscountContext();
        _loc2_.iconUrl = this.buildIconUrl();
        this.fillLocaledata(_loc2_);
        return _loc2_;
    }
}
}
