package model.logic.commands.alliances {
import common.ArrayCustom;

import model.data.alliances.AllianceProposalsDto;
import model.logic.AllianceNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserGetNotesCmd;

public class GetAllianceProposalsCmd extends BaseAllianceCmd {


    private var _dto;

    public function GetAllianceProposalsCmd(param1:Object) {
        super();
        this._dto = param1;
    }

    public static function MoveForward(param1:Number, param2:int):GetAllianceProposalsCmd {
        return new GetAllianceProposalsCmd({
            "h": param1,
            "c": param2
        });
    }

    public static function MoveLast(param1:int):GetAllianceProposalsCmd {
        return new GetAllianceProposalsCmd({
            "l": -2,
            "c": param1
        });
    }

    public static function MoveBack(param1:Number, param2:int):GetAllianceProposalsCmd {
        return new GetAllianceProposalsCmd({
            "l": param1,
            "c": param2
        });
    }

    public static function MyPos(param1:Number, param2:Number, param3:int):GetAllianceProposalsCmd {
        return new GetAllianceProposalsCmd({
            "a": param1,
            "x": param2,
            "c": param3
        });
    }

    public static function ToTop(param1:int):GetAllianceProposalsCmd {
        return new GetAllianceProposalsCmd({
            "l": 0,
            "h": 0,
            "c": param1
        });
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.GetProposalSearchItems", this._dto, "POST").ifResult(function (param1:*):void {
            var result:* = undefined;
            var unknownOwners:* = undefined;
            var alliance:* = undefined;
            var dto:* = param1;
            result = AllianceProposalsDto.fromDto(dto);
            var unknownAlliances:* = new ArrayCustom();
            unknownOwners = new ArrayCustom();
            for each(alliance in result.proposals) {
                if (!isNaN(alliance.allianceId) && !AllianceNoteManager.hasNote(alliance.allianceId)) {
                    unknownAlliances.addItem(alliance.allianceId);
                }
            }
            if (unknownAlliances.length > 0) {
                new AllianceGetNotesCmd(unknownAlliances).onNotesLoaded(function (param1:ArrayCustom):void {
                    var allianceNote:* = undefined;
                    var allianceNotes:ArrayCustom = param1;
                    for each(allianceNote in allianceNotes) {
                        if (!UserNoteManager.hasNote(allianceNote.ownerUserId)) {
                            unknownOwners.addItem(allianceNote.ownerUserId);
                        }
                    }
                    if (unknownOwners.length > 0) {
                        new UserGetNotesCmd(unknownOwners).ifResult(function ():void {
                            if (_onResult != null) {
                                _onResult(result);
                            }
                        }).execute();
                    }
                    else if (_onResult != null) {
                        _onResult(result);
                    }
                }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
            }
            else if (_onResult != null) {
                _onResult(result);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
