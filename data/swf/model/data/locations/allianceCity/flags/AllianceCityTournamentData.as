package model.data.locations.allianceCity.flags {
import flash.utils.Dictionary;

public class AllianceCityTournamentData {


    public var cooloffData:AllianceCityCooloffData;

    public var tournamentFlags:Vector.<AllianceCityFlag>;

    public var tournamentFlagsLocations:Vector.<AllianceCityFlagLocation>;

    public var tournamentIdToLeague:Dictionary;

    public var activeTournamentIds:Array;

    public function AllianceCityTournamentData() {
        super();
    }

    public static function fromDto(param1:*):AllianceCityTournamentData {
        var _loc3_:* = undefined;
        var _loc2_:AllianceCityTournamentData = new AllianceCityTournamentData();
        _loc2_.cooloffData = !!param1.c ? AllianceCityCooloffData.fromDto(param1.c) : null;
        _loc2_.tournamentFlags = !!param1.f ? AllianceCityFlag.fromDtos(param1.f) : new Vector.<AllianceCityFlag>();
        _loc2_.tournamentFlagsLocations = !!param1.l ? AllianceCityFlagLocation.fromDtos(param1.l) : new Vector.<AllianceCityFlagLocation>();
        if (param1.g) {
            _loc2_.tournamentIdToLeague = new Dictionary();
            for (_loc3_ in param1.g) {
                _loc2_.tournamentIdToLeague[_loc3_] = param1.g[_loc3_];
            }
        }
        _loc2_.activeTournamentIds = param1.a;
        return _loc2_;
    }
}
}
