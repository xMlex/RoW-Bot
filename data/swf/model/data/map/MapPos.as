package model.data.map {
import common.ArrayCustom;

public class MapPos {


    public var x:int;

    public var y:int;

    public function MapPos(param1:int = 0, param2:int = 0) {
        super();
        this.x = param1;
        this.y = param2;
    }

    public static function fromDto(param1:*):MapPos {
        if (param1 == null) {
            return null;
        }
        var _loc2_:MapPos = new MapPos();
        _loc2_.x = param1.x;
        _loc2_.y = param1.y;
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
        var _loc3_:MapPos = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function isEqual(param1:MapPos):Boolean {
        return this == param1 || this.x == param1.x && this.y == param1.y;
    }

    public function toDto():* {
        var _loc1_:* = {
            "x": this.x,
            "y": this.y
        };
        return _loc1_;
    }

    public function toString():String {
        return "MapPos[" + this.x + ", " + this.y + "]";
    }

    public function getString():String {
        return "(" + "x: " + this.x + "; " + "y: " + this.y + ")";
    }

    public function clone():MapPos {
        return new MapPos(this.x, this.y);
    }

    public function distance(param1:MapPos):Number {
        return Math.sqrt((this.x - param1.x) * (this.x - param1.x) + (this.y - param1.y) * (this.y - param1.y));
    }
}
}
