package model.data.alliances {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

public class AllianceAppearanceData extends ObservableObject {

    public static const CLASS_NAME:String = "AllianceAppearanceData";

    public static const APPEARANCE_CHANGED:String = CLASS_NAME + "AppearanceChanged";


    public var description:String;

    public var extendedDescription:String;

    public var flag:String;

    public var shortName:String;

    public var dirty:Boolean = false;

    public function AllianceAppearanceData() {
        super();
    }

    public static function fromDto(param1:*):AllianceAppearanceData {
        var _loc2_:AllianceAppearanceData = new AllianceAppearanceData();
        _loc2_.description = param1.d;
        _loc2_.extendedDescription = param1.e;
        _loc2_.flag = param1.f;
        _loc2_.shortName = param1.s;
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
        var _loc3_:AllianceAppearanceData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(APPEARANCE_CHANGED);
        }
    }

    public function toDto():* {
        var _loc1_:* = {
            "d": this.description,
            "f": this.flag,
            "e": this.extendedDescription,
            "s": this.shortName
        };
        return _loc1_;
    }
}
}
