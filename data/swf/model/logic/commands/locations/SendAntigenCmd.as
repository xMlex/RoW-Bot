package model.logic.commands.locations {
import model.data.locations.AntigenTransfer;
import model.data.locations.Location;
import model.data.locations.LocationNote;
import model.logic.LocationNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class SendAntigenCmd extends BaseCmd {


    private var _location:Location;

    private var _destLocationId:Number;

    private var _antigen:Number;

    private var _dto;

    public function SendAntigenCmd(param1:Location, param2:Number, param3:Number) {
        super();
        this._location = param1;
        this._destLocationId = param2;
        this._antigen = param3;
        this._dto = {
            "s": this._location.id,
            "d": this._destLocationId,
            "a": param3
        };
    }

    override public function execute():void {
        var note:LocationNote = LocationNoteManager.getById(this._location.id);
        new JsonCallCmd("SendAntigen", this._dto, "POST").setSegment(note.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = AntigenTransfer.fromDto(param1.t);
            _location.gameData.towerData.antigenTransferHistory.addItemAt(_loc2_, 0);
            _location.gameData.towerData.antigen = _location.gameData.towerData.antigen - _antigen;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
