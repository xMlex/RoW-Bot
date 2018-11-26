package model.data.scenes.objects.info {
import common.ArrayCustom;

public class TroopsObjInfo {


    public var count:int;

    public function TroopsObjInfo() {
        super();
    }

    public static function fromDto(param1:*):TroopsObjInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:TroopsObjInfo = new TroopsObjInfo();
        _loc2_.count = param1.c;
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
        var _loc3_:TroopsObjInfo = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {"c": this.count};
        return _loc1_;
    }
}
}
