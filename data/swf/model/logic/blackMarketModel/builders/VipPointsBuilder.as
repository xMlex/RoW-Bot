package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.VipPointsItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class VipPointsBuilder implements IBlackMarketItemBuilder {


    public function VipPointsBuilder() {
        super();
    }

    protected function buildImageUrl(param1:VipPointsItem):String {
        if (GameType.isTotalDomination) {
            return new BMIRewardUrl(param1.id).build(RewardUrl.BM, RewardUrl.JPEG);
        }
        if (param1.points == 1 || param1.points == 5 || param1.points == 75 || param1.points == 150 || param1.points == 600) {
            return new BMIRewardUrl(param1.id).build(RewardUrl.BM, RewardUrl.SWF);
        }
        return new RewardUrl("vip_points").build(RewardUrl.BM, RewardUrl.SWF);
    }

    protected function fillLocaleData(param1:BlackMarketItemBase):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_vipPointsHeader");
        param1.fullName = param1.name;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:VipPointsItem = new VipPointsItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.points = param1.vipPointsData.points;
        _loc2_.iconUrl = this.buildImageUrl(_loc2_);
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
