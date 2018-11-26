package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.logic.ServerManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ClanGachaChestItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.StubDiscountContext;

public class GachaChestBuilder implements IBlackMarketItemBuilder {


    public function GachaChestBuilder() {
        super();
    }

    protected function buildIconUrl(param1:BlackMarketItemRaw):String {
        var _loc2_:String = ServerManager.buildContentUrl(param1.iconUrl);
        return _loc2_;
    }

    protected function fillLocaleData(param1:ClanGachaChestItem):void {
        param1.description = LocaleUtil.getText("forms-blackMarketItems_gachaChest_description");
        param1.fullName = param1.name;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:ClanGachaChestItem = new ClanGachaChestItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.iconUrl = this.buildIconUrl(param1);
        _loc2_.gachaChestTypeId = param1.gachaChestData.gachaChestTypeId;
        if (_loc2_.price == null) {
            _loc2_.discountContext = new StubDiscountContext();
        }
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
