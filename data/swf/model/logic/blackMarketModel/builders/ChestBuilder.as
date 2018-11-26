package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ChestItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.StubDiscountContext;

public class ChestBuilder implements IBlackMarketItemBuilder {


    public function ChestBuilder() {
        super();
    }

    protected static function buildImageUrl(param1:int):String {
        var _loc2_:String = !!GameType.isTotalDomination ? RewardUrl.MEDIUM : RewardUrl.BM;
        var _loc3_:String = GameType.isMilitary || GameType.isNords ? RewardUrl.PNG : RewardUrl.JPEG;
        if (GameType.isPirates) {
            _loc3_ = RewardUrl.JPEG;
            switch (param1) {
                case BlackMarketItemsTypeId.Gem2ChestsLvl1:
                case BlackMarketItemsTypeId.Gem2ChestsLvl2:
                case BlackMarketItemsTypeId.Gem2ChestsLvl3:
                case BlackMarketItemsTypeId.Gem2ChestsLvl2To4:
                case BlackMarketItemsTypeId.Gem2ChestsLvl3To5:
                case BlackMarketItemsTypeId.Gem2ChestsLvl1Bonus:
                    _loc3_ = RewardUrl.PNG;
            }
        }
        return new BMIRewardUrl(param1).build(_loc2_, _loc3_);
    }

    protected function fillLocaleData(param1:BlackMarketItemBase):void {
        param1.name = LocaleUtil.getText("forms-formBlackMarket-chestItemRenderer_labelNameChest");
        param1.fullName = param1.name;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:ChestItem = new ChestItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.iconUrl = buildImageUrl(param1.id);
        _loc2_.gemsCount = param1.chestData.gemCount;
        _loc2_.gemLevelFrom = param1.chestData.gemLevelFrom;
        _loc2_.gemLevelTo = param1.chestData.gemLevelTo;
        _loc2_.newUntil = param1.newUntil;
        if (_loc2_.price == null) {
            _loc2_.discountContext = new StubDiscountContext();
        }
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
