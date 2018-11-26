package model.data.units.resurrection {
import model.data.users.troops.Troops;

public class ResurrectionKit {


    public var lossesLocation:int;

    public var lossesDate:Date;

    public var expirationDate:Date;

    public var losses:Troops;

    public var lossesType:int;

    public function ResurrectionKit() {
        super();
    }

    public static function fromDto(param1:*):ResurrectionKit {
        var _loc2_:ResurrectionKit = new ResurrectionKit();
        _loc2_.lossesLocation = param1.t;
        _loc2_.lossesDate = param1.d == null ? null : new Date(param1.d);
        _loc2_.expirationDate = param1.e == null ? null : new Date(param1.e);
        _loc2_.losses = Troops.fromDto(param1.l);
        _loc2_.lossesType = param1.o;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
