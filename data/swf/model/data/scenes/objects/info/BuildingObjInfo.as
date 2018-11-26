package model.data.scenes.objects.info {
import common.ArrayCustom;

import model.data.Resources;

public class BuildingObjInfo {


    public var canBeBroken:Boolean;

    public var broken:Boolean;

    public var localStorage:Resources;

    public var lastTimeCollected:Date;

    public function BuildingObjInfo() {
        super();
    }

    public static function fromDto(param1:*):BuildingObjInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:BuildingObjInfo = new BuildingObjInfo();
        _loc2_.canBeBroken = param1.b != null;
        if (param1.b != null) {
            _loc2_.broken = param1.b;
        }
        _loc2_.localStorage = param1.s == null ? null : Resources.fromDto(param1.s);
        _loc2_.lastTimeCollected = param1.c == null ? null : new Date(param1.c);
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
        var _loc3_:BuildingObjInfo = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {};
        if (this.canBeBroken) {
            _loc1_.b = this.broken;
        }
        if (this.localStorage != null) {
            _loc1_.s = this.localStorage;
        }
        if (this.lastTimeCollected != null) {
            _loc1_.c = this.lastTimeCollected.time;
        }
        return _loc1_;
    }
}
}
