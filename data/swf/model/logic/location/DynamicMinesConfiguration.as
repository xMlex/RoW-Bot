package model.logic.location {
public class DynamicMinesConfiguration {


    public var miningDelayHours:Number;

    public var freeInactivityTimeoutHours:Number;

    public function DynamicMinesConfiguration() {
        super();
    }

    public static function fromDto(param1:*):DynamicMinesConfiguration {
        var _loc2_:DynamicMinesConfiguration = new DynamicMinesConfiguration();
        _loc2_.miningDelayHours = param1.d == null ? Number(Number.NaN) : Number(param1.d);
        _loc2_.freeInactivityTimeoutHours = param1.f == null ? Number(Number.NaN) : Number(param1.f);
        return _loc2_;
    }
}
}
