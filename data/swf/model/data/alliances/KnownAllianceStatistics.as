package model.data.alliances {
import common.ArrayCustom;

public class KnownAllianceStatistics {


    public var allianceId:int;

    public var type:int;

    public var startDate:Date;

    public var finishDate:Date;

    public var ownTotalScores:Number;

    public var oppositeTotalScores:Number;

    public var winnerTotalScores:Number;

    public var values:ArrayCustom;

    public function KnownAllianceStatistics() {
        super();
    }

    public static function fromDto(param1:*):KnownAllianceStatistics {
        var _loc2_:KnownAllianceStatistics = new KnownAllianceStatistics();
        _loc2_.allianceId = param1.i;
        _loc2_.type = param1.t;
        _loc2_.startDate = param1.b == null ? null : new Date(param1.b);
        _loc2_.finishDate = param1.e == null ? null : new Date(param1.e);
        _loc2_.values = param1.s == null ? new ArrayCustom() : WarStatisticsValue.fromDtos(param1.s);
        _loc2_.ownTotalScores = param1.o == null ? Number(0) : Number(param1.o);
        _loc2_.oppositeTotalScores = param1.d == null ? Number(0) : Number(param1.d);
        _loc2_.winnerTotalScores = _loc2_.ownTotalScores >= _loc2_.oppositeTotalScores ? Number(_loc2_.ownTotalScores) : Number(_loc2_.oppositeTotalScores);
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
