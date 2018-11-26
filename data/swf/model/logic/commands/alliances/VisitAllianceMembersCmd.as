package model.logic.commands.alliances {
import model.data.alliances.AllianceNote;
import model.logic.AllianceNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class VisitAllianceMembersCmd extends BaseCmd {


    private var _allianceId:int;

    public function VisitAllianceMembersCmd(param1:int) {
        super();
        this._allianceId = param1;
    }

    override public function execute():void {
        var _loc1_:AllianceNote = AllianceNoteManager.getById(this._allianceId);
        new JsonCallCmd("VisitAllianceMembers", this._allianceId, "POST").setSegment(_loc1_.segmentId).ifResult(_onResult).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
