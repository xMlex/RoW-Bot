package model.data.scenes.objects.info {
import common.ArrayCustom;

public class DrawingObjInfo {


    public var drawingParts:Array;

    public function DrawingObjInfo() {
        super();
    }

    public static function fromDto(param1:*):DrawingObjInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:DrawingObjInfo = new DrawingObjInfo();
        _loc2_.drawingParts = param1.p;
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
        var _loc3_:DrawingObjInfo = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function get partsCollected():int {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this.drawingParts.length) {
            if (this.drawingParts[_loc2_] > 0) {
                _loc1_++;
            }
            _loc2_++;
        }
        return _loc1_;
    }

    public function isCollected():Boolean {
        var _loc1_:int = 0;
        while (_loc1_ < this.drawingParts.length) {
            if (this.drawingParts[_loc1_] == 0) {
                return false;
            }
            _loc1_++;
        }
        return true;
    }

    public function utilize():void {
        var _loc1_:int = 0;
        while (_loc1_ < this.drawingParts.length) {
            this.drawingParts[_loc1_]--;
            _loc1_++;
        }
    }

    public function toDto():* {
        var _loc1_:* = {"p": this.drawingParts};
        return _loc1_;
    }
}
}
