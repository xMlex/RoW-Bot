package model.logic.skills.data {
import common.ArrayCustom;

public class SkillLevelInfo {


    public var effectValue:Number;

    public var improvementSeconds:Number;

    public function SkillLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):SkillLevelInfo {
        var _loc2_:SkillLevelInfo = new SkillLevelInfo();
        _loc2_.effectValue = param1.v;
        _loc2_.improvementSeconds = param1.t;
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
        var _loc3_:SkillLevelInfo = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "v": this.effectValue,
            "t": this.improvementSeconds
        };
        return _loc1_;
    }
}
}
