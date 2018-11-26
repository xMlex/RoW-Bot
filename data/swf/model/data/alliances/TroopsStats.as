package model.data.alliances {
public class TroopsStats {


    public var groupId:int;

    public var count:int;

    public var power:Number;

    public function TroopsStats() {
        super();
    }

    public static function fromDto(param1:*, param2:int = -1):TroopsStats {
        var _loc3_:TroopsStats = new TroopsStats();
        _loc3_.groupId = param2;
        _loc3_.count = param1.c == null ? 0 : int(param1.c);
        _loc3_.power = param1.p == null ? Number(0) : Number(param1.p);
        return _loc3_;
    }
}
}
