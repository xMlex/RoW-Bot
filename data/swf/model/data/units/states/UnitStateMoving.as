package model.data.units.states {
public class UnitStateMoving {


    public var departureTime:Date;

    public var arrivalTime:Date;

    public var canceling:Boolean;

    public var hideInBunker:Boolean;

    public function UnitStateMoving() {
        super();
    }

    public static function fromDto(param1:*):UnitStateMoving {
        var _loc2_:UnitStateMoving = new UnitStateMoving();
        _loc2_.departureTime = param1.d == null ? null : new Date(param1.d);
        _loc2_.arrivalTime = param1.a == null ? null : new Date(param1.a);
        _loc2_.canceling = param1.c;
        _loc2_.hideInBunker = param1.h;
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "d": (this.departureTime == null ? null : this.departureTime.time),
            "a": (this.arrivalTime == null ? null : this.arrivalTime.time),
            "c": this.canceling,
            "h": this.hideInBunker
        };
        return _loc1_;
    }
}
}
