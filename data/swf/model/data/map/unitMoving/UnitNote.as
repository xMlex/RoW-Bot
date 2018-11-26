package model.data.map.unitMoving {
import common.ArrayCustom;

import model.data.map.MapPos;
import model.data.units.Unit;
import model.data.users.UserNote;
import model.logic.UserManager;
import model.logic.UserNoteManager;

public class UnitNote {


    public var unitId:Number;

    public var ownerUserId:Number;

    public var targetUserId:Number;

    public var from:MapPos;

    public var to:MapPos;

    public var departure:Date;

    public var arrival:Date;

    public var kind:int;

    public var unit:Unit;

    public function UnitNote() {
        super();
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function fromDto(param1:*):UnitNote {
        if (param1 == null) {
            return null;
        }
        var _loc2_:UnitNote = new UnitNote();
        _loc2_.unitId = param1.i;
        _loc2_.ownerUserId = param1.o;
        _loc2_.targetUserId = param1.t;
        _loc2_.from = !!param1.f ? MapPos.fromDto(param1.f) : null;
        _loc2_.to = !!param1.p ? MapPos.fromDto(param1.p) : null;
        _loc2_.departure = !!param1.d ? new Date(param1.d) : null;
        _loc2_.arrival = !!param1.a ? new Date(param1.a) : null;
        _loc2_.kind = param1.k;
        return _loc2_;
    }

    public static function buildFromUnit(param1:Unit):UnitNote {
        if (param1 == null) {
            return null;
        }
        var _loc2_:UnitNote = new UnitNote();
        _loc2_.unitId = param1.UnitId;
        _loc2_.ownerUserId = param1.OwnerUserId;
        _loc2_.targetUserId = param1.TargetUserId;
        _loc2_.departure = param1.getDepartureTime();
        _loc2_.arrival = param1.getArrivalTime();
        _loc2_.unit = param1;
        if (param1.StateMovingForward) {
            _loc2_.from = UserManager.user.gameData.mapPos;
        }
        else {
            _loc2_.to = UserManager.user.gameData.mapPos;
        }
        return _loc2_;
    }

    public function get isMovingForward():Boolean {
        var _loc1_:UserNote = null;
        if (this.unit != null) {
            return this.unit.StateMovingForward != null;
        }
        _loc1_ = UserNoteManager.getById(this.ownerUserId, true);
        return _loc1_ && _loc1_.mapPos.isEqual(this.from);
    }
}
}
