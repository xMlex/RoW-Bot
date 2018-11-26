package model.logic.commands.locations {
import model.data.locations.LocationNote;
import model.logic.LocationNoteManager;
import model.logic.commands.GetNotesBaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class LocationGetNotesCmd extends GetNotesBaseCmd {


    private var _dto;

    public function LocationGetNotesCmd(param1:Array, param2:Boolean = false) {
        super();
        this._dto = {"i": param1};
        this.needDispatchUpdateEvent = param2;
    }

    override public function execute():void {
        new JsonCallCmd("GetLocationNotes", this._dto).ifResult(function (param1:*):void {
            var _loc2_:* = LocationNote.fromDtos(param1);
            LocationNoteManager.update(_loc2_, needDispatchUpdateEvent);
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
