package model.data.users.artifacts {
import common.ArrayCustom;

public class IssuedArtifact {


    public var date:Date;

    public var typeId:int;

    public var lossesPoints:Number;

    public var source:int;

    public function IssuedArtifact() {
        super();
    }

    public static function fromDto(param1:*):IssuedArtifact {
        var _loc2_:IssuedArtifact = new IssuedArtifact();
        _loc2_.date = param1.d == null ? null : new Date(param1.d);
        _loc2_.typeId = param1.i;
        _loc2_.lossesPoints = param1.p == null ? Number(Number.NaN) : Number(param1.p);
        _loc2_.source = param1.s;
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
        var _loc3_:IssuedArtifact = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "d": (this.date == null ? null : this.date.time),
            "i": this.typeId
        };
        return _loc1_;
    }
}
}
