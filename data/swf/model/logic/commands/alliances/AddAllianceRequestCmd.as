package model.logic.commands.alliances {
import model.data.alliances.AllianceMemberRankId;
import model.data.alliances.AllianceNote;
import model.data.users.alliances.UserAllianceRequest;
import model.logic.AllianceManager;
import model.logic.AllianceNoteManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class AddAllianceRequestCmd extends BaseCmd {


    private var _allianceId:Number;

    private var _dto;

    public function AddAllianceRequestCmd(param1:Number) {
        super();
        this._allianceId = param1;
        this._dto = {"a": this._allianceId};
    }

    override public function execute():void {
        var note:AllianceNote = AllianceNoteManager.getById(this._allianceId);
        new JsonCallCmd("Alliance.AddRequest", this._dto, "POST").setSegment(note.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = UserManager.user.gameData.allianceData;
            if (param1.r) {
                _loc2_.requests.addItem(UserAllianceRequest.fromDto(param1.r));
            }
            if (param1.m) {
                _loc2_.allianceId = _allianceId;
                _loc2_.rankId = AllianceMemberRankId.RECRUIT;
                AllianceManager.loadAlliance(UserManager.user);
            }
            _loc2_.dirty = true;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
