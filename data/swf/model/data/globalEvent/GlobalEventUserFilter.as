package model.data.globalEvent {
import model.data.scenes.types.info.RequiredObject;

public class GlobalEventUserFilter {


    public var adminsOnly:Boolean;

    public var requiredUserLevel:int;

    public var requiredObjects:Array;

    public var requiredDeposits:Number;

    public function GlobalEventUserFilter() {
        super();
    }

    public static function fromDto(param1:*):GlobalEventUserFilter {
        if (param1 == null) {
            return null;
        }
        var _loc2_:GlobalEventUserFilter = new GlobalEventUserFilter();
        _loc2_.adminsOnly = param1.a;
        _loc2_.requiredUserLevel = param1.l;
        _loc2_.requiredObjects = param1.o == null ? null : RequiredObject.fromDtos(param1.o);
        _loc2_.requiredDeposits = param1.p;
        return _loc2_;
    }
}
}
