package model.data.units.states {
public class UnitStatePendingDepartureBack {


    public var desiredDepartureTime:Date;

    public function UnitStatePendingDepartureBack() {
        super();
    }

    public static function fromDto(param1:*):UnitStatePendingDepartureBack {
        var _loc2_:UnitStatePendingDepartureBack = new UnitStatePendingDepartureBack();
        _loc2_.desiredDepartureTime = param1.d == null ? null : new Date(param1.d);
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {"d": (this.desiredDepartureTime == null ? null : this.desiredDepartureTime.time)};
        return _loc1_;
    }
}
}
