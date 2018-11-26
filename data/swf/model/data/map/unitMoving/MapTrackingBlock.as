package model.data.map.unitMoving {
public class MapTrackingBlock {


    public var id:int;

    public var mapHash:int;

    public var unitsHash:int;

    public function MapTrackingBlock() {
        super();
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:*):Array {
        var _loc3_:MapTrackingBlock = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public static function fromDto(param1:*):MapTrackingBlock {
        if (param1 == null) {
            return null;
        }
        var _loc2_:MapTrackingBlock = new MapTrackingBlock();
        _loc2_.id = param1.i;
        _loc2_.mapHash = param1.m;
        _loc2_.unitsHash = param1.u;
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.id,
            "m": this.mapHash,
            "u": this.unitsHash
        };
        return _loc1_;
    }
}
}
