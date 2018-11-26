package model.data.users.drawings {
import common.ArrayCustom;

public class DrawingPart {


    public var typeId:int;

    public var part:int;

    public var count:int = -1;

    public function DrawingPart() {
        super();
    }

    public static function fromDto(param1:*):DrawingPart {
        var _loc2_:DrawingPart = new DrawingPart();
        _loc2_.typeId = param1.t;
        _loc2_.part = param1.p;
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return new ArrayCustom();
        }
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:DrawingPart = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "t": this.typeId,
            "p": this.part
        };
        return _loc1_;
    }

    public function clone():DrawingPart {
        var _loc1_:DrawingPart = new DrawingPart();
        _loc1_.typeId = this.typeId;
        _loc1_.part = this.part;
        _loc1_.count = this.count;
        return _loc1_;
    }
}
}
