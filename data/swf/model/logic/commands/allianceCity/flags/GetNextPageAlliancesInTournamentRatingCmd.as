package model.logic.commands.allianceCity.flags {
import common.ArrayCustom;

import configs.Global;

import flash.utils.Dictionary;

import model.data.alliances.AllianceNote;
import model.data.locations.LocationNote;
import model.data.locations.allianceCity.flags.AllianceCityFlag;
import model.data.ratings.RatingItem;
import model.data.users.UserNote;
import model.logic.AllianceNoteManager;
import model.logic.LocationNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.locations.LocationGetNotesCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserGetNotesCmd;

public class GetNextPageAlliancesInTournamentRatingCmd extends BaseCmd {


    private var _searchParam;

    private var _commandCNT:int = 0;

    private var _prototypeId:int;

    public function GetNextPageAlliancesInTournamentRatingCmd(param1:int, param2:int, param3:int) {
        super();
        this._prototypeId = param1;
        this._searchParam = {
            "p": param1,
            "c": param2,
            "d": param3
        };
    }

    public function setAllianceId(param1:Number):void {
        this._searchParam.a = param1;
    }

    public function setLeague(param1:int):void {
        this._searchParam.l = param1;
    }

    public function setInterLeagueRating(param1:Boolean):void {
        this._searchParam.i = param1;
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetNextPageAlliancesInTournamentRating", this._searchParam, "POST").ifResult(function (param1:*):void {
            var _topItems:* = undefined;
            var userNotes:* = undefined;
            var allianceNotes:* = undefined;
            var unknownUserIds:* = undefined;
            var cityIds:* = undefined;
            var note:* = undefined;
            var notes:* = undefined;
            var owners:* = undefined;
            var dto:* = param1;
            _topItems = RatingItem.fromDtos(dto.t);
            _topItems = clearDeletingAlliancesFromRating(_topItems);
            if (dto.u) {
                userNotes = UserNote.fromDtos(dto.u);
                UserNoteManager.update(userNotes);
            }
            if (dto.a) {
                allianceNotes = AllianceNote.fromDtos(dto.a);
                AllianceNoteManager.update(allianceNotes);
                if (allianceNotes != null && allianceNotes.length > 0) {
                    unknownUserIds = new ArrayCustom();
                    cityIds = [];
                    for each(note in allianceNotes) {
                        if (!UserNoteManager.hasNote(note.ownerUserId)) {
                            unknownUserIds.push(note.ownerUserId);
                        }
                        if (note.allianceCityId > 0) {
                            cityIds.push(note.allianceCityId);
                        }
                    }
                    if (unknownUserIds.length > 0) {
                        _commandCNT++;
                        new UserGetNotesCmd(unknownUserIds).ifResult(function ():void {
                            _commandCNT--;
                            _onResultCall(_topItems);
                        }).execute();
                    }
                    if (cityIds.length > 0) {
                        _commandCNT++;
                        new LocationGetNotesCmd(cityIds).ifResult(function ():void {
                            _commandCNT--;
                            updateFlagsInfo(_topItems);
                            _onResultCall(_topItems);
                        }).execute();
                    }
                }
            }
            if (dto.x) {
                notes = AllianceNote.fromDtos(dto.x);
                AllianceNoteManager.update(notes);
            }
            if (dto.o) {
                owners = UserNote.fromDtos(dto.o);
                UserNoteManager.update(owners);
            }
            _onResultCall(_topItems);
        }).ifFault(function (param1:*):void {
            if (_onFault != null) {
                _onFault(param1);
            }
        }).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }

    private function _onResultCall(param1:ArrayCustom):void {
        if (_onResult != null && this._commandCNT == 0) {
            _onResult(param1);
        }
    }

    private function clearDeletingAlliancesFromRating(param1:ArrayCustom):ArrayCustom {
        var _loc3_:RatingItem = null;
        if (param1 == null || param1.length == 0) {
            return param1;
        }
        var _loc2_:ArrayCustom = new ArrayCustom();
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc3_ = param1[_loc4_];
            if (_loc3_.Points >= 0) {
                _loc2_.push(_loc3_);
                _loc4_++;
                continue;
            }
            break;
        }
        return _loc2_;
    }

    private function updateFlagsInfo(param1:ArrayCustom):void {
        var _loc2_:LocationNote = null;
        var _loc3_:AllianceNote = null;
        var _loc4_:RatingItem = null;
        var _loc7_:AllianceCityFlag = null;
        var _loc5_:ArrayCustom = new ArrayCustom();
        var _loc6_:int = 0;
        while (_loc6_ < param1.length) {
            _loc4_ = param1[_loc6_];
            _loc3_ = AllianceNoteManager.getById(_loc4_.UserId);
            _loc2_ = LocationNoteManager.getById(_loc3_.allianceCityId);
            if (_loc2_.allianceCityInfo && (_loc2_.allianceCityInfo.tournamentIdToLeague == null || _loc2_.allianceCityInfo.tournamentIdToLeague[this._prototypeId] == null)) {
                _loc7_ = new AllianceCityFlag();
                _loc7_.ownerAllianceId = _loc3_.id;
                _loc7_.ownerCityId = _loc2_.id;
                _loc7_.tournamentPrototypeId = this._prototypeId;
                _loc7_.points = this.getFlagPoints(_loc4_.Points);
                _loc7_.league = Global.serverSettings.allianceCityFlag.allianceFlagsWeights.indexOf(_loc7_.points) + 1;
                if (_loc2_.allianceCityInfo.tournamentFlags == null) {
                    _loc2_.allianceCityInfo.tournamentFlags = new Vector.<AllianceCityFlag>();
                }
                _loc2_.allianceCityInfo.tournamentFlags.push(_loc7_);
                if (_loc2_.allianceCityInfo.tournamentIdToLeague == null) {
                    _loc2_.allianceCityInfo.tournamentIdToLeague = new Dictionary();
                }
                _loc2_.allianceCityInfo.tournamentIdToLeague[this._prototypeId] = _loc7_.league;
                _loc5_.push(_loc2_);
            }
            _loc6_++;
        }
        if (_loc5_.length > 0) {
            LocationNoteManager.update(_loc5_);
        }
    }

    private function getFlagPoints(param1:Number):int {
        var _loc2_:int = Global.serverSettings.allianceCityFlag.ownFlagKeepingBonusPercent;
        return param1 - int(param1 * _loc2_ / (100 + _loc2_));
    }
}
}
