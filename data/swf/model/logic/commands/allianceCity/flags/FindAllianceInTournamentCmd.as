package model.logic.commands.allianceCity.flags {
import common.ArrayCustom;

import model.logic.AllianceNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.alliances.AllianceGetNotesCmd;
import model.logic.commands.locations.LocationGetNotesCmd;
import model.logic.commands.server.JsonCallCmd;

public class FindAllianceInTournamentCmd extends BaseCmd {


    private var _searchParam;

    public function FindAllianceInTournamentCmd(param1:String, param2:int) {
        super();
        this._searchParam = {
            "n": param1,
            "p": param2
        };
    }

    public function setLeague(param1:int):void {
        this._searchParam.l = param1;
    }

    override public function execute():void {
        new JsonCallCmd("FindAllianceInTournamentByName", this._searchParam, "POST").ifResult(function (param1:*):void {
            var allianceIds:* = undefined;
            var j:* = undefined;
            var dto:* = param1;
            allianceIds = new ArrayCustom();
            if (dto.i) {
                for (j in dto.i) {
                    allianceIds.addItem(j);
                }
            }
            new AllianceGetNotesCmd(allianceIds).ifResult(function ():void {
                var allianceId:* = undefined;
                var note:* = undefined;
                var cityIds:* = [];
                for each(allianceId in allianceIds) {
                    note = AllianceNoteManager.getById(allianceId);
                    if (note.allianceCityId > 0) {
                        cityIds.push(note.allianceCityId);
                    }
                }
                if (cityIds.length > 0) {
                    new LocationGetNotesCmd(cityIds).ifResult(function ():void {
                        if (_onResult != null) {
                            _onResult(allianceIds);
                        }
                    }).execute();
                }
                else if (_onResult != null) {
                    _onResult(allianceIds);
                }
            }).execute();
        }).ifFault(function (param1:*):void {
            if (_onFault != null) {
                _onFault(param1);
            }
        }).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
