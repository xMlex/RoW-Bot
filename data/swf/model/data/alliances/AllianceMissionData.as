package model.data.alliances {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

public class AllianceMissionData extends ObservableObject {

    public static const CLASS_NAME:String = "AllianceMissionData";

    public static const MISSIONS_DATA_CHANGED:String = CLASS_NAME + "MissionsDataChanged";


    public var missions:ArrayCustom;

    public var dirty:Boolean = false;

    public function AllianceMissionData() {
        super();
    }

    public static function fromDto(param1:*):AllianceMissionData {
        var _loc2_:AllianceMissionData = new AllianceMissionData();
        _loc2_.missions = param1.m == null ? new ArrayCustom() : AllianceMission.fromDtos(param1.m);
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(MISSIONS_DATA_CHANGED);
        }
    }
}
}
