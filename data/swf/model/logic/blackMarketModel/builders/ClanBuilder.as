package model.logic.blackMarketModel.builders {
import common.GameType;

import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ClanItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class ClanBuilder implements IBlackMarketItemBuilder {


    public function ClanBuilder() {
        super();
    }

    protected function buildIconUrl(param1:int):String {
        var _loc2_:String = !!GameType.isMilitary ? RewardUrl.PNG : RewardUrl.JPEG;
        return new BMIRewardUrl(param1).build(RewardUrl.BM, _loc2_);
    }

    protected function fillLocaleData(param1:BlackMarketItemBase):void {
        param1.fullName = param1.name;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:ClanItem = new ClanItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.packId = param1.staticBonusPackData.packId;
        _loc2_.iconUrl = this.buildIconUrl(param1.id);
        _loc2_.newUntil = param1.newUntil;
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
