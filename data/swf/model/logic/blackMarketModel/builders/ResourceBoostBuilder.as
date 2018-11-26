package model.logic.blackMarketModel.builders {
import common.GameType;
import common.localization.LocaleUtil;

import model.data.ResourceTypeId;
import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ResourceBoostItem;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class ResourceBoostBuilder implements IBlackMarketItemBuilder {


    public function ResourceBoostBuilder() {
        super();
    }

    protected function buildImageUrl(param1:int):String {
        var _loc2_:String = !!GameType.isTotalDomination ? RewardUrl.MEDIUM : RewardUrl.BM;
        var _loc3_:String = !!GameType.isTotalDomination ? RewardUrl.JPEG : RewardUrl.PNG;
        return new BMIRewardUrl(param1).build(_loc2_, _loc3_);
    }

    protected function buildName(param1:ResourceBoostItem):String {
        var _loc2_:String = "[undefined item in black market]";
        switch (param1.type) {
            case ResourceTypeId.URANIUM:
                _loc2_ = LocaleUtil.getText("forms-common_uranium");
                break;
            case ResourceTypeId.TITANITE:
                _loc2_ = LocaleUtil.getText("forms-common_titanite");
                break;
            case ResourceTypeId.MONEY:
                _loc2_ = LocaleUtil.getText("forms-common_money");
        }
        return _loc2_;
    }

    protected function buildShortDescription(param1:ResourceBoostItem):String {
        var _loc2_:String = "[undefined item in black market]";
        switch (param1.type) {
            case ResourceTypeId.URANIUM:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_boostResources_uranium");
                break;
            case ResourceTypeId.TITANITE:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_boostResources_titanite");
                break;
            case ResourceTypeId.MONEY:
                _loc2_ = LocaleUtil.getText("forms-blackMarketItems_boostResources_money");
        }
        return _loc2_;
    }

    protected function fillLocaleData(param1:ResourceBoostItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_boostResourcesHeader");
        param1.fullName = param1.name + " (" + this.buildName(param1) + ")";
        param1.shortDescription = this.buildShortDescription(param1);
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:ResourceBoostItem = new ResourceBoostItem();
        _loc2_.itemType = BlackMarketItemType.RESOURCE_BOOST;
        _loc2_.id = param1.id;
        _loc2_.price = param1.price;
        _loc2_.name = param1.name;
        _loc2_.newUntil = param1.newUntil;
        _loc2_.saleProhibited = param1.saleProhibited;
        _loc2_.resources = param1.resourcesBoostData.resources;
        _loc2_.type = _loc2_.resources.uranium > 0 ? int(ResourceTypeId.URANIUM) : _loc2_.resources.titanite > 0 ? int(ResourceTypeId.TITANITE) : _loc2_.resources.money > 0 ? int(ResourceTypeId.MONEY) : _loc2_.resources.constructionItems > 0 ? int(ResourceTypeId.CONSTRUCTION_ITEMS) : -1;
        _loc2_.duration = param1.resourcesBoostData.durationSeconds;
        _loc2_.boostRatio = 0.25;
        _loc2_.iconUrl = this.buildImageUrl(_loc2_.id);
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
