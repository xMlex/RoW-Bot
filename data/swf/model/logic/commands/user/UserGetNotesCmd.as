package model.logic.commands.user {
import common.ArrayCustom;

import model.data.users.UserNote;
import model.logic.UserNoteManager;
import model.logic.commands.GetNotesBaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class UserGetNotesCmd extends GetNotesBaseCmd {


    private var _dto;

    public function UserGetNotesCmd(param1:ArrayCustom, param2:ArrayCustom = null, param3:Boolean = false) {
        super();
        if (param1) {
            while (param1.getItemIndex(null) != -1) {
                param1.removeItemAt(param1.getItemIndex(null));
            }
            while (param1.getItemIndex(NaN) != -1) {
                param1.removeItemAt(param1.getItemIndex(NaN));
            }
        }
        this._dto = {
            "u": (!param1 ? [] : param1),
            "s": (!param2 ? [] : param2)
        };
        this.needDispatchUpdateEvent = param3;
    }

    override public function execute():void {
        var b1:Boolean = this._dto && this._dto.u && this._dto.u.length;
        var b2:Boolean = this._dto && this._dto.s && this._dto.s.length;
        if (!b1 && !b2) {
            if (_onResult != null) {
                _onResult();
            }
            return;
        }
        new JsonCallCmd("GetUserNotes", this._dto).ifResult(function (param1:*):void {
            var _loc2_:* = UserNote.fromDtos(param1.z == null ? param1 : param1.z);
            UserNoteManager.update(_loc2_, needDispatchUpdateEvent);
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
