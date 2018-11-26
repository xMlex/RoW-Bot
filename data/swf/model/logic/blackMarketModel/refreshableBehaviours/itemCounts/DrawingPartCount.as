package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import model.data.scenes.objects.GeoSceneObject;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;

public class DrawingPartCount extends DynamicStateObject implements IDynamicInteger {


    private var _value:int;

    private var _itemId:int;

    private var _partNumber:int;

    public function DrawingPartCount(param1:int, param2:int) {
        super();
        this._itemId = param1;
        this._partNumber = param2;
    }

    public function get value():int {
        return this._value;
    }

    public function refresh():void {
        var _loc1_:GeoSceneObject = UserManager.user.gameData.drawingArchive.getDrawing(this._itemId);
        if (!_loc1_) {
            _loc1_ = GeoSceneObject.makeDrawing(StaticDataManager.getObjectType(this._itemId));
        }
        this._value = _loc1_.drawingInfo.drawingParts[this._partNumber];
    }
}
}
