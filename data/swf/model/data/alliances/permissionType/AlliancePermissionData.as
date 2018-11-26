package model.data.alliances.permissionType {
import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

public class AlliancePermissionData extends ObservableObject {

    public static const CLASS_NAME:String = "AlliancePermissionData";

    public static const ALLIANCE_PERMISSION_DATA_CHANGED:String = CLASS_NAME + "AlliancePermissionDataChanged";


    public var permissionByRank:Object;

    public var permissionByUserId:Dictionary;

    public var dirty:Boolean = false;

    public function AlliancePermissionData() {
        this.permissionByUserId = new Dictionary();
        super();
    }

    public static function fromDto(param1:*):AlliancePermissionData {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc2_:AlliancePermissionData = new AlliancePermissionData();
        if (param1.p != null) {
            _loc2_.permissionByRank = new Object();
            for (_loc3_ in param1.p) {
                _loc2_.permissionByRank[_loc3_] = param1.p[_loc3_];
            }
        }
        if (param1.l != null) {
            for (_loc4_ in param1.l) {
                _loc2_.permissionByUserId[_loc4_] = param1.l[_loc4_];
            }
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(ALLIANCE_PERMISSION_DATA_CHANGED);
        }
    }
}
}
