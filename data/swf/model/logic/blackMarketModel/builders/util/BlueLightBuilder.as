package model.logic.blackMarketModel.builders.util {
import common.GameType;

import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.BlueLightItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class BlueLightBuilder implements IBlackMarketItemBuilder {


    public function BlueLightBuilder() {
        super();
    }

    protected static function buildIconUrl(param1:int):String {
        var _loc2_:String = !!GameType.isMilitary ? RewardUrl.PNG : RewardUrl.JPEG;
        return new BMIRewardUrl(param1).build(RewardUrl.BM, _loc2_);
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:BlueLightItem = new BlueLightItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.iconUrl = buildIconUrl(param1.id);
        _loc2_.prize = param1.blueLightBonusData.prize;
        _loc2_.prizePriceCrystal = param1.blueLightBonusData.priceCrystals;
        return _loc2_;
    }
}
}
