package model.logic.blackMarketModel.refreshableBehaviours.discounts {
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;
import model.logic.blackMarketModel.interfaces.IDiscountContext;
import model.logic.discountOffers.UserDiscountOfferManager;

public class UnitDiscountContext extends DiscountContextBase {


    private var _itemId:int;

    private var _configDiscount:IDiscountContext;

    public var count:int;

    public function UnitDiscountContext(param1:int) {
        super();
        this._configDiscount = new BlackMarketConfigUnitDiscountContext();
        this._itemId = param1;
    }

    override public function refresh():void {
        var _loc2_:Object = null;
        var _loc3_:Boolean = false;
        this._configDiscount.refresh();
        var _loc1_:GeoSceneObjectType = StaticDataManager.getObjectType(this._itemId);
        if (!this._configDiscount.haveDiscount) {
            _loc2_ = UserDiscountOfferManager.discountTroop(_loc1_.robotTroopsId, _loc1_.troopsInfo.groupId, _loc1_.troopsInfo.kindId);
            _discount = _loc2_.discount;
            this.count = _loc2_.count;
            _haveDiscount = _discount > 0 && this.count > 0;
        }
        else {
            _loc3_ = _loc1_.saleableInfo != null && _loc1_.saleableInfo.discountsProhibited;
            _haveDiscount = !_loc3_;
            this.count = -1;
            _discount = this._configDiscount.value;
        }
    }
}
}
