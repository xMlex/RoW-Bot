package model.logic.commands.alliances {
import model.data.alliances.Alliance;
import model.data.alliances.AllianceNote;
import model.data.users.UserNote;
import model.logic.AllianceNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.server.JsonCallCmd;

public class GetAllianceCmd extends BaseAllianceCmd {


    private var _dto;

    private var _allianceId:Number;

    public function GetAllianceCmd(param1:Number) {
        super();
        this._allianceId = param1;
        this._dto = this._allianceId;
    }

    override public function execute():void {
        var note:AllianceNote = AllianceNoteManager.getById(this._allianceId);
        new JsonCallCmd("GetAlliance", this._dto, "POST").setSegment(note.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = Alliance.fromDto(param1);
            var _loc3_:* = UserNote.fromDtos(param1.u);
            UserNoteManager.update(_loc3_);
            if (_onResult != null) {
                _onResult(_loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
