package model.data.users.misc {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

public final class UserCyborgData extends ObservableObject {

    public static const CLASS_NAME:String = "UserCyborgData";

    public static const CHANGED:String = CLASS_NAME + "Changed";


    public var cyborgUserIds:ArrayCustom;

    public var createdCyborgForUserIds:ArrayCustom;

    public var cyborgsCreated:int;

    public var cyborgsCreatedByOtherUsers:int;

    public var dirty:Boolean = true;

    public function UserCyborgData() {
        super();
    }

    public static function fromDto(param1:Object):UserCyborgData {
        var _loc2_:UserCyborgData = new UserCyborgData();
        _loc2_.cyborgUserIds = new ArrayCustom(param1.u);
        _loc2_.createdCyborgForUserIds = new ArrayCustom(param1.o);
        _loc2_.cyborgsCreated = param1.c;
        _loc2_.cyborgsCreatedByOtherUsers = param1.f;
        return _loc2_;
    }

    public static function toDto(param1:UserCyborgData):Object {
        var _loc2_:Object = {
            "u": param1.cyborgUserIds,
            "o": param1.createdCyborgForUserIds,
            "c": param1.cyborgsCreated,
            "f": param1.cyborgsCreatedByOtherUsers
        };
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(CHANGED);
        }
    }
}
}
