package model.logic.commands.alliances {
import common.ArrayCustom;

import model.data.alliances.Alliance;
import model.data.alliances.AllianceNote;
import model.logic.AllianceNoteManager;
import model.logic.LocationNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.locations.LocationGetNotesCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserGetNotesCmd;

public class AllianceVisitCmd extends BaseCmd {


    private var _allianceId:Number;

    private var _commandCNT:int = 0;

    public function AllianceVisitCmd(param1:Number) {
        super();
        this._allianceId = param1;
    }

    override public function execute():void {
        var allianceNote:AllianceNote = AllianceNoteManager.getById(this._allianceId);
        new JsonCallCmd("VisitAlliance", this._allianceId, "POST").setSegment(allianceNote.segmentId).ifResult(function (param1:*):void {
            var alliance:* = undefined;
            var waitAllianceResult:* = undefined;
            var waitLocationResult:* = undefined;
            var waitUserResult:* = undefined;
            var dto:* = param1;
            alliance = Alliance.fromVisitAllianceDto(dto);
            var unknownAllianceIds:* = getUnknownAllianceIds(alliance);
            var unknownUserIds:* = getUnknownUserIds(alliance);
            var unknwnLocationIds:* = getUnknownTowerIds(alliance);
            var result:* = _onResult;
            if (unknownAllianceIds.length > 0) {
                _commandCNT++;
                waitAllianceResult = true;
                new AllianceGetNotesCmd(unknownAllianceIds).onNotesLoaded(function (param1:ArrayCustom):void {
                    var allianceNote:* = undefined;
                    var allianceNotes:ArrayCustom = param1;
                    waitAllianceResult = false;
                    var unknownUserIds:* = new ArrayCustom();
                    for each(allianceNote in allianceNotes) {
                        if (!UserNoteManager.hasNote(allianceNote.ownerUserId)) {
                            unknownUserIds.addItem(allianceNote.ownerUserId);
                        }
                    }
                    if (unknownUserIds.length > 0) {
                        new UserGetNotesCmd(unknownUserIds).ifResult(function ():void {
                            _commandCNT--;
                            _onResultCall(alliance);
                        }).execute();
                    }
                    else {
                        _commandCNT--;
                    }
                    _onResultCall(alliance);
                }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
            }
            if (unknwnLocationIds.length > 0) {
                _commandCNT++;
                waitLocationResult = true;
                new LocationGetNotesCmd(unknwnLocationIds).ifResult(function ():void {
                    waitLocationResult = false;
                    _commandCNT--;
                    _onResultCall(alliance);
                }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
            }
            if (unknownUserIds.length > 0) {
                _commandCNT++;
                waitUserResult = true;
                new UserGetNotesCmd(unknownUserIds).ifResult(function ():void {
                    waitUserResult = false;
                    _commandCNT--;
                    _onResultCall(alliance);
                }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
            }
            _onResultCall(alliance);
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }

    private function _onResultCall(param1:Alliance):void {
        if (this._commandCNT == 0) {
            _onResult(param1);
        }
    }

    private function getUnknownAllianceIds(param1:Alliance):ArrayCustom {
        var _loc4_:Number = NaN;
        var _loc2_:ArrayCustom = new ArrayCustom();
        var _loc3_:Array = param1.gameData.knownAllianceData.getKnownAllianceIds();
        for each(_loc4_ in _loc3_) {
            if (!AllianceNoteManager.hasNote(_loc4_)) {
                _loc2_.addItem(_loc4_);
            }
        }
        return _loc2_;
    }

    private function getUnknownUserIds(param1:Alliance):ArrayCustom {
        var _loc4_:Number = NaN;
        var _loc2_:ArrayCustom = new ArrayCustom();
        var _loc3_:Array = param1.gameData.getKnownUserIds();
        for each(_loc4_ in _loc3_) {
            if (!UserNoteManager.hasNote(_loc4_)) {
                _loc2_.addItem(_loc4_);
            }
        }
        return _loc2_;
    }

    private function getUnknownTowerIds(param1:Alliance):ArrayCustom {
        var _loc4_:Number = NaN;
        var _loc2_:ArrayCustom = new ArrayCustom();
        var _loc3_:Array = param1.gameData.getKnownTowersIds();
        for each(_loc4_ in _loc3_) {
            if (!LocationNoteManager.hasNote(_loc4_)) {
                _loc2_.addItem(_loc4_);
            }
        }
        return _loc2_;
    }
}
}
