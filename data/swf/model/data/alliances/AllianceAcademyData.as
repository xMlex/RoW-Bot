package model.data.alliances {
import common.GameType;

import gameObjects.observableObject.ObservableObject;

public class AllianceAcademyData extends ObservableObject {

    public static const CLASS_NAME:String = "AllianceAcademyData";

    public static const ACADEMY_DATA_CHANGED:String = CLASS_NAME + "AcademyDataChanged";

    private static var _max_capacity:int = 10;

    public static const MIN_USER_LEVEL:int = 5;


    public var enabled:Boolean;

    public var minUserLevel:int;

    public var capacity:int;

    public var currentCapacity:int;

    public var dirty:Boolean = false;

    public function AllianceAcademyData() {
        super();
    }

    public static function fromDto(param1:*):AllianceAcademyData {
        var _loc2_:AllianceAcademyData = new AllianceAcademyData();
        _loc2_.enabled = param1.e == null ? false : Boolean(param1.e);
        _loc2_.minUserLevel = param1.l == null ? int(MIN_USER_LEVEL) : int(param1.l);
        _loc2_.capacity = param1.c == null ? int(_max_capacity) : int(param1.c);
        _loc2_.currentCapacity = param1.u == null ? 0 : int(param1.u);
        return _loc2_;
    }

    public static function get max_capacity():int {
        return !!GameType.isNords ? 20 : int(_max_capacity);
    }

    public static function set max_capacity(param1:int):void {
        _max_capacity = param1;
    }

    public function toDto():* {
        return {
            "e": this.enabled,
            "l": this.minUserLevel,
            "c": this.capacity
        };
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(ACADEMY_DATA_CHANGED);
        }
    }
}
}
