package model.data.locations.allianceCity.flags {
import flash.utils.Dictionary;

public class AllianceCityCooloffData {


    public var nextAttackAvaliableTime:Date;

    public var allianeсIdToAttackAvaliableTime:Dictionary;

    public var allianceIdToCooloffExceptions:Array;

    public function AllianceCityCooloffData() {
        super();
    }

    public static function fromDto(param1:*):AllianceCityCooloffData {
        var _loc3_:* = undefined;
        var _loc2_:AllianceCityCooloffData = new AllianceCityCooloffData();
        _loc2_.nextAttackAvaliableTime = !!param1.l ? new Date(param1.l) : null;
        _loc2_.allianceIdToCooloffExceptions = param1.e;
        if (param1.a) {
            _loc2_.allianeсIdToAttackAvaliableTime = new Dictionary();
            for (_loc3_ in param1.a) {
                _loc2_.allianeсIdToAttackAvaliableTime[_loc3_] = new Date(param1.a[_loc3_]);
            }
        }
        return _loc2_;
    }
}
}
