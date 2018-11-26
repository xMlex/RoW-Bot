package model.data.blueLight {
import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

public class UserBlueLightData extends ObservableObject {

    public static const DATA_CHANGED:String = "UserBluelightDataDataChanged";


    public var bluelightByIds:Dictionary;

    public var dirty:Boolean = false;

    public function UserBlueLightData() {
        super();
    }

    public static function fromDto(param1:*):UserBlueLightData {
        var _loc3_:* = undefined;
        var _loc2_:UserBlueLightData = new UserBlueLightData();
        _loc2_.bluelightByIds = new Dictionary();
        if (param1 != null && param1.d != null) {
            for (_loc3_ in param1.d) {
                _loc2_.bluelightByIds[_loc3_] = BlueLightState.fromDto(param1.d[_loc3_]);
            }
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(DATA_CHANGED);
        }
    }

    public function equals(param1:UserBlueLightData):Boolean {
        if (this.count() != param1.count()) {
            return false;
        }
        return true;
    }

    public function count():int {
        var _loc2_:* = undefined;
        var _loc1_:int = 0;
        for each(_loc2_ in this.bluelightByIds) {
            _loc1_++;
        }
        return _loc1_;
    }
}
}
