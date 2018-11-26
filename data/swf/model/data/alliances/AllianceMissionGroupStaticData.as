package model.data.alliances {
import model.logic.dtoSerializer.DtoDeserializer;

public class AllianceMissionGroupStaticData {


    public var requirementMembersCount:int;

    public var missionStepsByStatsType:Object;

    public function AllianceMissionGroupStaticData() {
        super();
    }

    public static function fromDto(param1:*):AllianceMissionGroupStaticData {
        var _loc2_:AllianceMissionGroupStaticData = new AllianceMissionGroupStaticData();
        _loc2_.requirementMembersCount = param1.r;
        _loc2_.missionStepsByStatsType = DtoDeserializer.toObject(param1.i);
        return _loc2_;
    }
}
}
