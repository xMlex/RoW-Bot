package model.logic.blackMarketModel.builders {
import common.GameType;
import common.StringUtil;
import common.localization.LocaleUtil;

import configs.Global;

import integration.SocialNetworkIdentifier;

import model.data.ResourceTypeId;
import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.ResourcePackItem;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.StubDiscountContext;

public class ResourcePackBuilder implements IBlackMarketItemBuilder {


    public function ResourcePackBuilder() {
        super();
    }

    protected function buildName(param1:ResourcePackItem):String {
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
                break;
            case ResourceTypeId.BIOCHIPS:
                _loc2_ = LocaleUtil.getText("forms-formHelp_biochips_header");
                break;
            case ResourceTypeId.AVP_MONEY:
                _loc2_ = LocaleUtil.getText("form-weylandLab_artifactsTab_title");
                break;
            case ResourceTypeId.CONSTRUCTION_ITEMS:
                _loc2_ = LocaleUtil.getText("forms-common_constructionItem");
        }
        return _loc2_;
    }

    protected function buildImageUrl(param1:ResourcePackItem):String {
        var _loc2_:String = null;
        var _loc3_:String = null;
        switch (param1.type) {
            case ResourceTypeId.URANIUM:
                _loc2_ = "uranium";
                break;
            case ResourceTypeId.TITANITE:
                _loc2_ = "titanite";
                break;
            case ResourceTypeId.MONEY:
                _loc2_ = "money";
                break;
            case ResourceTypeId.BIOCHIPS:
                _loc2_ = "biochips";
                break;
            case ResourceTypeId.AVP_MONEY:
                _loc2_ = "avp";
                break;
            case ResourceTypeId.CONSTRUCTION_ITEMS:
                _loc2_ = "constructionItems";
        }
        if (GameType.isTotalDomination || param1.type == ResourceTypeId.BIOCHIPS && (GameType.isElves || GameType.isSparta || GameType.isPirates)) {
            _loc3_ = RewardUrl.JPEG;
        }
        else {
            _loc3_ = RewardUrl.PNG;
        }
        return new RewardUrl(_loc2_).build(RewardUrl.BM, _loc3_);
    }

    protected function fillLocaleData(param1:ResourcePackItem):void {
        param1.name = this.buildName(param1);
        var _loc2_:int = !!param1.resources.uranium ? int(param1.resources.uranium) : !!param1.resources.titanite ? int(param1.resources.titanite) : !!param1.resources.money ? int(param1.resources.money) : !!param1.resources.avpMoney ? int(param1.resources.avpMoney) : !!param1.resources.biochips ? int(param1.resources.biochips) : !!param1.resources.constructionItems ? int(param1.resources.constructionItems) : 0;
        param1.fullName = param1.name + " (" + _loc2_.toString() + ")";
        param1.helpText = this.buildHelpText(param1);
    }

    protected function buildHelpText(param1:ResourcePackItem):String {
        var _loc2_:String = StringUtil.EMPTY;
        switch (param1.type) {
            case ResourceTypeId.CONSTRUCTION_ITEMS:
                if (SocialNetworkIdentifier.isFB && (GameType.isElves || GameType.isPirates)) {
                    _loc2_ = LocaleUtil.getText("forms-formBlackMarket_constructionItems_toolTip_fb");
                }
                else {
                    _loc2_ = !!Global.ADDITIONAL_BUILDINGS_LEVELS_VOL2_ENABLED ? LocaleUtil.getText("forms-formBlackMarket_constructionItems_toolTip_newbuildinglevelsVol2") : LocaleUtil.getText("forms-formBlackMarket_constructionItems_toolTip");
                }
        }
        return _loc2_;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:ResourcePackItem = new ResourcePackItem();
        _loc2_.id = param1.id;
        _loc2_.itemType = BlackMarketItemType.RESOURCE_PACK;
        _loc2_.price = param1.price;
        if (_loc2_.price == null) {
            _loc2_.discountContext = new StubDiscountContext();
        }
        _loc2_.name = param1.name;
        _loc2_.newUntil = param1.newUntil;
        _loc2_.saleProhibited = param1.saleProhibited;
        _loc2_.resources = param1.resourcesData.resources;
        _loc2_.type = _loc2_.resources.uranium > 0 ? int(ResourceTypeId.URANIUM) : _loc2_.resources.titanite > 0 ? int(ResourceTypeId.TITANITE) : _loc2_.resources.money > 0 ? int(ResourceTypeId.MONEY) : _loc2_.resources.constructionItems > 0 ? int(ResourceTypeId.CONSTRUCTION_ITEMS) : _loc2_.resources.biochips > 0 ? int(ResourceTypeId.BIOCHIPS) : _loc2_.resources.avpMoney > 0 ? int(ResourceTypeId.AVP_MONEY) : -1;
        _loc2_.iconUrl = this.buildImageUrl(_loc2_);
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
