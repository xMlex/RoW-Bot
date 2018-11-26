package model.logic.occupation.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.occupation.OccupationManager;
import model.logic.occupation.data.OccupiedUserNote;

public class OccupationRefreshUserNotesCmd extends BaseCmd {


    private var _dto;

    private var _userIds:Array;

    public function OccupationRefreshUserNotesCmd(param1:Array) {
        super();
        this._userIds = param1;
        this._dto = {"u": this._userIds};
    }

    override public function execute():void {
        new JsonCallCmd("Occupation.GetUsers", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = OccupiedUserNote.fromDtos(param1.o);
            OccupationManager.updateOccupiedUserNotes(_loc2_);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
