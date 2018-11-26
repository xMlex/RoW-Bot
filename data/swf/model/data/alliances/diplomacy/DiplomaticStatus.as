package model.data.alliances.diplomacy {
import common.ArrayCustom;

public class DiplomaticStatus {


    public var allianceId:Number;

    public var typeId:int;

    public var description:String;

    public function DiplomaticStatus() {
        super();
    }

    public static function fromDto(param1:*):DiplomaticStatus {
        var _loc2_:DiplomaticStatus = new DiplomaticStatus();
        _loc2_.allianceId = param1.i;
        _loc2_.typeId = param1.s;
        _loc2_.description = param1.d;
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
        var _loc3_:DiplomaticStatus = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.allianceId,
            "s": this.typeId
        };
        if (this.description) {
            _loc1_.d = this.description;
        }
        return _loc1_;
    }
}
}
