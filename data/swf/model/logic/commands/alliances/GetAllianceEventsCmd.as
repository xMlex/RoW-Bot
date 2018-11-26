package model.logic.commands.alliances {
import common.ArrayCustom;

import model.data.alliances.AllianceEventsDto;
import model.data.alliances.events.AllianceEventsFilter;
import model.data.alliances.events.AllianceEventsPosition;
import model.logic.AllianceNoteManager;
import model.logic.commands.server.JsonCallCmd;

public class GetAllianceEventsCmd extends BaseAllianceCmd {


    private var _dto;

    public function GetAllianceEventsCmd(param1:int, param2:int, param3:AllianceEventsFilter = null, param4:AllianceEventsPosition = null) {
        super();
        this._dto = {
            "o": param1,
            "c": param2
        };
        if (param3 != null) {
            this._dto.f = param3.toDto();
        }
        if (param4 != null) {
            this._dto.p = param4.toDto();
        }
    }

    override public function execute():void {
        new JsonCallCmd("GetAllianceEvents", this._dto, "POST").ifResult(function (param1:*):void {
            var result:* = undefined;
            var allianceEvent:* = undefined;
            var res:* = undefined;
            var dto:* = param1;
            result = AllianceEventsDto.fromDto(dto);
            var unknownAlliances:* = new ArrayCustom();
            for each(allianceEvent in result.events) {
                if (!isNaN(allianceEvent.firstAllianceId) && !AllianceNoteManager.hasNote(allianceEvent.firstAllianceId)) {
                    unknownAlliances.addItem(allianceEvent.firstAllianceId);
                }
                if (!isNaN(allianceEvent.secondAllianceId) && !AllianceNoteManager.hasNote(allianceEvent.secondAllianceId)) {
                    unknownAlliances.addItem(allianceEvent.secondAllianceId);
                }
            }
            if (unknownAlliances.length > 0) {
                res = _onResult;
                new AllianceGetNotesCmd(unknownAlliances).ifResult(function ():void {
                    if (res != null) {
                        if (_onResult != null) {
                            _onResult(result);
                        }
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
