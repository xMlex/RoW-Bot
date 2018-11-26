package model.logic.blackMarketModel.refreshableBehaviours.buyLimits {
import model.data.User;
import model.logic.StaticBlackMarketData;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicBoolean;
import model.logic.filterSystem.dataProviders.IIDProvider;

public class BuildingBuyLimitChecker implements IDynamicBoolean {


    private var _value:Boolean;

    private var _itemId:int;

    public function BuildingBuyLimitChecker(param1:IIDProvider) {
        super();
        this._itemId = param1.id;
    }

    public function get value():Boolean {
        return this._value;
    }

    public function refresh():void {
        this._value = !this.canBuyBuilding();
    }

    private function canBuyBuilding():Boolean {
        var _loc1_:User = UserManager.user;
        var _loc2_:StaticBlackMarketData = StaticDataManager.blackMarketData;
        if (_loc1_.gameData.blackMarketData.buildingsPurchasesCount >= _loc2_.buildingsPurchasesDailyLimit) {
            return false;
        }
        if (_loc2_.totalLimitBySceneObjectTypeId[this._itemId] == null) {
            return false;
        }
        var _loc3_:int = _loc1_.gameData.blackMarketData.boughtCountBySceneObjectTypeId[this._itemId] == null ? 0 : int(_loc1_.gameData.blackMarketData.boughtCountBySceneObjectTypeId[this._itemId]);
        if (_loc3_ >= _loc2_.totalLimitBySceneObjectTypeId[this._itemId]) {
            return false;
        }
        return true;
    }
}
}
