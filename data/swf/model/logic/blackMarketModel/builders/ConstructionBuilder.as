package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ConstructionItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class ConstructionBuilder implements IBlackMarketItemBuilder {


    public function ConstructionBuilder() {
        super();
    }

    protected function buildIconUrl(param1:int):String {
        var _loc2_:String = GameType.isMilitary || GameType.isNords ? RewardUrl.PNG : RewardUrl.JPEG;
        return new BMIRewardUrl(param1).build(RewardUrl.BM, _loc2_);
    }

    protected function fillLocaleData(param1:BlackMarketItemBase):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_ConstructionPointsHeader");
        param1.fullName = param1.name;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:ConstructionItem = new ConstructionItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.constructionPoints = param1.constructionPointsData.constructionPoints;
        _loc2_.iconUrl = this.buildIconUrl(param1.id);
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
