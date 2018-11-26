package model.logic.skills.data {
import common.ArrayCustom;

public class RequiredSkill {


    public var skillTypeId:int;

    public var requiredLevel:int;

    public function RequiredSkill() {
        super();
    }

    public static function fromDto(param1:*):RequiredSkill {
        var _loc2_:RequiredSkill = new RequiredSkill();
        _loc2_.skillTypeId = param1.i;
        _loc2_.requiredLevel = param1.l;
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
        var _loc3_:RequiredSkill = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.skillTypeId,
            "l": this.requiredLevel
        };
        return _loc1_;
    }
}
}
