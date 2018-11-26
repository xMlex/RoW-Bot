package model.logic.commands.alliances {
import common.ArrayCustom;

import model.data.alliances.AllianceNote;
import model.logic.AllianceNoteManager;
import model.logic.commands.GetNotesBaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class AllianceGetNotesCmd extends GetNotesBaseCmd {


    private var _dto;

    public function AllianceGetNotesCmd(param1:ArrayCustom, param2:Boolean = false) {
        super();
        this._dto = param1;
        this.needDispatchUpdateEvent = param2;
    }

    override public function execute():void {
        new JsonCallCmd("GetAllianceNotes", this._dto).ifResult(function (param1:*):void {
            var _loc2_:* = AllianceNote.fromDtos(param1);
            AllianceNoteManager.update(_loc2_, needDispatchUpdateEvent);
            if (onLoadedCallback != null) {
                onLoadedCallback(_loc2_);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
