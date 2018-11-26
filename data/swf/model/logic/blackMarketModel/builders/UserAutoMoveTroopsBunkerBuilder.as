package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.UserAutoMoveTroopsBunkerItem;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class UserAutoMoveTroopsBunkerBuilder implements IBlackMarketItemBuilder {


    public function UserAutoMoveTroopsBunkerBuilder() {
        super();
    }

    protected static function fillLocaleData(param1:UserAutoMoveTroopsBunkerItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_userAutoMoveTroopsBunker_name");
        param1.description = LocaleUtil.getText("forms-blackMarketItems_userAutoMoveTroopsBunker_description") + " " + buildDuration(param1.timeSeconds);
        param1.fullName = param1.name;
        param1.helpText = LocaleUtil.getText("forms-blackMarketItems_userAutoMoveTroopsBunker_helpText");
    }

    protected static function buildDuration(param1:Number):String {
        return param1 / 60 / 60 + " " + DateUtil.DOZEN_HOURS;
    }

    private static function buildImageUrl(param1:UserAutoMoveTroopsBunkerItem):String {
        if (param1.itemType == BlackMarketItemType.USER_AUTO_MOVE_TROOPS_BUNKER_BC) {
            return BuilderHelper.buildImageUrlBlackCrystal(param1.id);
        }
        return BuilderHelper.buildImageUrl(param1.id);
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:UserAutoMoveTroopsBunkerItem = new UserAutoMoveTroopsBunkerItem();
        _loc2_.itemType = param1.price.blackCrystals > 0 ? int(BlackMarketItemType.USER_AUTO_MOVE_TROOPS_BUNKER_BC) : int(BlackMarketItemType.USER_AUTO_MOVE_TROOPS_BUNKER);
        _loc2_.id = param1.id;
        _loc2_.price = param1.price;
        _loc2_.newUntil = param1.newUntil;
        _loc2_.saleProhibited = param1.saleProhibited;
        _loc2_.iconUrl = buildImageUrl(_loc2_);
        _loc2_.timeSeconds = param1.effectData.timeSeconds;
        fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
