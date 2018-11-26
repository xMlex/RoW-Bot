package model.logic.blackMarketModel.refreshableBehaviours.locks {
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicBoolean;
import model.logic.commands.sector.BuyBlackMarketOfferCmd;

public class BlackCrystalDrawingLockChecker implements IDynamicBoolean {


    private var _value:Boolean;

    private var _itemId:int;

    public function BlackCrystalDrawingLockChecker(param1:int) {
        super();
        this._itemId = param1;
    }

    public function get value():Boolean {
        return this._value;
    }

    public function refresh():void {
        var _loc1_:GeoSceneObjectType = StaticDataManager.getObjectType(this._itemId);
        var _loc2_:Array = BuyBlackMarketOfferCmd.getBlackCrystalAllTechnologies();
        this._value = _loc2_.getItemIndex(_loc1_) == -1;
    }
}
}
