package model.data.alliances.membership {
import common.ArrayCustom;

public class MobilizerHistory {


    public var userId:Number;

    public var date:Date;

    public var mobilizersCount:int;

    public function MobilizerHistory() {
        super();
    }

    public static function fromDto(param1:*):MobilizerHistory {
        var _loc2_:MobilizerHistory = new MobilizerHistory();
        _loc2_.userId = param1.u;
        _loc2_.date = new Date(param1.d);
        _loc2_.mobilizersCount = param1.c;
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        if (param1 != null) {
            for each(_loc3_ in param1) {
                _loc2_.addItem(fromDto(_loc3_));
            }
        }
        return _loc2_;
    }
}
}
