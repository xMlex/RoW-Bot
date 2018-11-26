package model.logic.blackMarketModel.refreshableBehaviours {
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;
import model.logic.UserLevelManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;

public class BuildingExpierence implements IDynamicInteger {


    private var _itemId:int;

    private var _value:int;

    public function BuildingExpierence(param1:int) {
        super();
        this._itemId = param1;
    }

    public function get value():int {
        return this._value;
    }

    public function refresh():void {
        var _loc1_:GeoSceneObjectType = StaticDataManager.getObjectType(this._itemId);
        var _loc2_:GeoSceneObject = UserManager.user.gameData.buyingData.getBuyingObject(_loc1_);
        this._value = UserLevelManager.getPoints(_loc2_, true);
    }

    public function onChange(param1:Function):void {
    }
}
}
