package model.logic.flags {
import configs.Global;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import model.data.alliances.AllianceNote;
import model.data.locations.LocationFlagData;
import model.data.locations.LocationNote;
import model.data.locations.allianceCity.flags.AllianceCityFlag;
import model.data.locations.allianceCity.flags.AllianceCityFlagLocation;
import model.logic.AllianceManager;
import model.logic.AllianceNoteManager;
import model.logic.LocationNoteManager;
import model.logic.UserManager;
import model.logic.commands.allianceCity.flags.GetAlliancesTournamentLeague;
import model.logic.quests.data.QuestState;
import model.logic.quests.data.TournamentStatisticsType;
import model.logic.quests.data.UserQuestData;
import model.logic.tournament.GlobalTournamentManager;

public class FlagsTournamentHelper {

    public static const CLASS_NAME:String = "FlagsTournamentHelper";

    public static const FLAG_TOURNAMENT_CHANGED:String = CLASS_NAME + "FlagTournamentChanged";

    private static var _instance:FlagsTournamentHelper;

    private static var _events:EventDispatcher;


    private var _flagsTournament:QuestState;

    public function FlagsTournamentHelper() {
        super();
        if (_instance) {
            throw new Error("FlagsTournamentHelper single tone initialization error.");
        }
    }

    public static function get instance():FlagsTournamentHelper {
        if (!_instance) {
            initialize();
        }
        return _instance;
    }

    private static function initialize():void {
        _instance = new FlagsTournamentHelper();
        _instance.subscribe();
        _instance.refreshTournamentData();
    }

    private static function tournamentDataChanged(param1:Event):void {
        _instance.refreshTournamentData();
    }

    private static function changed(param1:QuestState, param2:QuestState):Boolean {
        return param1 == null && param2 != null || param2 == null && param1 != null || param2 && param1 && param2.timeDeadline != param1.timeDeadline;
    }

    public static function get events():EventDispatcher {
        if (_events == null) {
            _events = new EventDispatcher();
        }
        return _events;
    }

    public function get activeFlagsTournament():QuestState {
        return this._flagsTournament;
    }

    private function subscribe():void {
        UserManager.user.gameData.questData.addEventHandler(UserQuestData.TOURNAMENTS_DATA_CHANGED, tournamentDataChanged);
    }

    private function refreshTournamentData():void {
        var _loc2_:QuestState = null;
        var _loc1_:Array = GlobalTournamentManager.getActiveTournaments(TournamentStatisticsType.AllianceCityFlags);
        if (_loc1_.length > 0) {
            _loc2_ = _loc1_[0];
        }
        else {
            _loc2_ = null;
        }
        if (changed(this._flagsTournament, _loc2_)) {
            this._flagsTournament = _loc2_;
            events.dispatchEvent(new Event(FLAG_TOURNAMENT_CHANGED));
        }
    }

    public function checkForDataExist(param1:Number, param2:Function, param3:Function):void {
        var _loc6_:Number = NaN;
        if (instance.activeFlagsTournament == null) {
            return;
        }
        var _loc4_:LocationNote = LocationNoteManager.getById(param1);
        var _loc5_:int = instance.activeFlagsTournament.prototypeId;
        if (_loc4_.allianceCityInfo.tournamentIdToLeague && _loc4_.allianceCityInfo.tournamentIdToLeague[_loc5_] == 0) {
            param3();
        }
        else if (_loc4_.allianceCityInfo.tournamentIdToLeague == null || _loc4_.allianceCityInfo.tournamentIdToLeague[_loc5_] == null) {
            _loc6_ = _loc4_.allianceCityInfo.allianceId;
            this.updateAllianceCityLeague(param1, _loc6_, param2, param3);
        }
        else {
            param2();
        }
    }

    private function updateAllianceCityLeague(param1:Number, param2:Number, param3:Function, param4:Function):void {
        var prototypeId:int = 0;
        var locationNoteId:Number = param1;
        var allianceId:Number = param2;
        var _onResult:Function = param3;
        var _onFault:Function = param4;
        prototypeId = instance.activeFlagsTournament.prototypeId;
        new GetAlliancesTournamentLeague(prototypeId, allianceId).ifResult(function (param1:int):void {
            var _loc2_:* = LocationNoteManager.getById(locationNoteId);
            if (_loc2_ && _loc2_.allianceCityInfo) {
                if (_loc2_.allianceCityInfo.tournamentIdToLeague == null) {
                    _loc2_.allianceCityInfo.tournamentIdToLeague = new Dictionary();
                }
                _loc2_.allianceCityInfo.tournamentIdToLeague[prototypeId] = param1;
                if (param1 > 0) {
                    if (_loc2_.allianceCityInfo.tournamentFlags == null) {
                        _loc2_.allianceCityInfo.tournamentFlags = new Vector.<AllianceCityFlag>();
                    }
                    _loc2_.allianceCityInfo.tournamentFlags.push(createOwnFlag(allianceId, locationNoteId, param1, prototypeId));
                }
            }
            LocationNoteManager.updateFlagNote(locationNoteId);
            if (_loc2_.allianceCityInfo.tournamentIdToLeague[prototypeId] != 0) {
                _onResult();
            }
            else {
                _onFault();
            }
        }).execute();
    }

    private function createOwnFlag(param1:Number, param2:Number, param3:int, param4:int):AllianceCityFlag {
        var _loc5_:AllianceCityFlag = new AllianceCityFlag();
        _loc5_.ownerAllianceId = param1;
        _loc5_.ownerCityId = param2;
        _loc5_.tournamentPrototypeId = param4;
        _loc5_.points = Global.serverSettings.allianceCityFlag.getFlagPointsByLeague(param3);
        _loc5_.league = param3;
        return _loc5_;
    }

    public function getFlagOwnerCityId(param1:Number):Number {
        var _loc4_:AllianceCityFlag = null;
        var _loc5_:AllianceCityFlagLocation = null;
        var _loc2_:LocationFlagData = LocationNoteManager.getFlagNotesById(param1);
        var _loc3_:Number = 0;
        if (instance.activeFlagsTournament) {
            for each(_loc4_ in _loc2_.tournamentFlags) {
                if (_loc4_.ownerCityId == _loc2_.id && this.isFlagActual(_loc4_)) {
                    _loc3_ = _loc4_.ownerCityId;
                    break;
                }
            }
            if (_loc3_ == 0) {
                for each(_loc5_ in _loc2_.tournamentFlagsLocations) {
                    if (_loc5_.tournamentPrototypeId == instance.activeFlagsTournament.prototypeId) {
                        _loc3_ = _loc5_.currentLocationCityId;
                        break;
                    }
                }
            }
        }
        return _loc3_;
    }

    public function getFlagOwnerAllianceId(param1:Number):Number {
        var _loc5_:AllianceCityFlag = null;
        var _loc6_:AllianceCityFlagLocation = null;
        var _loc2_:AllianceNote = AllianceNoteManager.getById(param1);
        var _loc3_:LocationFlagData = LocationNoteManager.getFlagNotesById(_loc2_.allianceCityId);
        var _loc4_:Number = 0;
        if (instance.activeFlagsTournament) {
            for each(_loc5_ in _loc3_.tournamentFlags) {
                if (_loc5_.ownerAllianceId == param1 && this.isFlagActual(_loc5_)) {
                    _loc4_ = _loc5_.ownerAllianceId;
                    break;
                }
            }
            if (_loc4_ == 0) {
                for each(_loc6_ in _loc3_.tournamentFlagsLocations) {
                    if (_loc6_.tournamentPrototypeId == instance.activeFlagsTournament.prototypeId) {
                        _loc4_ = _loc6_.currentLocationAllianceId;
                        break;
                    }
                }
            }
        }
        return _loc4_;
    }

    public function getFlagTypeByCityId(param1:Number):int {
        var _loc4_:int = 0;
        var _loc2_:int = 1;
        var _loc3_:LocationFlagData = LocationNoteManager.getFlagNotesById(param1);
        if (instance.activeFlagsTournament) {
            if (_loc3_.tournamentIdToLeague != null && _loc3_.tournamentIdToLeague[instance.activeFlagsTournament.prototypeId] != null) {
                _loc4_ = _loc3_.tournamentIdToLeague[instance.activeFlagsTournament.prototypeId];
                _loc2_ = Global.serverSettings.allianceCityFlag.getFlagTypeByLeague(_loc4_);
            }
        }
        return _loc2_;
    }

    public function hasForeignFlagsByCityId(param1:Number):Boolean {
        var _loc4_:AllianceCityFlag = null;
        var _loc2_:LocationFlagData = LocationNoteManager.getFlagNotesById(param1);
        var _loc3_:Boolean = false;
        for each(_loc4_ in _loc2_.tournamentFlags) {
            if (_loc4_.ownerCityId != _loc2_.id && this.isFlagActual(_loc4_)) {
                _loc3_ = true;
                break;
            }
        }
        return _loc3_;
    }

    public function getFlagIndicatorsByCityId(param1:Number):Object {
        var _loc6_:AllianceCityFlag = null;
        var _loc2_:LocationFlagData = LocationNoteManager.getFlagNotesById(param1);
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:Boolean = false;
        if (instance.activeFlagsTournament) {
            for each(_loc6_ in _loc2_.tournamentFlags) {
                if (this.isFlagActual(_loc6_)) {
                    _loc3_++;
                    _loc4_ = _loc4_ + _loc6_.points;
                    if (_loc6_.ownerCityId == param1) {
                        _loc5_ = true;
                    }
                }
            }
            if (_loc5_) {
                _loc4_ = _loc4_ * (100 + Global.serverSettings.allianceCityFlag.ownFlagKeepingBonusPercent) / 100;
            }
        }
        return {
            "points": _loc4_,
            "count": _loc3_
        };
    }

    public function getFlagPointsByLeague(param1:int):int {
        var _loc2_:LocationFlagData = LocationNoteManager.getFlagNotesById(param1);
        var _loc3_:int = 1;
        if (instance.activeFlagsTournament) {
            _loc3_ = _loc2_.tournamentIdToLeague[instance.activeFlagsTournament.prototypeId];
        }
        return Global.serverSettings.allianceCityFlag.getFlagPointsByLeague(_loc3_);
    }

    public function getFlagsCountByTypeInCity(param1:Number):Dictionary {
        var _loc2_:Dictionary = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:AllianceCityFlag = null;
        var _loc7_:int = 0;
        var _loc3_:LocationFlagData = LocationNoteManager.getFlagNotesById(param1);
        if (instance.activeFlagsTournament) {
            _loc4_ = Global.serverSettings.allianceCityFlag.getFlagTypeByLeague(1);
            _loc2_ = new Dictionary();
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc2_[_loc5_ + 1] = 0;
                _loc5_++;
            }
            for each(_loc6_ in _loc3_.tournamentFlags) {
                if (this.isFlagActual(_loc6_)) {
                    _loc7_ = Global.serverSettings.allianceCityFlag.getFlagTypeByLeague(_loc6_.league);
                    _loc2_[_loc7_]++;
                }
            }
        }
        return _loc2_;
    }

    public function isFlagActual(param1:AllianceCityFlag):Boolean {
        return instance.activeFlagsTournament && param1.tournamentPrototypeId == instance.activeFlagsTournament.prototypeId;
    }

    public function inLowerLeague(param1:Number):Boolean {
        var _loc2_:int = this.getFlagTypeByCityId(param1);
        var _loc3_:int = this.getFlagTypeByCityId(AllianceManager.currentAllianceCity.id);
        return _loc2_ < _loc3_ - 2;
    }

    public function lowerFlagsExist(param1:Number):Boolean {
        var _loc4_:AllianceCityFlag = null;
        var _loc5_:int = 0;
        var _loc2_:LocationFlagData = LocationNoteManager.getFlagNotesById(param1);
        var _loc3_:int = this.getFlagTypeByCityId(AllianceManager.currentAllianceCity.id);
        if (instance.activeFlagsTournament) {
            for each(_loc4_ in _loc2_.tournamentFlags) {
                _loc5_ = Global.serverSettings.allianceCityFlag.getFlagTypeByLeague(_loc4_.league);
                if (this.isFlagActual(_loc4_) && _loc5_ < _loc3_ - 2) {
                    return true;
                }
            }
        }
        return false;
    }
}
}
