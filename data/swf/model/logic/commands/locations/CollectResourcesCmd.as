package model.logic.commands.locations {
import model.data.locations.Location;
import model.data.locations.LocationNote;
import model.logic.LocationNoteManager;
import model.logic.ServerTimeManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class CollectResourcesCmd extends BaseCmd {


    private var _location:Location;

    private var _dto;

    public function CollectResourcesCmd(param1:Location) {
        super();
        this._location = param1;
        this._dto = {"i": this._location.id};
    }

    override public function execute():void {
        var note:LocationNote = LocationNoteManager.getMineById(this._location.id);
        new JsonCallCmd("CollectMineResources", this._dto, "POST").setSegment(note.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            _location.gameData.mineData.lastCollectionTime = ServerTimeManager.serverTimeNow;
            if (_onResult != null) {
                _loc2_ = param1;
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
