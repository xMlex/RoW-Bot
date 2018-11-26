package model.logic.map.commands {
import model.data.locations.LocationNote;
import model.data.map.MapPos;
import model.data.users.UserNote;
import model.logic.LocationNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetNoteByMapPosCmd extends BaseCmd {


    private var _mapPos:MapPos;

    public function GetNoteByMapPosCmd(param1:MapPos) {
        super();
        this._mapPos = param1;
    }

    override public function execute():void {
        new JsonCallCmd("GetNoteByMapPos", this._mapPos.toDto(), "POST").ifResult(function (param1:*):void {
            if (param1.u != null) {
                UserNoteManager.updateOne(UserNote.fromDto(param1.u));
            }
            if (param1.l != null) {
                LocationNoteManager.updateOne(LocationNote.fromDto(param1.l));
            }
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
