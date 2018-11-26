package model.data.alliances {
import flash.utils.Dictionary;

public class EnemyUserStatistics {


    public var userId:Number;

    public var allianceId:Number;

    public var points:Number;

    public function EnemyUserStatistics() {
        super();
    }

    public static function fromDto(param1:*):EnemyUserStatistics {
        var _loc2_:EnemyUserStatistics = new EnemyUserStatistics();
        _loc2_.userId = param1.u;
        _loc2_.allianceId = param1.a;
        _loc2_.points = param1.p;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Dictionary {
        var _loc3_:* = undefined;
        var _loc2_:Dictionary = new Dictionary();
        for (_loc3_ in param1) {
            _loc2_[_loc3_] = fromDto(param1[_loc3_]);
        }
        return _loc2_;
    }
}
}
