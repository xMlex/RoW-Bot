package model.logic.commands.locations {
import model.data.locations.AntigenMutation;
import model.data.locations.Location;
import model.data.locations.LocationNote;
import model.data.users.troops.Troops;
import model.logic.LocationNoteManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.units.UnitUtility;

public class MutateTroopsCmd extends BaseCmd {


    private var _location:Location;

    private var _troops:Troops;

    private var _dto;

    public function MutateTroopsCmd(param1:Location, param2:Troops) {
        super();
        this._location = param1;
        this._troops = param2;
        this._dto = {
            "l": this._location.id,
            "t": param2.toDto()
        };
    }

    override public function execute():void {
        var note:LocationNote = LocationNoteManager.getById(this._location.id);
        new JsonCallCmd("MutateTroops", this._dto, "POST").setSegment(note.segmentId).ifResult(function (param1:*):void {
            _location.gameData.towerData.antigen = _location.gameData.towerData.antigen - param1.a;
            var _loc2_:* = Troops.fromDto(param1.t);
            var _loc3_:* = AntigenMutation.fromDto(param1.m);
            _location.gameData.towerData.antigenMutationHistory.addItemAt(_loc3_, 0);
            var _loc4_:* = UnitUtility.FindInSectorUnit2(_location, UserManager.user.id, -_location.id);
            if (_loc4_ != null) {
                _loc4_.troopsPayload.troops = _loc2_;
            }
            var _loc5_:* = UnitUtility.FindInSectorUnit(UserManager.user, UserManager.user.id, -_location.id);
            if (_loc5_ != null) {
                _loc5_.troopsPayload.troops = _loc2_;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
