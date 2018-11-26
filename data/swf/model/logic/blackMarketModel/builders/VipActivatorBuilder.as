package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.VipActivatorItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class VipActivatorBuilder implements IBlackMarketItemBuilder {


    public function VipActivatorBuilder() {
        super();
    }

    protected function buildImageUrl(param1:VipActivatorItem):String {
        var _loc2_:String = null;
        if (GameType.isMilitary || GameType.isNords) {
            _loc2_ = RewardUrl.PNG;
        }
        else {
            _loc2_ = RewardUrl.JPEG;
        }
        return new BMIRewardUrl(param1.id).build(RewardUrl.BM, _loc2_);
    }

    protected function fillLocaleData(param1:BlackMarketItemBase):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_vipActivatorHeader");
        param1.fullName = param1.name;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:VipActivatorItem = new VipActivatorItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.duration = param1.vipActivatorData.durationSeconds;
        _loc2_.maxLevel = param1.vipActivatorData.maxLevel;
        _loc2_.minLevel = param1.vipActivatorData.minLevel;
        _loc2_.iconUrl = this.buildImageUrl(_loc2_);
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
