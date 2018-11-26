package model.data.locations.allianceCity {
import flash.utils.Dictionary;

import model.data.locations.allianceCity.flags.AllianceCityCooloffData;
import model.data.locations.allianceCity.flags.AllianceCityFlag;

public class LocationCityData {


    public var level:int = 0;

    public var allianceId:int;

    public var timeCreated:Date;

    public var timeDowngrade:Date;

    public var influenceByTechnologies:Number;

    public var tournamentFlags:Vector.<AllianceCityFlag>;

    public var tournamentIdToLeague:Dictionary;

    public var cooloffData:AllianceCityCooloffData;

    public function LocationCityData() {
        super();
    }

    public static function fromDto(param1:*):LocationCityData {
        var _loc3_:* = undefined;
        var _loc2_:LocationCityData = new LocationCityData();
        _loc2_.level = param1.l;
        _loc2_.allianceId = param1.i;
        _loc2_.timeCreated = new Date(param1.c);
        _loc2_.timeDowngrade = new Date(param1.d);
        _loc2_.influenceByTechnologies = param1.t;
        _loc2_.tournamentFlags = param1.tf == null ? null : AllianceCityFlag.fromDtos(param1.tf);
        _loc2_.cooloffData = param1.cd == null ? null : AllianceCityCooloffData.fromDto(param1.cd);
        if (param1.at) {
            _loc2_.tournamentIdToLeague = new Dictionary();
            for (_loc3_ in param1.at) {
                _loc2_.tournamentIdToLeague[_loc3_] = param1.at[_loc3_];
            }
        }
        return _loc2_;
    }
}
}
