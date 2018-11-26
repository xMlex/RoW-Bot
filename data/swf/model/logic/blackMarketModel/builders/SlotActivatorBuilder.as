package model.logic.blackMarketModel.builders {
import common.GameType;

import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.SlotActivatorItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class SlotActivatorBuilder implements IBlackMarketItemBuilder {


    public function SlotActivatorBuilder() {
        super();
    }

    protected function buildIconUrl(param1:int):String {
        var _loc2_:int = BlackMarketItemsTypeId.convertOldIdToNew(param1);
        var _loc3_:String = RewardUrl.JPEG;
        if (GameType.isMilitary || GameType.isNords) {
            _loc3_ = RewardUrl.PNG;
        }
        else if (GameType.isPirates || GameType.isTotalDomination) {
            _loc3_ = RewardUrl.JPEG;
        }
        return new BMIRewardUrl(_loc2_).build(RewardUrl.BM, _loc3_);
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:SlotActivatorItem = new SlotActivatorItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.fullName = _loc2_.name;
        _loc2_.iconUrl = this.buildIconUrl(param1.id);
        return _loc2_;
    }
}
}
