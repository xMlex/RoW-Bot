package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.CancelUnitItem;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class CancelUnitBuilder implements IBlackMarketItemBuilder {


    public function CancelUnitBuilder() {
        super();
    }

    protected static function fillLocaleData(param1:CancelUnitItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_cancelUnit_name");
        param1.description = LocaleUtil.getText("forms-blackMarketItems_cancelUnit_description");
        param1.fullName = param1.name;
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_cancelUnit_helpText");
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:CancelUnitItem = new CancelUnitItem();
        _loc2_.itemType = BlackMarketItemType.CANCEL_UNIT;
        _loc2_.id = param1.id;
        _loc2_.price = param1.price;
        _loc2_.newUntil = param1.newUntil;
        _loc2_.saleProhibited = param1.saleProhibited;
        _loc2_.iconUrl = BuilderHelper.buildImageUrl(param1.id);
        fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
