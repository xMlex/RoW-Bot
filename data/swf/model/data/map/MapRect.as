package model.data.map {
import common.ArrayCustom;

public class MapRect {


    public var x1:int;

    public var y1:int;

    public var x2:int;

    public var y2:int;

    public function MapRect(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0) {
        super();
        this.x1 = param1;
        this.y1 = param2;
        this.x2 = param3;
        this.y2 = param4;
    }

    public static function fromDto(param1:*):MapRect {
        if (param1 == null) {
            return null;
        }
        var _loc2_:MapRect = new MapRect();
        _loc2_.x1 = param1.x;
        _loc2_.y1 = param1.y;
        _loc2_.x2 = param1.v;
        _loc2_.y2 = param1.u;
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
        var _loc3_:MapRect = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "x": this.x1,
            "y": this.y1,
            "v": this.x2,
            "u": this.y2
        };
        return _loc1_;
    }
}
}
