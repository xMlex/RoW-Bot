package model.logic.blackMarketModel.builders {
import common.GameType;

import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.TroopsGroupId;
import model.data.scenes.types.info.TroopsTypeId;
import model.logic.StaticDataManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.UnitItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;
import model.logic.blackMarketModel.interfaces.IDiscountContext;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;
import model.logic.blackMarketModel.refreshableBehaviours.dates.ExpirableDate;
import model.logic.blackMarketModel.validation.ItemDateValidator;
import model.logic.blackMarketModel.validation.interfaces.IBlackMarketValidator;
import model.logic.troops.TroopsManager;

public class UnitBuilder implements IBlackMarketItemBuilder {


    private var _validator:IBlackMarketValidator;

    public function UnitBuilder() {
        super();
        this._validator = new ItemDateValidator();
    }

    public static function buildOffence(param1:GeoSceneObjectType):Number {
        var _loc2_:Number = param1.troopBaseParameters.attackPower;
        if (!param1.isMissile) {
            _loc2_ = _loc2_ + _loc2_ * TroopsManager.getAttackBonus(param1.id) / 100;
        }
        return Number((Math.round(_loc2_ * 10) * 0.1).toFixed(1));
    }

    public static function buildDefence(param1:GeoSceneObjectType):Number {
        var _loc2_:Number = TroopsManager.getAverageDefenceWithBonuses(param1.troopBaseParameters.defenseParameters, param1.id);
        return Number((Math.round(_loc2_ * 10) * 0.1).toFixed(1));
    }

    public static function buildIntelligence(param1:GeoSceneObjectType):Number {
        var _loc2_:Number = param1.troopBaseParameters.reconPower;
        if (!param1.isMissile) {
            _loc2_ = _loc2_ + _loc2_ * TroopsManager.getAttackBonus(param1.id) / 100;
        }
        return Number((Math.round(_loc2_ * 10) * 0.1).toFixed(1));
    }

    protected function buildInstance():UnitItem {
        return new UnitItem();
    }

    protected function buildRequiredLevel(param1:GeoSceneObjectType):int {
        var _loc2_:* = param1.troopsInfo.groupId == TroopsGroupId.MISSILE;
        if (_loc2_) {
            return StaticDataManager.blackMarketData.missilesMinimalUserLevel;
        }
        return StaticDataManager.blackMarketData.troopsMinimalUserLevel;
    }

    protected function buildIconUrl(param1:GeoSceneObjectType):String {
        var _loc2_:String = param1.getUrlForShop();
        if (GameType.isMilitary) {
            if (TroopsTypeId.isAlien(param1.id) || TroopsTypeId.isPredator(param1.id) || TroopsTypeId.isAvpRecon(param1.id)) {
                _loc2_ = _loc2_.replace("_p", "_bm");
            }
            else {
                _loc2_ = _loc2_.replace(".jpg", ".png");
            }
        }
        if (GameType.isNords) {
            _loc2_ = _loc2_.replace("p.jpg", "p.swf");
        }
        return _loc2_;
    }

    protected function buildEndDate(param1:BlackMarketItemRaw):IDynamicDate {
        var _loc2_:IDynamicDate = new ExpirableDate();
        _loc2_.value = param1.troopsType.saleToDate;
        return _loc2_;
    }

    protected function buildStartDate(param1:BlackMarketItemRaw):IDynamicDate {
        var _loc2_:IDynamicDate = new ExpirableDate();
        _loc2_.value = param1.troopsType.saleFromDate;
        return _loc2_;
    }

    protected function buildMaxCount(param1:BlackMarketItemRaw):int {
        return param1.troopsType.maxCount;
    }

    protected function buildMinCount(param1:BlackMarketItemRaw):int {
        return param1.troopsType.minCount;
    }

    protected function buildSaleProhibited(param1:BlackMarketItemRaw):Boolean {
        return param1.troopsType.saleProhibited;
    }

    protected function buildDiscount(param1:BlackMarketItemRaw):IDiscountContext {
        return null;
    }

    protected function buildPrice(param1:BlackMarketItemBase):void {
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:GeoSceneObjectType = param1.geoSceneObjectType;
        var _loc3_:UnitItem = this.buildInstance();
        var _loc4_:IDiscountContext = this.buildDiscount(param1);
        if (_loc4_ != null) {
            _loc3_.discountContext = _loc4_;
        }
        _loc3_.date = this.buildEndDate(param1);
        _loc3_.startDate = this.buildStartDate(param1);
        if (!this._validator.validate(_loc3_)) {
            return null;
        }
        _loc3_.id = param1.id;
        _loc3_.price = param1.price;
        this.buildPrice(_loc3_);
        _loc3_.iconUrl = this.buildIconUrl(_loc2_);
        _loc3_.name = _loc2_.name;
        _loc3_.fullName = _loc3_.fullName;
        _loc3_.newUntil = param1.newUntil;
        _loc3_.saleProhibited = param1.saleProhibited;
        _loc3_.maxCount = this.buildMaxCount(param1);
        _loc3_.minCount = this.buildMinCount(param1);
        _loc3_.saleProhibited = this.buildSaleProhibited(param1);
        _loc3_.requiredLevel = this.buildRequiredLevel(_loc2_);
        _loc3_.isStrategy = _loc2_.isStrategyUnit;
        _loc3_.isMutant = _loc2_.isMutant;
        var _loc5_:Boolean = _loc2_.troopsInfo.isAttacking;
        var _loc6_:Boolean = _loc2_.troopsInfo.isDefensive;
        var _loc7_:Boolean = _loc2_.troopsInfo.isRecon;
        _loc3_.attackBonus = !!_loc5_ ? int(buildOffence(_loc2_)) : 0;
        _loc3_.defenceBonus = !!_loc6_ ? Number(buildDefence(_loc2_)) : Number(0);
        _loc3_.intelligenceBonus = !!_loc7_ ? Number(buildIntelligence(_loc2_)) : Number(0);
        _loc3_.groupId = _loc2_.troopsInfo.groupId;
        return _loc3_;
    }
}
}
