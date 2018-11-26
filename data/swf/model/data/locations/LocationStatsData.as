package model.data.locations {
import model.data.alliances.AllianceUserTroopsStats;

public class LocationStatsData {


    public var allianceTroopsByUserId:Object;

    public function LocationStatsData() {
        super();
    }

    public static function fromDto(param1:Object):LocationStatsData {
        var _loc2_:LocationStatsData = new LocationStatsData();
        _loc2_.allianceTroopsByUserId = param1["u"] == null ? null : parseAllianceTroopsData(param1["u"]);
        return _loc2_;
    }

    private static function parseAllianceTroopsData(param1:Object):Object {
        var _loc3_:* = null;
        var _loc2_:Object = {};
        for (_loc3_ in param1) {
            _loc2_[_loc3_] = AllianceUserTroopsStats.fromDto(param1[_loc3_]);
        }
        return _loc2_;
    }

    public function getDefencePowerByUserId(param1:Number, param2:Number = -1):int {
        var _loc4_:* = null;
        var _loc3_:int = 0;
        for (_loc4_ in this.allianceTroopsByUserId) {
            if (_loc4_ == param1) {
                _loc3_ = _loc3_ + (this.allianceTroopsByUserId[_loc4_] as AllianceUserTroopsStats).getDefencePower(param2);
            }
        }
        return _loc3_;
    }
}
}
