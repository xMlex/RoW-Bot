package model.data.scenes.objects.info {
import common.ArrayCustom;

public class ArtifactObjInfo {


    public var storageId:int;

    public var issued:Date;

    public function ArtifactObjInfo() {
        super();
    }

    public static function fromDto(param1:*):ArtifactObjInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:ArtifactObjInfo = new ArtifactObjInfo();
        _loc2_.storageId = param1.s;
        _loc2_.issued = param1.c == null ? null : new Date(param1.c);
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
        var _loc3_:ArtifactObjInfo = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "s": this.storageId,
            "c": (this.issued == null ? null : this.issued.time)
        };
        return _loc1_;
    }
}
}
