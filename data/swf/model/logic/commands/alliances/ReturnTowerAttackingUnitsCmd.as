package model.logic.commands.alliances {
import model.data.locations.LocationNote;
import model.logic.LocationNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class ReturnTowerAttackingUnitsCmd extends BaseCmd {


    private var _dto;

    private var _towerId:Number;

    public function ReturnTowerAttackingUnitsCmd(param1:Number) {
        super();
        this._dto = {"t": param1};
        this._towerId = param1;
    }

    override public function execute():void {
        var note:LocationNote = LocationNoteManager.getMineById(this._towerId);
        new JsonCallCmd("ReturnTowerAttackingUnits", this._dto, "POST").setSegment(note.segmentId).ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
