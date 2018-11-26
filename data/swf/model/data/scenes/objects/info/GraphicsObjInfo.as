package model.data.scenes.objects.info {
import common.ArrayCustom;

public class GraphicsObjInfo {


    public var x:int;

    public var y:int;

    public var isMirrored:Boolean;

    public var slotId:int;

    public function GraphicsObjInfo() {
        super();
    }

    public static function fromDto(param1:*):GraphicsObjInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:GraphicsObjInfo = new GraphicsObjInfo();
        _loc2_.x = param1.x;
        _loc2_.y = param1.y;
        _loc2_.slotId = param1.s;
        _loc2_.isMirrored = param1.m != 0;
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
        var _loc3_:GraphicsObjInfo = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "x": this.x,
            "y": this.y,
            "s": this.slotId,
            "m": this.isMirrored
        };
        return _loc1_;
    }
}
}
