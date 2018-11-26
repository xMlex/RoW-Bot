package model.data.scenes.objects.info {
import common.ArrayCustom;

public class TechnologyObjInfo {


    public function TechnologyObjInfo() {
        super();
    }

    public static function fromDto(param1:*):TechnologyObjInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:TechnologyObjInfo = new TechnologyObjInfo();
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
        var _loc3_:TechnologyObjInfo = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {};
        return _loc1_;
    }
}
}
