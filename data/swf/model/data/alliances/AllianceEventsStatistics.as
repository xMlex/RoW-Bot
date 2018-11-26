package model.data.alliances {
import common.ArrayCustom;

import model.data.UserPrize;

public class AllianceEventsStatistics {


    public var allianceId:int;

    public var type:int;

    public var startDate:Date;

    public var finishDate:Date;

    public var ownTotalScores:Number;

    public var oppositeTotalScores:Number;

    public var values:ArrayCustom;

    public var prizeForEveryWinnerMember:UserPrize;

    public function AllianceEventsStatistics() {
        super();
    }

    public static function fromDto(param1:*):AllianceEventsStatistics {
        var _loc2_:AllianceEventsStatistics = new AllianceEventsStatistics();
        _loc2_.allianceId = param1.i;
        _loc2_.type = param1.t;
        _loc2_.startDate = param1.b == null ? null : new Date(param1.b);
        _loc2_.finishDate = param1.e == null ? null : new Date(param1.e);
        _loc2_.values = param1.s == null ? new ArrayCustom() : WarStatisticsValue.fromDtos(param1.s);
        _loc2_.ownTotalScores = param1.o;
        _loc2_.oppositeTotalScores = param1.d;
        _loc2_.prizeForEveryWinnerMember = param1.v == null ? null : UserPrize.fromDto(param1.v);
        return _loc2_;
    }
}
}
