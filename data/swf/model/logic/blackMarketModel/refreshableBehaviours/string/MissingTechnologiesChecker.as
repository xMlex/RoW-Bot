package model.logic.blackMarketModel.refreshableBehaviours.string {
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicString;

public class MissingTechnologiesChecker implements IDynamicString {


    private var _value:String;

    private var _itemId:int;

    public function MissingTechnologiesChecker(param1:int) {
        super();
        this._itemId = param1;
    }

    public function get value():String {
        return this._value;
    }

    public function refresh():void {
        var _loc1_:Array = UserManager.user.gameData.technologyCenter.getTechnology(this._itemId).missingTechnologies;
        if (!_loc1_ || _loc1_.length == 0) {
            this._value = null;
            return;
        }
        var _loc2_:GeoSceneObjectType = _loc1_[0].type;
        this._value = _loc2_.name;
    }
}
}
