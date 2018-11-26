package model.logic.blackMarketModel.refreshableBehaviours.discounts {
import model.data.Resources;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.discountOffers.UserDiscountOfferManager;
import model.logic.staticDiscount.StaticDiscountManager;

public class BuildingDiscountContext extends DiscountContextBase {


    private var _itemId:int;

    public function BuildingDiscountContext(param1:int) {
        super();
        this._itemId = param1;
    }

    override public function refresh():void {
        var _loc2_:GeoSceneObjectType = null;
        var _loc3_:GeoSceneObject = null;
        var _loc4_:Resources = null;
        _discount = 0;
        var _loc1_:Array = UserDiscountOfferManager.activeDiscountOffers;
        if (_loc1_ && _loc1_.length > 0) {
            _discount = UserDiscountOfferManager.getDiscountCoefficient(this._itemId);
        }
        if (StaticDiscountManager.hasActiveStaticDiscount) {
            _loc2_ = StaticDataManager.getObjectType(this._itemId);
            _loc3_ = UserManager.user.gameData.buyingData.getBuyingObject(_loc2_);
            if (_loc2_ && _loc2_.isRobotORDefenciveBuilding) {
                _loc4_ = UserManager.user.gameData.getPrice(UserManager.user, _loc2_, _loc3_.getNextLevel());
                if (_loc4_.isOnlyGold && StaticDiscountManager.defBuildingsAndRobotsDiscount) {
                    _discount = StaticDiscountManager.defBuildingsAndRobotsDiscount;
                }
            }
            if (_loc2_ && _loc2_.isDecorativeBuilding && StaticDiscountManager.decorativeBuildingsDiscount) {
                _discount = StaticDiscountManager.decorativeBuildingsDiscount;
            }
        }
        _haveDiscount = _discount > 0;
    }
}
}
