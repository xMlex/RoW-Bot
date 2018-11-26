package model.data.map {
import gameObjects.observableObject.ObservableObject;

public class UserMapData extends ObservableObject {

    public static const CLASS_NAME:String = "UserMapData";

    public static const LAST_TELEPORTATION_DATE_CHANGED:String = CLASS_NAME + "LastTeleportationDateChanged";


    public var lastTeleportationTime:Date;

    public var lastRandomTeleportationTime:Date;

    public var dateDirty:Boolean;

    public function UserMapData() {
        super();
    }

    public static function fromDto(param1:*):UserMapData {
        if (param1 == null) {
            return null;
        }
        var _loc2_:UserMapData = new UserMapData();
        _loc2_.lastTeleportationTime = param1.l == null ? null : new Date(param1.l);
        _loc2_.lastRandomTeleportationTime = param1.r == null ? null : new Date(param1.r);
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dateDirty) {
            this.dateDirty = false;
            dispatchEvent(LAST_TELEPORTATION_DATE_CHANGED);
        }
    }
}
}
