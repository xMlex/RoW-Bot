package model.data.alliances {
import common.ArrayCustom;

public class AllianceEvent {


    public var firstAllianceId:Number;

    public var secondAllianceId:Number;

    public var firstAllianceScores:Number;

    public var secondAllianceScores:Number;

    public var winnerTotalScores:Number;

    public var type:int;

    public var startDate:Date;

    public var finishDate:Date;

    public var values:ArrayCustom;

    public function AllianceEvent() {
        super();
    }

    public static function fromDto(param1:*):AllianceEvent {
        var _loc2_:AllianceEvent = new AllianceEvent();
        _loc2_.firstAllianceId = param1.f == null ? Number(0) : Number(param1.f);
        _loc2_.secondAllianceId = param1.s == null ? Number(0) : Number(param1.s);
        _loc2_.firstAllianceScores = param1.e == null || param1.e.o == null ? Number(0) : Number(param1.e.o);
        _loc2_.secondAllianceScores = param1.e == null || param1.e.d == null ? Number(0) : Number(param1.e.d);
        _loc2_.winnerTotalScores = param1.e == null || param1.e.r == null ? Number(0) : Number(param1.e.r);
        _loc2_.type = param1.e == null || param1.e.t == null ? 0 : int(param1.e.t);
        _loc2_.startDate = param1.e == null || param1.e.s == null ? null : new Date(param1.e.s);
        _loc2_.finishDate = param1.e == null || param1.e.f == null ? null : new Date(param1.e.f);
        _loc2_.values = param1.e == null || param1.e.v == null ? new ArrayCustom() : WarStatisticsValue.fromDtos(param1.e.v);
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
