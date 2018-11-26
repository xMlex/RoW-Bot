package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.logic.ServerManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.WorkerItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class WorkerBuilder implements IBlackMarketItemBuilder {


    public function WorkerBuilder() {
        super();
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        if (!GameType.isNords) {
            return null;
        }
        var _loc2_:WorkerItem = new WorkerItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.name = LocaleUtil.buildString("forms-blackMarketItems_additionalWorker_name");
        _loc2_.description = LocaleUtil.buildString("forms-blackMarketItems_additionalWorker_description");
        _loc2_.date = param1.constructionWorkerData.duration;
        _loc2_.iconUrl = ServerManager.buildContentUrl("ui/awardIcons/blackMarket/additionalWorker.png");
        return _loc2_;
    }
}
}
