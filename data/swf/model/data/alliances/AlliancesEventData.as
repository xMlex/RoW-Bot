package model.data.alliances {
import common.ArrayCustom;

public class AlliancesEventData {


    public var activeEvents:ArrayCustom;

    public var finishedEvents:ArrayCustom;

    public function AlliancesEventData() {
        super();
    }

    public static function fromDto(param1:*):AlliancesEventData {
        var _loc2_:AlliancesEventData = new AlliancesEventData();
        _loc2_.activeEvents = param1.w == null ? new ArrayCustom() : KnownAllianceStatistics.fromDtos(param1.w);
        _loc2_.finishedEvents = param1.c == null ? new ArrayCustom() : KnownAllianceStatistics.fromDtos(param1.c);
        return _loc2_;
    }
}
}
