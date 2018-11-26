package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.logic.ServerManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.UpdateSectorItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class UpdateSectorBuilder implements IBlackMarketItemBuilder {


    public function UpdateSectorBuilder() {
        super();
    }

    protected function buildDescription(param1:BlackMarketItemRaw):String {
        if (param1.updateSectorData.updateSectorType == 1) {
            return LocaleUtil.buildString("form-formBlackMarket-labelDescriptionHeroNameChange");
        }
        return LocaleUtil.buildString("form-formBlackMarket-labelDescriptionHeroChange");
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        if (!GameType.isNords) {
            return null;
        }
        var _loc2_:UpdateSectorItem = new UpdateSectorItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.description = this.buildDescription(param1);
        _loc2_.updateSectorType = param1.updateSectorData.updateSectorType;
        _loc2_.iconUrl = ServerManager.buildContentUrl(param1.iconUrl);
        return _loc2_;
    }
}
}
