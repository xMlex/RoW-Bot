package model.data.units.states {
public class UnitStateCanceling {


    public var TradingUnit:Boolean;

    public function UnitStateCanceling() {
        super();
    }

    public static function fromDto(param1:*):UnitStateCanceling {
        var _loc2_:UnitStateCanceling = new UnitStateCanceling();
        _loc2_.TradingUnit = param1.t;
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {"t": this.TradingUnit};
        return _loc1_;
    }
}
}
