package model.data.alliances {
import common.ArrayCustom;

public class AllianceAchievement {


    public var typeId:int;

    public var value:Number;

    public var level:int;

    public function AllianceAchievement() {
        super();
    }

    public static function fromDto(param1:*):AllianceAchievement {
        var _loc2_:AllianceAchievement = new AllianceAchievement();
        _loc2_.typeId = param1.i;
        _loc2_.value = param1.v;
        _loc2_.level = param1.c;
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
}
}
