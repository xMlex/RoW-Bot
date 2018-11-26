package model.data.map.unitMoving {
import common.ArrayCustom;

import model.data.locations.LocationNote;
import model.data.users.UserNote;
import model.logic.LocationNoteManager;
import model.logic.UnitNoteManager;
import model.logic.UserNoteManager;

public class MapRefreshOutput {


    public var blocks:Array;

    public var users:ArrayCustom;

    public var locations:ArrayCustom;

    public var units:ArrayCustom;

    public function MapRefreshOutput() {
        super();
    }

    public static function fromDto(param1:*):MapRefreshOutput {
        if (param1 == null) {
            return null;
        }
        var _loc2_:MapRefreshOutput = new MapRefreshOutput();
        if (param1.b) {
            _loc2_.blocks = MapTrackingBlock.fromDtos(param1.b);
        }
        if (param1.n) {
            _loc2_.users = UserNote.fromDtos(param1.n);
            UserNoteManager.update(_loc2_.users, true);
        }
        if (param1.l) {
            _loc2_.locations = LocationNote.fromDtos(param1.l);
            LocationNoteManager.update(_loc2_.locations, true);
        }
        if (param1.u) {
            _loc2_.units = UnitNote.fromDtos(param1.u);
            UnitNoteManager.update(_loc2_.units);
        }
        return _loc2_;
    }
}
}
