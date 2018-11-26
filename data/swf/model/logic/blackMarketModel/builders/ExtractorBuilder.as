package model.logic.blackMarketModel.builders {
import common.GameType;

import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.logic.ServerManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ExtractorItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class ExtractorBuilder implements IBlackMarketItemBuilder {


    public function ExtractorBuilder() {
        super();
    }

    protected function buildIconUrl(param1:int):String {
        var _loc4_:int = 0;
        if (param1 == BlackMarketItemsTypeId.GemExtractorLvl1To4Bonus && GameType.isTotalDomination) {
            return ServerManager.buildContentUrl("ui/awardIcons/blackMarket/item_450.jpg");
        }
        var _loc2_:int = BlackMarketItemsTypeId.convertOldIdToNew(param1);
        var _loc3_:String = RewardUrl.JPEG;
        if (GameType.isMilitary || GameType.isNords) {
            _loc3_ = RewardUrl.PNG;
        }
        if (GameType.isPirates) {
            _loc4_ = _loc2_;
            switch (_loc4_) {
                case BlackMarketItemsTypeId.Extractor_1_4:
                case BlackMarketItemsTypeId.GemExtractorLvl1To8:
                case BlackMarketItemsTypeId.GemExtractorLvl1To12:
                    _loc3_ = RewardUrl.PNG;
                    break;
                default:
                    _loc3_ = RewardUrl.JPEG;
            }
        }
        return new BMIRewardUrl(param1).build(RewardUrl.BM, _loc3_);
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:ExtractorItem = new ExtractorItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.fullName = param1.name;
        _loc2_.iconUrl = this.buildIconUrl(param1.id);
        _loc2_.gemLevelFrom = param1.gemRemovalData.gemLevelFrom;
        _loc2_.gemLevelTo = param1.gemRemovalData.gemLevelTo;
        return _loc2_;
    }
}
}
