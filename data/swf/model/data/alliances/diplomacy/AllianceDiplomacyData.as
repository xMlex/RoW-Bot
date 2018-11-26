package model.data.alliances.diplomacy {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

public class AllianceDiplomacyData extends ObservableObject {

    public static const CLASS_NAME:String = "AllianceDiplomacyData";

    public static const DIPLOMATIC_STATUSES_CHANGED:String = CLASS_NAME + "DiplomaticStatusesChanged";


    public var diplomaticStatuses:ArrayCustom;

    public var dirty:Boolean = false;

    public function AllianceDiplomacyData() {
        super();
    }

    public static function fromDto(param1:*):AllianceDiplomacyData {
        var _loc2_:AllianceDiplomacyData = new AllianceDiplomacyData();
        _loc2_.diplomaticStatuses = DiplomaticStatus.fromDtos(param1.s);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:AllianceDiplomacyData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(DIPLOMATIC_STATUSES_CHANGED);
        }
    }

    public function getStatus(param1:Number):DiplomaticStatus {
        var _loc2_:DiplomaticStatus = null;
        for each(_loc2_ in this.diplomaticStatuses) {
            if (_loc2_.allianceId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function toDto():* {
        var _loc1_:* = {"s": (this.diplomaticStatuses == null ? null : DiplomaticStatus.toDtos(this.diplomaticStatuses))};
        return _loc1_;
    }
}
}
