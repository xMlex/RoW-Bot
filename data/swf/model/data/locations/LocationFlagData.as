package model.data.locations {
import flash.utils.Dictionary;

import model.data.locations.allianceCity.LocationCityData;
import model.data.locations.allianceCity.flags.AllianceCityCooloffData;
import model.data.locations.allianceCity.flags.AllianceCityFlag;
import model.data.locations.allianceCity.flags.AllianceCityFlagLocation;
import model.data.locations.allianceCity.flags.AllianceCityTournamentData;
import model.logic.AllianceManager;
import model.logic.LocationNoteManager;

public class LocationFlagData {


    public var id:Number;

    public var allianceId:Number;

    public var cooloffData:AllianceCityCooloffData;

    public var tournamentFlags:Vector.<AllianceCityFlag>;

    public var tournamentIdToLeague:Dictionary;

    public var tournamentFlagsLocations:Vector.<AllianceCityFlagLocation>;

    public var activeTournamentIds:Array;

    public function LocationFlagData() {
        super();
    }

    public static function fill(param1:Number):LocationFlagData {
        var _loc2_:LocationFlagData = null;
        if (AllianceManager.currentAllianceCity && param1 == AllianceManager.currentAllianceCity.id) {
            _loc2_ = createMyFlagInfo();
        }
        else {
            _loc2_ = createFlagInfoByNoteId(param1);
        }
        return _loc2_;
    }

    private static function createMyFlagInfo():LocationFlagData {
        var _loc1_:LocationFlagData = new LocationFlagData();
        var _loc2_:AllianceCityTournamentData = AllianceManager.currentAllianceCity.gameData.allianceCityData.tournamentData;
        if (_loc2_) {
            _loc1_.cooloffData = _loc2_.cooloffData;
            _loc1_.tournamentFlags = _loc2_.tournamentFlags;
            _loc1_.tournamentFlagsLocations = _loc2_.tournamentFlagsLocations;
            _loc1_.tournamentIdToLeague = _loc2_.tournamentIdToLeague;
            _loc1_.activeTournamentIds = _loc2_.activeTournamentIds;
        }
        _loc1_.id = AllianceManager.currentAllianceCity.id;
        _loc1_.allianceId = AllianceManager.currentAlliance.id;
        return _loc1_;
    }

    private static function createFlagInfoByNoteId(param1:Number):LocationFlagData {
        var _loc4_:LocationCityData = null;
        var _loc2_:LocationFlagData = new LocationFlagData();
        var _loc3_:LocationNote = LocationNoteManager.getById(param1);
        _loc4_ = _loc3_.allianceCityInfo;
        if (_loc4_) {
            _loc2_.id = param1;
            _loc2_.allianceId = _loc3_.allianceCityInfo.allianceId;
            _loc2_.cooloffData = _loc4_.cooloffData;
            _loc2_.tournamentFlags = _loc4_.tournamentFlags;
            _loc2_.tournamentIdToLeague = _loc4_.tournamentIdToLeague;
        }
        return _loc2_;
    }

    public function update():void {
        if (AllianceManager.currentAllianceCity && this.id == AllianceManager.currentAllianceCity.id) {
            this.updateMyFlagInfo();
        }
        else {
            this.updateFlagInfo();
        }
    }

    private function updateMyFlagInfo():void {
        var _loc1_:AllianceCityTournamentData = AllianceManager.currentAllianceCity.gameData.allianceCityData.tournamentData;
        if (_loc1_) {
            this.cooloffData = _loc1_.cooloffData;
            this.tournamentFlags = _loc1_.tournamentFlags;
            this.tournamentFlagsLocations = _loc1_.tournamentFlagsLocations;
            this.tournamentIdToLeague = _loc1_.tournamentIdToLeague;
            this.activeTournamentIds = _loc1_.activeTournamentIds;
        }
    }

    private function updateFlagInfo():void {
        var _loc1_:LocationNote = LocationNoteManager.getById(this.id);
        var _loc2_:LocationCityData = _loc1_.allianceCityInfo;
        if (_loc2_) {
            this.cooloffData = _loc2_.cooloffData;
            this.tournamentFlags = _loc2_.tournamentFlags;
            this.tournamentIdToLeague = _loc2_.tournamentIdToLeague;
        }
    }
}
}
