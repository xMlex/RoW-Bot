package model.data.alliances.city {
import model.data.locations.allianceCity.flags.AllianceCityFlag;

public class AllianceCityBattleFlagResult {


    public var attackerAllianceId:Number;

    public var tournamentId:int;

    public var flagsSnatched:Vector.<AllianceCityFlag>;

    public function AllianceCityBattleFlagResult() {
        super();
    }

    public static function fromDto(param1:*):AllianceCityBattleFlagResult {
        if (param1 == null) {
            return null;
        }
        var _loc2_:AllianceCityBattleFlagResult = new AllianceCityBattleFlagResult();
        _loc2_.attackerAllianceId = param1.a;
        _loc2_.tournamentId = param1.t;
        _loc2_.flagsSnatched = param1.f == null ? null : AllianceCityFlag.fromDtos(param1.f);
        return _loc2_;
    }
}
}
